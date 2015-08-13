loadpkg <- function(pkg, url=NULL){
    if (! pkg %in% rownames(installed.packages())){
        if (is.null(url)){
            install.packages(pkg)
        }else{
            if (! 'devtools' %in% rownames(installed.packages())){
                install.packages('devtools')
            }
            require(devtools)
            install_github(url)
        }
    }
    require(package=pkg,c=T)
}
#-----------recharts--------------------
##----------pre-resiquite functions---------
evalFormula = function(x, data) { # by yihui xie
    if (!inherits(x, 'formula')) return(x)
    if (length(x) != 2) stop('The formula must be one-sided: ', deparse(x))
    eval(x[[2]], data, environment(x))
}
mergeList = function(x, y) { # by yihui xie
    if (!is.list(y) || length(y) == 0) return(x)
    yn = names(y)
    if (length(yn) == 0 || any(yn == '')) {
        warning('The second list to be merged into the first must be named')
        return(x)
    }
    for (i in yn) {
        xi = x[[i]]
        yi = y[[i]]
        if (is.list(xi)) {
            if (is.list(yi)) x[[i]] = mergeList(xi, yi)
        } else x[[i]] = yi
    }
    return(x)
}
isDate <- function(x,format=NULL){
    if (!is.null(format)){
        if (!is(try(as.Date(x),T),"try-error")) T else F
    }else{
        if (!is(try(as.Date(x,format=format),T),"try-error")) T else F
    }
}
isTime <- function(x,origin=NULL,tz='CST'){
    if (is.null(origin)){
        return(FALSE)
    }else{
        if (!is(try(as.POSIXct(x,origin=origin,tz=tz),T),"try-error")) T else F
    }
}
##----------draw dynamic charts using recharts---------------
echartR<-function(data,x=NULL,y,z=NULL,series=NULL,weight=NULL,
                  type="scatter",stack=FALSE,
                  title=NULL,subtitle=NULL,title_pos=c('center','bottom'),
                  symbolList=NULL,dataZoom=NULL,dataZoomRange=NULL,
                  dataRange=NULL,splitNumber=NULL,dataRangePalette=NULL,
                  xlab=NULL,ylab=NULL,xyflip=FALSE,AxisAtZero=FALSE,scale=TRUE,
                  palette='aetnagreen',tooltip=TRUE,legend=TRUE, 
                  legend_pos=c('left','top'),
                  toolbox=TRUE, toolbox_pos=c('right','top'),
                  calculable=TRUE, asImage=FALSE){
    type <- tolower(type)
    title_pos <- tolower(title_pos)
    toolbox_pos <- tolower(toolbox_pos)
    legend_pos <- tolower(legend_pos)
    supportedTypes <- c('scatter','bar','line','linesmooth','map','k','pie',
                        'chord', 'area','areasmooth','force','bubble','ring',
                        'funnel', 'pyramid', 'tree','treemap','wordcloud',
                        'heatmap','histogram', 'radar','radarfill','gauge')
    if (!type[1] %in% supportedTypes){
        stop("The chart type is not supported! ",
             "we now only support following charts:\n",
             supportedTypes)
    }
    loadpkg("Hmisc")
    loadpkg("reshape2")
    loadpkg("recharts","yihui/recharts")
    
    #-------pre-process of data-----------
    if (!is.null(y)) {      # y is mandatory
        yvar <- substr(deparse(y),2,nchar(deparse(y)))
        y <- evalFormula(y,data)
    }
    if (!is.null(x)) {
        xvar <- substr(deparse(x),2,nchar(deparse(x)))
        x <- evalFormula(x,data)
    }
    if (!is.null(series)) {
        svar <- substr(deparse(series),2,nchar(deparse(series)))
        series <- evalFormula(series,data)
    }
    if (!is.null(weight)) {
        wvar <- substr(deparse(weight),2,nchar(deparse(weight)))
        weight <- evalFormula(weight,data)
    }
    if (type[1] %in% c('bubble') & is.null(weight)){
        wvar <- yvar
        weight <- y
    }
    if (type[1] %in% c('pie','ring','funnel','pyramid')){
        if (is.null(series) & !is.null(x)){
            svar <- xvar
            data[,svar] <- x
            series <- x
        }
        series <- as.factor(series)
        data <- data[,c(svar,yvar)]
        if (is.factor(y) | is.character(y)){
            data <- dcast(data,data[,1]~.,value.var=yvar,length)
        }else{
            data <- dcast(data,data[,1]~.,value.var=yvar,sum)
        }
        names(data) <- c(svar,yvar)
    }else if (type[1] %in% c("histogram")){
        if (is.null(splitNumber)){
            nbreaks=10
        }else{
            nbreaks=ifelse(splitNumber==1,10,splitNumber+1)
        }
        interval <- (max(y)-min(y)) / (nbreaks-1)
        cut <- seq(from=min(y),to=max(y),length.out=nbreaks)
        x <- cut(y,breaks=cut)
        data <- as.data.frame(table(x))
        cut <- round(cut[1:length(cut)-1],
                     ifelse(interval>1,1,1+ceiling(log10(1/interval))))
        x <- paste(cut,"~",sep="")
        data[,1] <- paste(cut,"~",sep="")
        x[1] <- data[1,1] <- paste("~",cut[2],sep="")
        names(data) <- c(yvar,"Freq")
        y <- data[,'Freq']
        xvar <- yvar
        yvar <- "Freq"
    }else if (type[1] %in% c('line')){
        if (is.numeric(x)) {
            data[,xvar] <- x <- as.character(x)
        }
    }
    
    # -----Color--------
    if (is.null(palette)){
        lstColor <- NULL
    }else{
        lstColor <- as.list(funcPal(palette))
    }
    
    #--------Title and subtitle--------
    lstTitle <- list(text=ifelse(is.null(title),"",title),
                     subtext=ifelse(is.null(subtitle),"",subtitle),
                     padding=c(25,5,5,5))
    if (title_pos[1] %in% c('left','right','center') & 
        title_pos[2] %in% c('top','bottom','center')){
        lstTitle[['x']] <- title_pos[1]
        lstTitle[['y']] <- title_pos[2]
    }
    
    #-------Tooltip--------------
    if (tooltip){
        lstTooltip <- list(
            trigger=ifelse(type[1] %in% c('pie','ring','funnel','pyramid','map'),
                           'item','axis'),
            axisPointer = list(
                show= T,lineStyle= list(type= 'dashed',width= 1)
            )
        )
        if (inherits(x,c('POSIXlt','POSIXct'))){
            lstTooltip[['formatter']] <- JS('function (params) {
                                            var date = new Date(params.value[0]);
                                            data = date.getFullYear() + "-"
                                            + (date.getMonth() + 1) + "-"
                                            + date.getDate() + " "
                                            + date.getHours() + ":"
                                            + date.getMinutes();
                                            if (param.value.length > 2) {
                                            return data + "<br/>"
                                            + params.value[1] + ", "
                                            + params.value[2];                                            
                                            } else {
                                            return data + "<br/>"
                                            + params.value[1];
                                            }
                                            }'
                                            )
        }
        if (type[1] %in% c('scatter','bubble')){
            if (!is.null(series)){
                lstTooltip[['formatter']] <- JS('function (params) {
                                                if (params.value.length > 1) {
                                                return params.seriesName + " :<br/>"
                                                + params.value[0] + " ,    " +
                                                + params.value[1];
                                                } else {
                                                return params.seriesName + " :<br/>"
                                                + params.name + " : "
                                                + params.value;
                                                }}')
            }
            lstTooltip[['axisPointer']] <- list(
                show= T,type='cross',lineStyle= list(type= 'dashed',width= 1)
            )
        }else if (type[1] %in% c('ring','pie')){
            lstTooltip[['formatter']] <- "{a} <br/>{b} : {c} ({d}%)"
        }
    }else{
        lstTooltip = list(show=FALSE)
    }
    
    #-------------Toolbox----------------
    if (toolbox){
        lstToolbox= list(
            show = TRUE,
            feature = list(
                mark =list(show= TRUE,
                           title=list(mark="辅助线开关 Auxiliary conductor switch",
                                      markUndo="删除辅助线 Undo auxiliary conductor",
                                      markClear="清空辅助线 Clear auxiliary conductor")),
                dataView = list(show= TRUE, readOnly= FALSE,
                                title="数据视图 Data view"),
                magicType = list(show=FALSE),
                restore = list(show= TRUE,title="还原 Restore"),
                saveAsImage = list(show= TRUE,title="保存为图片 Save as image")
            )
        )
        if (toolbox_pos[1] %in% c('left','right','center') & 
            toolbox_pos[2] %in% c('top','bottom','center')){
            lstToolbox[['x']] <- toolbox_pos[1]
            lstToolbox[['y']] <- toolbox_pos[2]
            if (toolbox_pos[2] %in% c('center')){
                lstToolbox[['orient']] <- 'vertical'
            }
        }
        
        if (type[1] %in% c('line','linesmooth','bar','area','areasmooth',
                           'histogram')){
            lstToolbox[['feature']][['magicType']] <- 
                list(show=TRUE, type= c('line','bar','tiled','stack'))
        }else if (type[1] %in% c('ring','pie')){
            lstToolbox[['feature']][['magicType']] <- 
                list(show=TRUE, type= c('pie','funnel'),
                     option=list(funnel=list(x='25%',width='80%',
                                             funnelAlign='center')))
        }
        if (lstToolbox[['feature']][['magicType']][['show']]){
            lstToolbox[['feature']][['magicType']][['title']] <- list(
                line="折线图切换 Switch to line chart",
                bar="柱形图切换 Switch to bar chart",
                stack="堆积 Stack", 
                tiled="平铺 Tile",
                force="力导向布局图切换 Switch to force chart",
                pie="饼图切换 Switch to pie chart",
                funnel="漏斗图切换 Switch to funnel chart"
            )
        }
    }else{
        lstToolbox=list(show=FALSE)
    }
    
    #------Legend------------
    if (!legend){
        lstLegend= list(show=FALSE)
    }else if (nlevels(as.factor(series)) ==1){ 
        lstLegend= list(show=TRUE, data=levels(as.factor(x)))
    }else{
        lstLegend= list(show=TRUE, data=levels(as.factor(series)))
    }
    if (legend_pos[1] %in% c('left','right','center') & 
        legend_pos[2] %in% c('top','bottom','center')){
        lstLegend[['x']] <- legend_pos[1]
        lstLegend[['y']] <- legend_pos[2]
    }
    if (legend_pos[1] %in% c('left','right') & legend_pos[2]=='center'){
        lstLegend[['orient']] <- 'vertical'
    }
    
    #----------dataZoom----------
    lstdataZoom <- NULL
    if (!is.null(dataZoom)) {
        if (dataZoom){
            lstdataZoom <- list(show=T)
            if (!is.null(dataZoomRange) & is.numeric(dataZoomRange)){
                lstdataZoom[['start']] <- dataZoomRange[1]
                lstdataZoom[['end']] <- dataZoomRange[2]
            }
        }
    }
    
    #--------dataRange-----------
    lstdataRange <- NULL
    dRange <- dcast(data,data[,xvar]~., value.var=yvar, sum)
    dmin <- min(dRange[,2])
    dmax <- max(dRange[,2])
    if (!is.null(dataRange)) {
        if (!is.null(dataRangePalette)){
            lstdataRangePalette <- funcPal(dataRangePalette)
        }
        if (length(dataRange)<2)  dataRange=c(dataRange,"")
            lstdataRange <- list(
                show=T, calculable=ifelse(as.numeric(splitNumber)==0 | 
                                              is.null(splitNumber),calculable,F),
                text=as.vector(dataRange), itemGap=5,
                min=ifelse(dmin>0 & dmin-ceiling((dmax-dmin)/5)<0,
                           0, dmin-ceiling((dmax-dmin)/5)),
                max=dmax+ceiling((dmax-dmin)/10),
                color=lstdataRangePalette,
                splitNumber=ifelse(is.null(splitNumber),0,
                                   as.numeric(splitNumber)))
    }
    
    #------------Axis-------------
    if (!xyflip){
        lstXAxis = list(
            name = ifelse(is.null(xlab),xvar,xlab),
            type = ifelse(inherits(x,c('POSIXct','POSIXlt')),'time',
                          ifelse(!is.numeric(x),'category','value')),
            boundaryGap = c(0,0),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
        if (lstXAxis[['type']]=='category'){
            lstXAxis[['data']] <- unique(as.character(x))
        }
        lstYAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = 'value',
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
    }else{
        lstYAxis = list(
            name = ifelse(is.null(xlab),xvar,xlab),
            type = ifelse(inherits(x,c('POSIXct','POSIXlt')),'time',
                          ifelse(!is.numeric(x),'category','value')),
            boundaryGap = c(0,0),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
        if (lstYAxis[['type']]=='category') {
            lstYAxis[['data']] <- unique(as.character(x))
        }
        
        lstXAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = 'value',
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
    }
    if (lstXAxis[['type']]=='time' | lstYAxis[['type']]=='time'){
        lstToolbox[['feature']][['magicType']] <- list(show=F)
    }
    
    #----------polar---------------
    if (type[1] %in% c('radar','radarfill')){
        indicator <- as.factor(x)
        lstPolar <- list(list(indicator=list()))
        for (i in 1:nlevels(indicator)){
            lstPolar[[1]][['indicator']][[i]] <- list(
                text = as.character(indicator[i]),
                max = max(data[data[,xvar]==indicator[i],yvar]) * 1.25
            )
        }
    }
    
    #------------Series---------------
    lstSeries <- list()
    
    if (is.null(weight)){
        symbolSizeFold <- 1
    }else{
        symbolSizeFold <- ifelse(max(weight)>50,1/ceiling(max(weight)/50),
                                 ceiling(2/min(weight)))
    }
    
    if (type[1] %in% c('scatter','bubble')){
        if (is.null(series)){
            lstSeries[[1]] <- list(
                type='scatter',
                data=as.matrix(data[,c(xvar,yvar)]),
                large=ifelse(nrow(data)>10000,TRUE,FALSE)
            )
            if (type[1]=='bubble'){
                lstSeries[[1]][['data']] <-
                    as.matrix(data[,c(xvar,yvar,wvar)])
                lstSeries[[1]][['symbolSize']] <- 
                    JS('function (value){
                       return Math.round(value[2]*',symbolSizeFold,');}')
            }
        }else{
            for (i in 1:ifelse(is.null(series),1,nlevels(as.factor(series)))){
                lstSeries[[i]] <- list(
                    type='scatter',
                    data=as.matrix(data[data[,svar]==
                                            levels(as.factor(series))[i],
                                        c(xvar,yvar)]),
                    large=ifelse(nrow(data)>10000,T,F)
                )
                if (nlevels(as.factor(series))>1){
                    lstSeries[[i]][['name']] <-
                        as.vector(levels(as.factor(series))[i])
                }
                if (type[1]=='bubble'){
                    lstSeries[[i]][['data']] <-
                        as.matrix(data[data[,svar]==
                                           levels(as.factor(series))[i],
                                       c(xvar,yvar,wvar)])
                    lstSeries[[i]][['symbolSize']] <- 
                        JS('function (value){
                           return Math.round(value[2]*',symbolSizeFold,');
                     }')
                }
            }
        }
    }else if (type[1] %in% c('ring','pie')){
        lstSeries[[1]] <- list(
            name=svar,
            type='pie',
            data=list()
        )
        if (type[1]=='ring'){
            lstSeries[[1]][['radius']] <- c('60%','80%')
            lstSeries[[1]][['itemStyle']] <- list(
                emphasis = list(
                    label=list(
                        show=TRUE, position='center',
                        textStyle=list(fontSize='30',fontWeight='bold')
                    )
                )
            )
        }else{
            lstSeries[[1]][['radius']] <- '70%'
            lstSeries[[1]][['center']] <- c('50%','50%')
        }
        for (i in 1:nrow(data)){
            lstSeries[[1]][['data']][[i]]<- list(
                value=data[i,yvar],name=as.character(data[i,svar])
            )
        }
    }else if (type[1] %in% c('funnel','pyramid')){
        lstSeries[[1]] <- list(
            name=svar,
            type='funnel',
            data=list()
        )
        if (type[1]=='funnel'){
            lstSeries[[1]][['x']] <- '10%'
        }else{
            lstSeries[[1]][['x']] <- '25%'
            lstSeries[[1]][['sort']] <- 'ascending'
        }
        for (i in 1:nrow(data)){
            lstSeries[[1]][['data']][[i]]<- list(
                value=data[i,yvar],name=as.character(data[i,svar])
            )
        }
    }else if (type[1] %in% c('line','area','linesmooth','areasmooth')){
        #---------reformat missing value----------
        y[is.na(y)] <- data[is.na(data[,yvar]),yvar] <- '-'  
        
        if (is.null(series)){
            lstSeries[[1]] <- list(
                type='line',
                data=data[,yvar]
            )
            if (type[1] %in% c("area",'areasmooth')){
                lstSeries[[1]][['itemStyle']] <-
                    list(normal=list(areaStyle=list(type='default')))
            }
            if (type[1] %in% c('linesmooth','areasmooth')){
                lstSeries[[1]][['smooth']] <- TRUE
            }
            if (inherits(x,c('POSIXct','POSIXlt'))){
                lstSeries[[1]][['showAllSymbol']] <-T
                lstSeries[[1]][['data']] <- as.matrix(data[,c(xvar,yvar)])
            }
        }else{
            for (i in 1:ifelse(is.null(series),1,nlevels(as.factor(series)))){
                lstSeries[[i]] <- list(
                    name=as.vector(levels(as.factor(series))[i]),
                    type='line',
                    data=data[data[,svar]==levels(as.factor(series))[i],
                              yvar]
                )
                if (stack) lstSeries[[i]][['stack']] <- 'Stack'
                if (type[1] %in% c("area",'areasmooth')){
                    lstSeries[[i]][['itemStyle']] <-
                        list(normal=list(areaStyle=list(type='default')))
                }
                if (type[1] %in% c('linesmooth','areasmooth')) {
                    lstSeries[[i]][['smooth']] <- TRUE
                }
                if (inherits(x,c('POSIXct','POSIXlt'))){
                    lstSeries[[i]][['name']]<-levels(as.factor(series))[i]
                    lstSeries[[i]][['data']]<- as.matrix(
                        data[data[,svar]==levels(as.factor(series))[i],
                             c(xvar,yvar)])
                }
            }
        }
    }else if (type[1] %in% c('radar','radarfill')){
        if (is.null(series)){
            lstSeries[[1]] <- list(
                name=yvar,
                type='radar',
                data=list(value=data[,yvar],
                          name=yvar)
            )
            if (type[1]=='radarfill'){
                lstSeries[[1]][['itemStyle']] <- list(
                    normal=list(areaStyle=list(type='default'))
                )
            }
        }else{
            lstSeries[[1]] <- list(
                name=yvar,
                type='radar',
                data=list()
            )
            if (type[1]=='radarfill'){
                lstSeries[[1]][['itemStyle']] <- list(
                    normal=list(areaStyle=list(type='default'))
                )
            }
            for (i in 1:nlevels(as.factor(series))){
                lstSeries[[1]][['data']][[i]]<-list(
                    value = data[data[,svar]==
                                     levels(as.factor(series))[i],yvar],
                    name = as.vector(levels(as.factor(series))[i])
                )
            }
        }
    }else if (type[1] %in% c('map')){
        mapType <- ifelse(is.null(type[2]),'china',tolower(type[2]))
        mapMode <- ifelse(is.null(type[3]),'area',tolower(type[3]))
        for (i in 1:ifelse(is.null(series),1,nlevels(as.factor(series)))){
            lstSeries[[i]] <- list(
                type='map',
                mapType=mapType,
                roam=T,
                data=list()
            )
            if (is.null(series) | nlevels(as.factor(series))==1){
                dset <- data
                lstSeries[[i]][['name']] <- yvar
            }else{
                dset <- data[data[,svar]==levels(as.factor(series))[i],
                             c(xvar,yvar,svar)]
                lstSeries[[i]][['name']] <- levels(as.factor(series))[i]
            }
            
            if (mapMode=='area'){
                lstSeries[[i]][['itemStyle']]=list(
                    normal=list(label=list(show=F)),
                    emphasis=list(label=list(show=T))
                )
                for (j in 1:nrow(dset)){
                    lstSeries[[i]][['data']][[j]]<- list(
                        value=dset[j,yvar],name=as.character(dset[j,xvar])
                    )
                }
            }else{
                lstSeries[[i]][['markPoint']] <- list(
                    itemStyle=list(
                        normal=list(borderColor='#87cefa',
                                    borderWidth=1,
                                    label=list(show=F)),
                        emphasis=list(borderColor='#1e90ff',
                                      borderWidth=3,
                                      label=list(show=T))
                    ),
                    for (j in 1:nrow(dset)){
                        lstSeries[[i]][['markPoint']][['data']][[j]]<- list(
                            value=dset[j,yvar],name=as.character(dset[j,xvar])
                        )
                    }
                )
            }
        }
    }else{              # the rest charts
        if (is.null(series)){
            lstSeries[[1]] <- list(
                type=type[1],
                data=data[,yvar]
            )
            if (type[1]=='histogram'){
                lstSeries[[1]][['type']] <- 'bar'
                lstSeries[[1]][['barGap']] <- '1%'
            }
        }else{
            for (i in 1:ifelse(is.null(series),1,nlevels(as.factor(series)))){
                lstSeries[[i]] <- list(
                    name=as.vector(levels(as.factor(series))[i]),
                    type=type[1],
                    data=data[data[,svar]==levels(as.factor(series))[i],yvar]
                )
                if (stack){
                    lstSeries[[i]][['stack']] <- 'Stack'
                }
                if (type[1]=='histogram'){
                    lstSeries[[i]][['type']] <- 'bar'
                    lstSeries[[i]][['barGap']] <- '1%'
                }
            }
        }
    }
        
    #-------SymbolList----------
    if (!is.null(series)){
        if (length(symbolList)<nlevels(as.factor(series))){
            symbolList <- c(symbolList,
                            rep(symbolList[length(symbolList)],
                                nlevels(as.factor(series))-length(symbolList)))
        }
    }
    lstSymbol <- symbolList
    
    #-------Make plot-------------
    chartobj <- list(
        title=lstTitle,  tooltip=lstTooltip,
        toolbox=lstToolbox,
        calculable=calculable,
        series=lstSeries
    )
    if (!is.null(asImage)) chartobj[['renderAsImage']] <- asImage
    if (!is.null(lstColor)) chartobj[['color']] <- lstColor
    if (!is.null(lstSymbol)) chartobj[['symbolList']] <- lstSymbol
    if (!is.null(lstdataZoom)) chartobj[['dataZoom']] <- lstdataZoom
    if (!is.null(lstdataRange)) chartobj[['dataRange']] <- lstdataRange
    if (!is.null(series))   chartobj[['legend']] <- lstLegend
    if (type[1] %in% c('scatter','bubble','line','bar','linesmooth','histogram',
                       'area','areasmooth')){
        chartobj[['xAxis']] <- lstXAxis
        chartobj[['yAxis']] <- lstYAxis
    }else if(type[1] %in% c('map')){
        chartobj[['roamController']] <- list(show=T,
                                             mapTypeControl=list(),
                                             x='right',
                                             width=60, height=90
        )
        chartobj[['roamController']][['mapTypeControl']][[mapType]] <- T
    }else if (type[1] %in% c('radar','radarfill')){
        chartobj[['polar']] <- lstPolar
    }
    echart(chartobj)
    }

#-----Aetna palettes---------
aetnaPal <- function(palname,n=6){
    brewer= c('BrBG','PiYG','PRGn','PuOr','RdBu','RdGy','RdYlBu',
              'RdYlGn','Spectral','Accent','Dark2','Paired','Pastel1',
              'Pastel2','Set1','Set2','Set3','Blues','BuGn','BuPu',
              'GnBu','Greens','Greys','Oranges','OrRd','PuBu','PuBuGn',
              'PuRd','Purples','RdPu','Reds','YlGn','YlGnBu','YlOrBr',
              'YlOrRd')
    palname <- tolower(palname)
    if (palname %in% paste("aetna",
                           c('green','blue','teal','cranberry','orange','violet'),
                           sep="")){
        switch(palname,
               aetnagreen=c("#7AC143","#7D3F98","#F47721","#D20962","#00A78E",
                            "#00BCE4","#B8D936","#EE3D94","#FDB933","#F58F9F",
                            "#60C3AE","#5F78BB","#5E9732","#CEA979","#EF4135",
                            "#7090A5"),
               aetnablue=c("#00BCE4","#D20962","#7AC143","#F47721","#7D3F98",
                           "#00A78E","#F58F9F","#B8D936","#60C3AE","#FDB933",
                           "#EE3D94","#5E9732","#5F78BB","#CEA979","#EF4135",
                           "#7090A5"),
               aetnateal=c("#00A78E","#F47721","#7AC143","#00BCE4","#D20962",
                           "#7D3F98","#60C3AE","#FDB933","#B8D936","#5F78BB",
                           "#F58F9F","#EE3D94","#5E9732","#CEA979","#EF4135",
                           "#7090A5"),
               aetnacranberry=c("#D20962","#00BCE4","#7D3F98","#7AC143","#F47721",
                                "#00A78E","#F58F9F","#60C3AE","#EE3D94","#B8D936",
                                "#FDB933","#5E9732","#5F78BB","#CEA979","#EF4135",
                                "#7090A5"),
               aetnaorange=c("#F47721","#7AC143","#00A78E","#D20962","#00BCE4",
                             "#7D3F98","#FDB933","#B8D936","#60C3AE","#F58F9F",
                             "#5F78BB","#EE3D94","#5E9732","#CEA979","#EF4135",
                             "#7090A5"),
               aetnaviolet=c("#7D3F98","#7AC143","#F47721","#00A78E","#00BCE4",
                             "#D20962","#F58F9F","#B8D936","#FDB933","#60C3AE",
                             "#5F78BB","#EE3D94","#5E9732","#CEA979","#EF4135",
                             "#7090A5")
        )
    }else if (palname %in% tolower(brewer)){
        Palname <- brewer[which(tolower(brewer)==palname)]
        loadpkg("RColorBrewer")
        maxcolors <- brewer.pal.info[row.names(brewer.pal.info)==Palname,
                                     "maxcolors"]
        return(brewer.pal(maxcolors,Palname))
    }else if (palname %in% 
              c('calc','economist','economist_white','excel',
                'few','fivethirtyeight','gdocs','pander','tableau',
                'stata','tableau20','tableau10medium','tableaugray',
                'tableauprgy','tableaublrd','tableaugnor','tableaucyclic',
                'tableau10light', 'tableaublrd12','tableauprgy12',
                'tableaugnor12','hc','darkunica',
                'solarized','solarized_red','solarized_yellow',
                'solarized_orange','solarized_magenta','solarized_violet',
                'solarized_blue','solarized_cyan','solarized_green',
                'wsj','colorblind','trafficlight')){
        switch(palname,
               calc=c("#004586","#FF420E","#FFD320","#579D1C","#7E0021","#83CAFF",
                      "#314004","#AECF00","#4B1F6F","#FF950E","#C5000B","#0084D1"),
               excel=c("#FF00FF","#FFFF00","#00FFFF","#800080","#800000","#008080",
                       "#0000FF"),
               few=c("#F15A60","#7AC36A","#5A9BD4","#FAA75B","#9E67AB","#CE7058",
                     "#D77FB4"),
               economist=c("#6794a7","#014d64","#01a2d9","#7ad2f6","#00887d",
                           "#76c0c1","#7c260b","#ee8f71","#adadad"),
               economist_white=c("#76c0c1","#00887d","#adadad","#6794a7","#7ad2f6",
                                 "#014d64","#7c260b","#ee8f71","#a18376"),
               fivethirtyeight=c("#008FD5","#FF2700","#77AB43"),
               gdocs=c("#3366CC","#DC3912","#FF9900","#109618","#990099","#0099C6",
                       "#DD4477","#66AA00","#B82E2E","#316395","#994499","#22AA99",
                       "#AAAA11","#6633CC","#E67300","#8B0707","#651067","#329262",
                       "#5574A6","#3B3EAC"),
               hc=c("#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80",
                    "#e4d354","#8085e8"),
               darkunica=c("#2b908f","#90ee7e","#f45b5b","#7798BF","#aaeeee",
                           "#ff0066","#eeaaee","#55BF3B","#DF5353","#7798BF",
                           "#aaeeee"),
               pander=c("#56B4E9","#009E73","#F0E442","#0072B2","#D55E00",
                        "#CC79A7","#999999","#E69F00"),
               tableaugray=c("#60636A","#A5ACAF","#414451","#8F8782","#CFCFCF"),
               tableau=c("#1F77B4","#FF7F0E","#2CA02C","#D62728","#9467BD",
                         "#8C564B","#E377C2","#7F7F7F","#BCBD22","#17BECF"),
               tableau10medium=c("#729ECE","#FF9E4A","#67BF5C","#ED665D",
                                 "#AD8BC9","#A8786E","#ED97CA","#A2A2A2",
                                 "#CDCC5D","#6DCCDA"),
               tableau10light=c("#AEC7E8","#FFBB78","#98DF8A","#FF9896",
                                "#C5B0D5","#C49C94","#F7B6D2","#C7C7C7"),
               tableauprgy=c("#7B66D2","#DC5FBD","#5F5A41","#995688","#AB6AD5",
                             "#8B7C6E"),
               tableaublrd=c("#2C69B0","#F02720","#AC613C","#6BA3D6","#AC8763",
                             "#BD0A36"),
               tableaugnor=c("#32A251","#FF7F0F","#3CB7CC","#B85A0D","#39737C",
                             "#82853B"),
               tableaublrd12=c("#2C69B0","#B5C8E2","#F02720","#FFB6B0","#AC613C",
                               "#E9C39B","#6BA3D6","#B5DFFD","#AC8763","#DDC9B4",
                               "#BD0A36","#F4737A"),
               tableauprgy12=c("#7B66D2","#A699E8","#DC5FBD","#FFC0DA","#5F5A41",
                               "#B4B19B","#995688","#D898BA","#AB6AD5","#D098EE",
                               "#8B7C6E","#DBD4C5"),
               tableaugnor12=c("#32A251","#ACD98D","#FF7F0F","#FFB977","#3CB7CC",
                               "#98D9E4","#B85A0D","#FFD94A","#39737C","#86B4A9",
                               "#82853B","#CCC94D"),
               tableau20=c("#1F77B4","#AEC7E8","#FF7F0E","#FFBB78","#2CA02C",
                           "#98DF8A","#D62728","#FF9896","#9467BD","#C5B0D5",
                           "#8C564B","#C49C94","#E377C2","#F7B6D2","#7F7F7F",
                           "#C7C7C7","#BCBD22","#DBDB8D","#17BECF","#9EDAE5"),
               tableaucyclic=c("#1F83B4","#1696AC","#18A188","#29A03C","#54A338",
                               "#82A93F","#ADB828","#D8BD35","#FFBD4C","#FFB022",
                               "#FF9C0E","#FF810E","#E75727","#D23E4E","#C94D8C",
                               "#C04AA7","#B446B3","#9658B1","#8061B4","#6F63BB"),
               stata=c("#1a476f","#90353b","#55752f","#e37e00","#6e8e84","#c10534",
                       "#938dd2","#cac27e","#a0522d","#7b92a8","#2d6d66","#9c8847",
                       "#bfa19c","#ffd200","#d9e6eb"),
               solarized=c("#268bd2","#b58900","#cb4b16","#dc322f","#d33682",
                           "#6c71c4","#2aa198","#859900"),
               solarized_red=c("#dc322f","#b58900","#cb4b16","#d33682","#6c71c4",
                               "#268bd2","#2aa198","#859900"),
               solarized_yellow=c("#b58900","#cb4b16","#dc322f","#d33682","#6c71c4",
                                  "#268bd2","#2aa198","#859900"),
               solarized_orange=c("#cb4b16","#b58900","#dc322f","#d33682","#6c71c4",
                                  "#268bd2","#2aa198","#859900"),
               solarized_magenta=c("#d33682","#b58900","#cb4b16","#dc322f","#6c71c4",
                                   "#268bd2","#2aa198","#859900"),
               solarized_violet=c("#6c71c4","#b58900","#cb4b16","#dc322f","#d33682",
                                  "#268bd2","#2aa198","#859900"),
               solarized_blue=c("#268bd2","#b58900","#cb4b16","#dc322f","#d33682",
                                "#6c71c4","#2aa198","#859900"),
               solarized_cyan=c("#2aa198","#b58900","#cb4b16","#dc322f","#d33682",
                                "#6c71c4","#268bd2","#859900"),
               solarized_green=c("#859900","#b58900","#cb4b16","#dc322f","#d33682",
                                 "#6c71c4","#268bd2","#2aa198"),
               wsj=c("#c72e29","#016392","#be9c2e","#098154","#fb832d","#000000"),
               colorblind=c("#000000","#E69F00","#56B4E9","#009E73","#F0E442",
                            "#0072B2","#D55E00","#CC79A7"),
               trafficlight=c("#B10318","#DBA13A","#309343","#D82526","#FFC156",
                              "#69B764","#F26C64","#FFDD71")
        )
    }else if (palname %in% c('rainbow','terrain','topo','heat','cm')){
        switch(palname,
               rainbow=substr(rainbow(n),1,7),
               terrain=substr(terrain.colors(n),1,7),
               heat=substr(heat.colors(n),1,7),
               topo=substr(topo.colors(n),1,7),
               cm=substr(cm.colors(n),1,7)
        )
    }
}
funcPal <- function(palette){ # build a function to extract palette info
    if (length(palette)==1) {
        palettes <- unlist(strsplit(palette,"[\\(\\)]",perl=T))
        if (length(palettes)==1){
            return(aetnaPal(palettes[1]))
        }else{
            aetPal <- aetnaPal(palettes[1],as.numeric(palettes[2]))
            if (as.numeric(palettes[2])<length(aetPal)){
                #set.seed(61936962L)
                return(sample(aetPal,as.numeric(palettes[2])))
            }else{
                return(aetPal)
            }
        }
    }else if(length(palette)>1){
        aetPal <- vector()
        for (i in 1:length(palette)){
            if (!is(try(col2rgb(palette[i]),T),"try-error")){
                aetPal <- c(aetPal,rgb(col2rgb(palette[i])[[1]],
                                       col2rgb(palette[i])[[2]],
                                       col2rgb(palette[i])[[3]],
                                       maxColorValue = 255)
                )
            }
        }
        return(aetPal)
    }else{
        return(NULL)
    }
}
