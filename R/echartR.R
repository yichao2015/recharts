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
echartR<-function(data, x=NULL, y, z=NULL, series=NULL, weight=NULL,
                  xcoord=NULL, ycoord=NULL,
                  type="scatter", stack=FALSE,
                  title=NULL, subtitle=NULL, title_pos=c('center','bottom'),
                  title_url=NULL, subtitle_url=NULL,
                  symbolList=NULL, dataZoom=NULL, dataZoomRange=NULL,
                  dataRange=NULL, splitNumber=NULL, dataRangePalette=NULL,
                  xlab=NULL, ylab=NULL, xyflip=FALSE, AxisAtZero=FALSE, scale=TRUE,
                  palette='aetnagreen', tooltip=TRUE,
                  legend=TRUE, legend_pos=c('left','top'),
                  toolbox=TRUE, toolbox_pos=c('right','top'),
                  calculable=TRUE, asImage=FALSE, 
                  markLine=NULL, markPoint=NULL,
                  ...){
    type <- tolower(type)
    title_pos <- tolower(title_pos)
    toolbox_pos <- tolower(toolbox_pos)
    legend_pos <- tolower(legend_pos)
    supportedTypes <- c('scatter', 'bar', 'line', 'linesmooth', 'map', 'k', 'pie',
                        'ring', 'rose', 'chord', 'area', 'areasmooth', 'force',
                        'bubble', 'funnel', 'pyramid', 'tree','treemap',
                        'wordcloud', 'heatmap', 'histogram', 'radar', 'radarfill',
                        'gauge'
                        )
    if (!type[1] %in% supportedTypes){
        stop("The chart type is not supported! ",
             "we now only support the following charts:\n",
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
        lvlseries <- levels(as.factor(series))
    }else{
        lvlseries <- NULL
    }
    if (!is.null(weight)) {
        wvar <- substr(deparse(weight),2,nchar(deparse(weight)))
        weight <- evalFormula(weight,data)
    }
    if (type[1] %in% c('bubble') & is.null(weight)){
        wvar <- yvar
        weight <- y
    }
    if (type[1] %in% c('pie','ring','rose','funnel','pyramid')){
        if (is.null(series) & !is.null(x)){
            svar <- xvar
            data[,svar] <- x
            series <- x
        }
        series <- as.factor(series)
        lvlseries <- levels(series)
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
        lstColor <- as.list(funcPal(NULL))
    }else{
        nColor <- as.numeric(unlist(strsplit(palette,"[\\(\\)]",perl=T))[2])
        if (!is.na(nColor) & nColor < ifelse(is.null(series),1,length(lvlseries))){
            palette <- unlist(strsplit(palette,"[\\(\\)]",perl=T))[1]
        }
        lstColor <- as.list(funcPal(palette))
    }
    
    #--------Title and subtitle--------
    lstTitle <- list(text=ifelse(is.null(title),"",title),
                     subtext=ifelse(is.null(subtitle),"",subtitle))
    if (tolower(title_pos[1]) %in% c('left','right','center') & 
        tolower(title_pos[2]) %in% c('top','bottom','center')){
        lstTitle[['x']] <- title_pos[1]
        lstTitle[['y']] <- title_pos[2]
    }
    if (!is.null(title_url)) lstTitle[['link']] <- title_url
    if (!is.null(subtitle_url)) lstTitle[['sublink']] <- subtitle_url
    
    #-------Tooltip--------------
    if (tooltip){
        lstTooltip <- list(
            trigger=ifelse(type[1] %in% c('pie','ring','funnel','pyramid','map',
                                          'rose','wordcloud'),
                           'item','axis'),
            axisPointer = list(
                show= T,lineStyle= list(type= 'dashed',width= 1)
            )
        )
        if (inherits(x,c('POSIXlt','POSIXct','Date'))){
            lstTooltip[['trigger']] <- 'item'
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
                dataZoom = list(show=TRUE, title=
                                    list(dataZoom="区域缩放 Data zoom",
                                         dataZoomReset="区域缩放后退 Data zoom reset")),
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
        }else if (type[1] %in% c('ring','pie','rose')){
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
    }else{
        if (is.null(series)){
            lstLegend= list(show=TRUE, data=as.vector(yvar))
        }else if (length(lvlseries) ==1){ 
            lstLegend= list(show=TRUE, data=levels(as.factor(x)))
        }else{
            lstLegend= list(show=TRUE, data=lvlseries)
        }
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
            type = ifelse(inherits(x,c('POSIXct','POSIXlt','Date')),'time',
                          ifelse(!is.numeric(x),'category','value')),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
        if (lstXAxis[['type']]=='category'){
            lstXAxis[['data']] <- unique(as.character(x))
        }
        if (type[1] %in% c('line','linesmooth','area','areasmooth')){
            lstXAxis[['boundaryGap']] <- F
        }
        lstYAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = 'value',
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
    }else{
        lstYAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = ifelse(inherits(x,c('POSIXct','POSIXlt','Date')),'time',
                          ifelse(!is.numeric(x),'category','value')),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero)
        )
        if (lstYAxis[['type']]=='category') {
            lstYAxis[['data']] <- unique(as.character(x))
        }
        if (type[1] %in% c('line','linesmooth','area','areasmooth')){
            lstYAxis[['boundaryGap']] <- F
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
        #lstXAxis[['name']] <- lstYAxis[['name']] <- NULL
        if (lstXAxis[['type']]=='time') lstXAxis[['boundaryGap']] <- NULL
        if (lstYAxis[['type']]=='time') lstYAxis[['boundaryGap']] <- NULL
    }
    
    #---------Grid------------------
    
    if (title_pos[2]=='bottom' & !is.null(subtitle)){
        lstGrid <- list(y2=80)
        if (type[1] %in% c('pie','ring','rose','funnel','pyramid','map',
                            'radar','radarfill','wordcloud')){
            lstGrid <- NULL
        }
    }
    
    #----------polar---------------
    if (type[1] %in% c('radar','radarfill')){
        indicator <- as.factor(x)
        lstPolar <- list(list(radius='70%', indicator=list()))
        for (i in 1:nlevels(indicator)){
            lstPolar[[1]][['indicator']][[i]] <- list(
                text = as.character(indicator[i]),
                max = max(data[data[,xvar]==indicator[i],yvar]) * 1.25
            )
        }
    }
    
    #------------Series---------------
    lstSeries <- list()
    if (inherits(x,c('POSIXct','POSIXlt','Date'))) {
        x<- data[,xvar] <- format(data[,xvar],format="%a %b %d %Y %H:%M:%S")
    }
    
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
                large=ifelse(nrow(data)>2000,TRUE,FALSE)
            )
            if (type[1]=='bubble'){
                lstSeries[[1]][['data']] <-
                    as.matrix(data[,c(xvar,yvar,wvar)])
                lstSeries[[1]][['symbolSize']] <- 
                    JS('function (value){
                       return Math.round(value[2]*',symbolSizeFold,');}')
        }
            }else{
                for (i in 1:ifelse(is.null(series),1,length(lvlseries))){
                    lstSeries[[i]] <- list(
                        type='scatter',
                        data=as.matrix(data[data[,svar]==
                                                lvlseries[i],
                                            c(xvar,yvar)]),
                        large=ifelse(nrow(data)>2000,TRUE,FALSE)
                    )
                    if (length(lvlseries)>1){
                        lstSeries[[i]][['name']] <-
                            as.vector(lvlseries[i])
                    }
                    if (type[1]=='bubble'){
                        lstSeries[[i]][['data']] <-
                            as.matrix(data[data[,svar]==
                                               lvlseries[i],
                                           c(xvar,yvar,wvar)])
                        lstSeries[[i]][['symbolSize']] <- 
                            JS('function (value){
                               return Math.round(value[2]*',symbolSizeFold,');}')
            }
                }
                    }
                }else if (type[1] %in% c('ring','pie','rose')){
                    lstSeries[[1]] <- list(
                        name=svar,
                        type='pie',
                        data=list()
                    )
                    if (type[1]=='ring'){
                        lstSeries[[1]][['radius']] <- c('50%','70%')
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
                        if (type[1]=='rose'){
                            lstSeries[[1]][['roseType']] <- 'radius'
                        }
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
        }else if (type[1] %in% c('wordcloud')){
            lstSeries[[1]] <- list(
                name=yvar,
                type='wordCloud',
                size=c('80%','80%'),
                textRotation=c(0,45,90,-45),
                textPadding=0,
                autoSize=list(enable=T,minSize=10),
                data=list()
            )
            for (i in 1:nrow(data)){
                lstSeries[[1]][['data']][[i]]<- list(
                    value=data[i,yvar],name=as.character(data[i,xvar]),
                    itemStyle=list(normal=list(color=sample(unlist(lstColor),1)))
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
                if (lstXAxis[['type']]=='time' || lstYAxis[['type']]=='time'){
                    lstSeries[[1]][['name']] <- yvar
                    lstSeries[[1]][['showAllSymbol']] <- T
                    #lstSeries[[1]][['data']] <- as.matrix(data[,c(xvar,yvar)])
                    lstSeries[[1]][['data']] <- as.matrix(data[,c(xvar,yvar)])
                }
            }else{
                for (i in 1:ifelse(is.null(series),1,length(lvlseries))){
                    lstSeries[[i]] <- list(
                        name=as.vector(lvlseries[i]),
                        type='line',
                        data=data[data[,svar]==lvlseries[i],
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
                    if (lstXAxis[['type']]=='time' || lstYAxis[['type']]=='time'){
                        lstSeries[[i]][['name']] <- lvlseries[i]
                        lstSeries[[i]][['showAllSymbol']] <- T
                        lstSeries[[i]][['data']] <- as.matrix(
                            data[data[,svar]==lvlseries[i],
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
                for (i in 1:length(lvlseries)){
                    lstSeries[[1]][['data']][[i]]<-list(
                        value = data[data[,svar]==
                                         lvlseries[i],yvar],
                        name = as.vector(lvlseries[i])
                    )
                }
            }
        }else if (type[1] %in% c('map')){
            mapType <- ifelse(is.null(type[2]),'china',tolower(type[2]))
            mapMode <- ifelse(is.null(type[3]),'area',tolower(type[3]))
            for (i in 1:ifelse(is.null(series),1,length(lvlseries))){
                lstSeries[[i]] <- list(
                    type='map',
                    mapType=mapType,
                    roam=T,
                    data=list()
                )
                if (is.null(series) | length(lvlseries)==1){
                    dset <- data
                    lstSeries[[i]][['name']] <- yvar
                }else{
                    dset <- data[data[,svar]==lvlseries[i],
                                 c(xvar,yvar,svar)]
                    lstSeries[[i]][['name']] <- lvlseries[i]
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
                            lstSeries[[i]][['geoCoord']][[dset[j,xvar]]]<-c(
                                dset[j,ycoord],dset[j,xcoord]
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
                for (i in 1:ifelse(is.null(series),1,length(lvlseries))){
                    lstSeries[[i]] <- list(
                        name=as.vector(lvlseries[i]),
                        type=type[1],
                        data=data[data[,svar]==lvlseries[i],yvar]
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
    
    #-------markLine-----------------
    
    if (!is.null(markLine)){
        if (!is.list(markLine) || 
            !((length(unlist(markLine)) / length(markLine)) %in% c(2,6))){
            stop("markLine is not of the correct length! \n
                 Should be a list in length of either 2x or 6x.")
        }

        for (i in 1:length(markLine)){  # loop over markLine list
            # locate the index of lstseries to update markline
            if (!is.na(as.integer(markLine[[i]][[1]]))){  # series index
                if (as.integer(markLine[[i]][[1]]) <= 
                               ifelse(is.null(series),1,length(lvlseries))){
                    serIdx <- ifelse(is.null(series),1,as.integer(markLine[[i]][[1]]))
                }
            }else{
                if (is.null(series)){
                    serIdx <- 2
                }else if (markLine[[i]][[1]] %in% lvlseries){
                    serIdx <- which(lvlseries==markLine[[i]][[1]])
                }else{
                    serIdx <- length(lvlseries)+1
                }
            }
            if (length(unlist(markLine))/length(markLine)== 6){ # full form
                if (serIdx==1 | serIdx<=length(lvlseries)){
                    nLines <- length(lstSeries[[serIdx]][['markLine']])
                    lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                        list(list(name=paste("P(",round(markLine[[i]][[3]],2),",",
                                             round(markLine[[i]][[4]],2),")"),
                                  value=markLine[[i]][[2]],
                                  x=markLine[[i]][[3]],
                                  y=markLine[[i]][[4]]),
                             list(name=paste("Point",i,"End"),
                                  x=markLine[[i]][[5]],
                                  y=markLine[[i]][[6]]))
                    if (type[1] %in% c('line','linesmooth','bar','k','scatter')){
                        lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                            list(list(name=paste("P(",round(markLine[[i]][[3]],2),",",
                                                 round(markLine[[i]][[4]],2),")"),
                                      value=markLine[[i]][[2]],
                                      xAxis=markLine[[i]][[3]],
                                      yAxis=markLine[[i]][[4]]),
                                 list(name=paste("P(",round(markLine[[i]][[5]],2),",",
                                                 round(markLine[[i]][[6]],2),")"),
                                      xAxis=markLine[[i]][[5]],
                                      yAxis=markLine[[i]][[6]]))
                    }
                }else{ # a new series, create one
                    lstSeries[[serIdx]] <- list(
                        name=paste(markLine[[i]][[1]],"(",markLine[[i]][[2]],")"),
                        type="line", itemStyle=list(normal=list(
                            lineStyle=list(type='dashed'))),
                        data=matrix(markLine[[i]][3:6],byrow=T,nrow=2)
                    )
                    lstLegend[['data']][[serIdx]] <- 
                        paste(markLine[[i]][[1]],"(",markLine[[i]][[2]],")")
                }
            }else{  # short form
                if (type[1] %in% c('line','linesmooth','bar','scatter','bubble')){
                    if (tolower(markLine[[i]][[2]]) %in% c('min','max','average')){
                        if (serIdx==1 | serIdx<=length(lvlseries)){
                            nLines <- length(lstSeries[[serIdx]][['markLine']][['data']])
                            lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                                list(name=tolower(markLine[[i]][[2]]),
                                     type=tolower(markLine[[i]][[2]]))
                        }
                    }else if (type[1] %in% c('bubble','scatter') & 
                        tolower(markLine[[i]][[2]]) == 'lm'){
                        nLines <- length(lstSeries[[serIdx]][['markLine']][['data']])
    
                        if (is.null(series)){
                            lmfit <- lm(as.formula(paste(yvar,'~',xvar)),data)
                        }else{
                            dset <- subset(data,data[,svar]==lvlseries[serIdx])
                            lmfit <- lm(as.formula(paste(yvar,'~',xvar)),dset)
                        }
                        x1 <- min(data[,xvar])
                        x2 <- max(data[,xvar])
                        xhat <- data.frame(x=c(x1,x2))
                        names(xhat) <- xvar
                        yhat <- predict(lmfit,newdata=xhat)
                        k <- lmfit$coefficients[[2]]
                        lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                            list(list(name=paste("P(",round(x1,2),",",
                                                 round(yhat[[1]],2),")"),
                                      value=round(k,2),
                                      xAxis=x1,
                                      yAxis=yhat[[1]]),
                                 list(name=paste("P(",round(x2,2),",",
                                                 round(yhat[[2]],2),"), slope"),
                                      xAxis=x2,
                                      yAxis=yhat[[2]]))
                    }
                }
            }
        }
    }
    
    
    #-------SymbolList----------
    if (!is.null(series)){
        if (length(symbolList)<length(lvlseries)){
            symbolList <- c(symbolList,
                            rep(symbolList[length(symbolList)],
                                length(lvlseries)-length(symbolList)))
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
    if (try(exists("lstGrid"),T)) chartobj[['grid']] <- lstGrid
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
    brewer <- c('BrBG','PiYG','PRGn','PuOr','RdBu','RdGy','RdYlBu',
                'RdYlGn','Spectral','Accent','Dark2','Paired','Pastel1',
                'Pastel2','Set1','Set2','Set3','Blues','BuGn','BuPu',
                'GnBu','Greens','Greys','Oranges','OrRd','PuBu','PuBuGn',
                'PuRd','Purples','RdPu','Reds','YlGn','YlGnBu','YlOrBr',
                'YlOrRd')
    tableau <- data.frame(
        nick=c('tableau20','tableau10medium','tableaugray', 'tableauprgy',
               'tableaublrd','tableaugnor','tableaucyclic','tableau10light', 
               'tableaublrd12','tableauprgy12','tableaugnor12','tableau',
               'tableaucolorblind','trafficlight'),
        pal=c('tableau20','tableau10medium','gray5', 'purplegray6',
              'bluered6','greenorange6','cyclic','tableau10light', 
              'bluered12','purplegray12','greenorange12','tableau10',
              'colorblind10','trafficlight'))
    if (!is.null(palname)) palname <- tolower(palname)
    if (is.null(palname)){
        return(c( '#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed', 
                  '#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0', 
                  '#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700', 
                  '#6b8e23', '#ff00ff', '#3cb371', '#b8860b', '#30e0e0' ))
    }else if (palname %in% paste0("aetna",
                            c('green','blue','teal','cranberry','orange','violet'))){
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
    }else{
        if (palname %in% c('rainbow','terrain','topo','heat','cm')){
            switch(palname,
                   rainbow=substr(rainbow(n),1,7),
                   terrain=substr(terrain.colors(n),1,7),
                   heat=substr(heat.colors(n),1,7),
                   topo=substr(topo.colors(n),1,7),
                   cm=substr(cm.colors(n),1,7)
            )
        }else{
            loadpkg("ggthemes")
            loadpkg("scales")
            if (palname %in% c('pander')){
                colObj <- palette_pander(100)
                return(colObj[!is.na(colObj)])
            }else if (palname %in% c('excel',"excel_fill","excel_old","excel_new")){
                palname <- unlist(strsplit(palname,"excel_"))
                colObj <- eval(parse(text=paste0("excel_pal('",
                                                 ifelse(is.na(palname[2]),"line",palname[2]),
                                                 "')(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% c('economist','economist_white','economist_stata')){
                palname <- unlist(strsplit(palname,"economist_"))
                colObj <- eval(parse(text=paste0("economist_pal(stata=",
                                                 ifelse(palname[2]=='stata',T,F),
                                                 ",fill=",ifelse(palname[2]=='white',F,T),
                                                 ")(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% c('darkunica')){
                colObj <- eval(parse(text=paste0("hc_pal('",palname,"')(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% c('wsj','wsj_rgby','wsj_red_green','wsj_black_green',
                                     'wsj_dem_rep')){
                palname <- unlist(strsplit(palname,"wsj_"))
                colObj <- eval(parse(text=paste0("wsj_pal('",
                                                 ifelse(is.na(palname[2]),'colors6',
                                                        palname[2]),"')(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% c('stata','stata1','stata1r','statamono')){
                palname <- switch(palname, stata='s2color', stata1='s1color',
                                  stata1r='s1rcolor',statamono='mono')
                colObj <- eval(parse(text=paste0("stata_pal('",palname,"')(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% 
                      c('calc', 'few','fivethirtyeight','gdocs',
                        'stata','hc','colorblind')){
                colObj <- eval(parse(text=paste0(palname,"_pal()(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% 
                      c('tableau20','tableau10medium','tableaugray', 'tableauprgy',
                        'tableaublrd','tableaugnor','tableaucyclic','tableau10light', 
                        'tableaublrd12','tableauprgy12','tableaugnor12','tableau',
                        'tableaucolorblind','trafficlight')){
                palname <- tableau[tableau$nick==palname,"pal"]
                colObj <- eval(parse(text=paste0("tableau_color_pal(palette='",
                                                 palname,"')(100)")))
                return(colObj[!is.na(colObj)])
            }else if (palname %in% 
                      c('solarized','solarized_red','solarized_yellow',
                        'solarized_orange','solarized_magenta','solarized_violet',
                        'solarized_blue','solarized_cyan','solarized_green')){
                palname <- unlist(strsplit(palname,"solarized_"))
                colObj <- eval(parse(text=paste0("solarized_pal('",
                                                 ifelse(is.null(palname[2]),'blue',palname[2]),
                                                 "')(100)")))
                return(colObj[!is.na(colObj)])
            }
        }
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
        return(aetnaPal(NULL))
    }
}
