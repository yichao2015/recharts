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
                  xcoord=NULL, ycoord=NULL, type="scatter", stack=FALSE,
                  title=NULL, subtitle=NULL, title_url=NULL, subtitle_url=NULL,
                  symbolList=NULL, dataZoom=NULL, 
                  dataRange=NULL, splitNumber=NULL, dataRangePalette=NULL,
                  xAxis=list(lab=NULL,color=NULL,splitLine=T,banded=F), xlab=NULL,
                  yAxis=list(lab=NULL,color=NULL,splitLine=T,banded=F), ylab=NULL,
                  xyflip=FALSE, AxisAtZero=TRUE, scale=TRUE,
                  palette='aetnagreen', tooltip=TRUE, legend=TRUE, toolbox=TRUE, 
                  pos=list(title=6, legend=11, toolbox=1, dataZoom=6, 
                           dataRange=8, roam=2),
                  calculable=TRUE, asImage=FALSE,
                  markLine=NULL, markPoint=NULL, ...){
    type <- tolower(type)
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
    loadpkg("plyr")
    loadpkg("reshape2")
    loadpkg("recharts","yihui/recharts")
    if (!all(as.numeric(pos) %in% 1:12)) stop("list pos must be all integers 1-12")
    pos <- mergeList(list(title=6, legend=11, toolbox=1, dataZoom=6, dataRange=8, 
                          roam=2),pos)
    
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
    if (!is.null(xcoord)) {
        xcoordvar <- substr(deparse(xcoord),2,nchar(deparse(xcoord)))
        xcoord <- evalFormula(xcoord,data)
    }
    if (!is.null(ycoord)) {
        ycoordvar <- substr(deparse(ycoord),2,nchar(deparse(ycoord)))
        ycoord <- evalFormula(ycoord,data)
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
    lstTitle[['x']] <- vecPos(pos[['title']])[1]
    lstTitle[['y']] <- vecPos(pos[['title']])[2]
    lstTitle[['orient']] <- vecPos(pos[['title']])[3]
    if (!is.null(title_url)) lstTitle[['link']] <- title_url
    if (!is.null(subtitle_url)) lstTitle[['sublink']] <- subtitle_url
    
    #-------Tooltip--------------
    if (tooltip){
        lstTooltip <- list(
            trigger=ifelse(type[1] %in% c('pie','ring','funnel','pyramid','map',
                                          'rose','wordcloud','radar','radarfill'),
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
        
        lstToolbox[['x']] <- vecPos(pos[['toolbox']])[1]
        lstToolbox[['y']] <- vecPos(pos[['toolbox']])[2]
        lstToolbox[['orient']] <- vecPos(pos[['toolbox']])[3]
        
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
    lstLegend[['x']] <- vecPos(pos[['legend']])[1]
    lstLegend[['y']] <- vecPos(pos[['legend']])[2]
    lstLegend[['orient']] <- vecPos(pos[['legend']])[3]
    
    
    #----------dataZoom----------
    lstdataZoom <- NULL
    
    if (!is.null(dataZoom)) {
        lstdataZoom <- list(show=T)
        if (pos[['dataZoom']] %in% c(8:10)){
            lstdataZoom[['x']] <- 0
        }else if (pos[['dataZoom']] %in% c(11:12,1,5:7)){
            lstdataZoom[['x']] <- 80
        }else if (pos[['dataZoom']] %in% c(2:4)){
            lstdataZoom[['x']] <- dev.size('px')[1]-80
        }
        if (pos[['dataZoom']] %in% c(8:10,2:4)){
            lstdataZoom[['y']] <- 60
        }else if (pos[['dataZoom']] %in% c(11:12,1)){
            lstdataZoom[['y']] <- 30
        }
        lstdataZoom[['orient']] <- vecPos(pos[['dataZoom']])[3]
        if (all(is.numeric(dataZoom))){
            if (any(!dataZoom>=0 | !dataZoom<=100)){
                stop("dataZoom should be between 0 and 100")
            }else{
                lstdataZoom[['start']] <- min(dataZoom[1],dataZoom[2])
                lstdataZoom[['end']] <- max(dataZoom[1],dataZoom[2])
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
                               as.numeric(splitNumber)),
            x= vecPos(pos[['dataRange']])[1],
            y= vecPos(pos[['dataRange']])[2],
            orient= vecPos(pos[['dataRange']])[3]
        )
    }
    
    #---------Grid------------------
    lstGrid <- NULL
    if (pos[['title']] %in% 5:7 && !is.null(subtitle)){
        lstGrid <- list(y2=80)
        if (type[1] %in% c('pie','ring','rose','funnel','pyramid','map',
                           'radar','radarfill','wordcloud')){
            lstGrid <- NULL
        }
    }
    
    #------------Axis-------------
    xAxis <- mergeList(list(lab=NULL,color=NULL,splitLine=T,banded=F),
                       xAxis)
    yAxis <- mergeList(list(lab=NULL,color=NULL,splitLine=T,banded=F),
                       yAxis)
    if (!is.null(xlab)) xAxis[['lab']]<-xlab
    if (!is.null(ylab)) yAxis[['lab']]<-ylab
    lstXAxis = list(
        name = ifelse(is.null(xAxis[['lab']]),xvar,xAxis[['lab']]),
        type = ifelse(inherits(x,c('POSIXct','POSIXlt','Date')),'time',
                      ifelse(!is.numeric(x),'category','value')),
        scale = scale)
    if (lstXAxis[['type']]=='category'){
        lstXAxis[['data']] <- unique(as.character(x))
    }
    if (type[1] %in% c('line','linesmooth','area','areasmooth')){
        lstXAxis[['boundaryGap']] <- F
    }
    lstYAxis = list(
        name = ifelse(is.null(yAxis[['lab']]),yvar,yAxis[['lab']]),
        type = 'value',
        scale = scale
    )
    if (is.null(xAxis[['color']])) xAxis[['color']] <- '#4488bb'
    if (xAxis[['color']]=='none'){
        lstXAxis[['axisLine']] <- list(show=F)
        lstYAxis[['splitLine']]<-list(show=F)
        if (!is.null(lstGrid)) lstGrid[['borderWidth']] <- 0
    }else if (!is(try(col2rgb(xAxis[['color']])),'try-error')){
        lstXAxis[['axisLine']] <- list(
            show=T, onZero=AxisAtZero, lineStyle=list(color=xAxis[['color']]))
        lstYAxis[['splitLine']]<-list(show=ifelse(xAxis[['splitLine']],T,F))
    }
    lstXAxis[['splitArea']]<-list(show=ifelse(xAxis[['banded']],T,F))
    
    if (is.null(yAxis[['color']])) yAxis[['color']] <- '#4488bb'
    if (yAxis[['color']]=='none'){
        lstYAxis[['axisLine']] <- list(show=F)
        lstXAxis[['splitLine']]<-list(show=F)
        if (!is.null(lstGrid)) lstGrid[['borderWidth']] <- 0
    }else if (!is(try(col2rgb(yAxis[['color']])),'try-error')){
        lstYAxis[['axisLine']] <- list(
            show=T, onZero=AxisAtZero, lineStyle=list(color=yAxis[['color']]))
        lstXAxis[['splitLine']]<-list(show=ifelse(yAxis[['splitLine']],T,F))
    }
    lstYAxis[['splitArea']]<-list(show=ifelse(yAxis[['banded']],T,F))
    
    if (xyflip){ #exchange settings of xAxis and yAxis
        tmp <- lstYAxis
        lstYAxis <- lstXAxis
        lstXAxis <- tmp
    }
    
    if (lstXAxis[['type']]=='time' | lstYAxis[['type']]=='time'){
        lstToolbox[['feature']][['magicType']] <- list(show=F)
        #lstXAxis[['name']] <- lstYAxis[['name']] <- NULL
        if (lstXAxis[['type']]=='time') {
            lstXAxis[['boundaryGap']] <- NULL
        }
        if (lstYAxis[['type']]=='time') {
            lstYAxis[['boundaryGap']] <- NULL
        }
    }
    
    #----------polar---------------
    if (type[1] %in% c('radar','radarfill')){
        x <- factor(x,levels=unique(x))
        indicator <- levels(x)
        lstPolar <- list(list(radius='70%', indicator=list()))
        for (i in 1:length(indicator)){
            lstPolar[[1]][['indicator']][[i]] <- list(
                text = as.character(indicator[i]),
                max = max(data[data[,xvar]==indicator[i],yvar]) * 1.25
            )
        }
    }
    
    #------------Series---------------
    lstSeries <- list()
    if (inherits(x,c('POSIXct','POSIXlt','Date'))) {
        x<- data[,xvar] <- format(data[,xvar],tz="GMT+8",format=
                                      "%a %b %d %Y %H:%M:%S GMT+0800 (China Standard Time)")
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
                        #lstSeries[[1]][['showAllSymbol']] <- T
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
                            #lstSeries[[i]][['showAllSymbol']] <- T
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
                    }else{
                        lstSeries[[1]][['itemStyle']] <- list(
                            emphasis=list(areaStyle=list(color='rgba(0,250,0,0.3)'))
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
                    }else{
                        lstSeries[[1]][['itemStyle']] <- list(
                            emphasis=list(areaStyle=list(color='rgba(0,250,0,0.3)'))
                        )
                    }
                    for (i in 1:length(lvlseries)){
                        lstSeries[[1]][['data']][[i]]<-list(
                            value = data[data[,svar]==lvlseries[i],yvar],
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
                        dset <- data[data[,svar]==lvlseries[i],]
                        lstSeries[[i]][['name']] <- lvlseries[i]
                    }
                    
                    if (mapMode=='area'){  #area mode
                        lstSeries[[i]][['itemStyle']]=list(
                            normal=list(label=list(show=F)),
                            emphasis=list(label=list(show=T))
                        )
                        for (j in 1:nrow(dset)){
                            lstSeries[[i]][['data']][[j]]<- list(
                                value=dset[j,yvar],name=as.character(dset[j,xvar])
                            )
                        }
                    }else{             #point mode
                        lstSeries[[i]][['data']] <- vector(mode='numeric')
                        lstSeries[[i]][['hoverable']] <- FALSE
                        lstSeries[[i]][['markPoint']] <- list(
                            symbolSize=ceiling(10/log10(nrow(dset))),
                            itemStyle=list(
                                normal=list(borderColor='#87cefa',
                                            borderWidth=1,
                                            label=list(show=F)),
                                emphasis=list(borderColor='#1e90ff',
                                              borderWidth=3,
                                              label=list(show=F))
                            )
                        )
                        for (j in 1:nrow(dset)){
                            lstSeries[[i]][['markPoint']][['data']][[j]] <- list(
                                value=dset[j,yvar],name=as.character(dset[j,xvar])
                            )
                            lstSeries[[i]][['geoCoord']][[dset[j,xvar]]] <-
                                c(dset[j,ycoordvar],dset[j,xcoordvar])
                        }
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
        if (! is.data.frame(markLine) & ! is.matrix(markLine)){
            stop("markLine should be a data.frame or a matrix.")
            if (!ncol(markLine) %in% c(4,8)) {
                stop("markLine should be of 4 or 6 columns")
            }
        }
        markLine <- as.data.frame(markLine,stringsAsFactors=F)
        if (ncol(markLine)==8){
            for (col in 3:7) markLine[,col]<-as.numeric(markLine[,col])
        }
        sermarkLine <- data.frame(name=levels(as.factor(markLine[,1])),
                                  ser=NA)
        names(sermarkLine) <- c(names(markLine)[1],'ser')
        for (i in 1:nrow(sermarkLine)){
            # locate the index of lstseries to update markline
            if (!is.na(as.numeric(as.character(sermarkLine[i,1])))){# series is index
                if (as.numeric(as.character(sermarkLine[i,1])) <= 
                    ifelse(is.null(series),1,length(lvlseries))){
                    sermarkLine[i,2] <- 
                        ifelse(is.null(series),1,as.numeric(as.character(sermarkLine[i,1])))
                }
            }else{
                if (!is.null(lvlseries)){
                    if (sermarkLine[i,1] %in% lvlseries){
                        sermarkLine[i,2] <- which(lvlseries==sermarkLine[i,1])
                    }
                }
                for (hor in 1:length(lstSeries)){
                    if (sermarkLine[i,1]==ifelse(is.null(lstSeries[[hor]][['name']]),
                                                 "",lstSeries[[hor]][['name']])){
                        sermarkLine[i,2] <- hor
                    }
                }
            }
            if (is.na(sermarkLine[i,2])){
                sermarkLine[i,2] <- length(lstSeries)+1
                lstSeries[[sermarkLine[i,2]]] <- list(
                    name=markLine[i,1],
                    type="scatter", 
                    data=matrix(markLine[i,4:7],byrow=T,nrow=2)
                )
                lstLegend[['data']][[sermarkLine[i,2]]] <- markLine[i,1]
            }
        }
        markLine <- plyr::join(markLine,sermarkLine,by=names(markLine)[1])
        
        for (i in 1:nrow(markLine)){  # loop over markLine
            if (ncol(markLine) %in% c(9)){ # full form
                if (any(is.na(as.numeric(markLine[i,3:7])))){
                    stop(paste("The",i,"th row of markLine is not in correct format."))
                }
                serIdx <- markLine[i,9]
                if (serIdx==1 | serIdx<=length(lstSeries)){
                    nLines <- length(lstSeries[[serIdx]][['markLine']][['data']])
                    lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                        list(list(name=ifelse(is.na(markLine[i,2]),
                                              paste("P(",round(markLine[i,3],2),",",
                                                    round(markLine[i,4],2),")"),
                                              markLine[i,2]),
                                  value=markLine[i,3],
                                  x=markLine[i,4],
                                  y=markLine[i,5]),
                             list(name=ifelse(is.na(markLine[i,2]),
                                              paste("P(",round(markLine[i,6],2),",",
                                                    round(markLine[i,7],2),")"),
                                              ""),
                                  x=markLine[i,6],
                                  y=markLine[i,7]))
                    if (type[1] %in% c('line','linesmooth','bar','k','scatter','bubble')){
                        lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                            list(list(name=ifelse(is.na(markLine[i,2]),
                                                  paste("P(",round(markLine[i,3],2),",",
                                                        round(markLine[i,4],2),")"),
                                                  markLine[i,2]),
                                      value=markLine[i,3],
                                      xAxis=markLine[i,4],
                                      yAxis=markLine[i,5]),
                                 list(name=ifelse(is.na(markLine[i,2]),
                                                  paste("P(",round(markLine[i,6],2),",",
                                                        round(markLine[i,7],2),")"),
                                                  ""),
                                      xAxis=markLine[i,6],
                                      yAxis=markLine[i,7]))
                    }
                }
                if (markLine[i,8]==T) { # effect
                    lstSeries[[serIdx]][['markLine']][['effect']] <- list(show=T)
                }
            }else if (ncol(markLine) %in% c(5)){  # short form
                serIdx <- markLine[i,5]
                if (type[1] %in% c('line','linesmooth','bar','scatter','bubble')){
                    if (tolower(markLine[i,3]) %in% c('min','max','average')){
                        if (serIdx==1 | serIdx<=length(lvlseries)){
                            nLines <- length(lstSeries[[serIdx]][['markLine']][['data']])
                            lstSeries[[serIdx]][['markLine']][['data']][[nLines+1]] <-
                                list(name=ifelse(is.na(markLine[i,2]),
                                                 tolower(markLine[i,3]),
                                                 markLine[i,2]),
                                     type=tolower(markLine[i,3]))
                        }
                    }else if (type[1] %in% c('bubble','scatter') & 
                              tolower(markLine[i,3]) == 'lm'){
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
                            list(list(name=ifelse(is.na(markLine[i,2]),
                                                  paste("P(",round(x1,2),",",
                                                        round(yhat[[1]],2),")"),
                                                  markLine[i,2]),
                                      value=round(k,2),
                                      xAxis=x1,
                                      yAxis=yhat[[1]]),
                                 list(name=ifelse(is.na(markLine[i,2]),
                                                  paste("P(",round(x2,2),",",
                                                        round(yhat[[2]],2),"), slope"),
                                                  ""),
                                      xAxis=x2,
                                      yAxis=yhat[[2]]))
                    }
                    if (markLine[i,4]==T) { # effect
                        lstSeries[[serIdx]][['markLine']][['effect']] <- list(show=T)
                    }
                }
            }
        }
    }
    
    #-------markPoint-----------------
    if (!is.null(markPoint)){
        if (! is.data.frame(markPoint) & ! is.matrix(markPoint)){
            stop("markPoint should be a data.frame or a matrix.")
            if (!ncol(markPoint) %in% c(4,6)) {
                stop("markPoint should be of 4 or 6 columns")
            }else if(ncol(markPoint)==6){
                for (col in 3:5) markPoint[,col]<-as.numeric(markPoint[,col])
            }
        }
        markPoint <- as.data.frame(markPoint,stringsAsFactors=F)
        sermarkPoint <- data.frame(name=levels(as.factor(markPoint[,1])),
                                   ser=NA)
        names(sermarkPoint) <- c(names(markPoint)[1],'ser')
        for (i in 1:nrow(sermarkPoint)){
            # locate the index of lstseries to update markPoint
            if (!is.na(as.numeric(as.character(sermarkPoint[i,1])))){  # series index
                if (as.numeric(as.character(sermarkPoint[i,1])) <= 
                    ifelse(is.null(series),1,length(lvlseries))){
                    sermarkPoint[i,2] <- 
                        ifelse(is.null(series),1,as.numeric(as.character(sermarkPoint[i,1])))
                }
            }else{
                if (!is.null(lvlseries)){
                    if (sermarkPoint[i,1] %in% lvlseries){
                        sermarkPoint[i,2] <- which(lvlseries==sermarkPoint[i,1])
                    }
                }
                for (hor in 1:length(lstSeries)){
                    if (sermarkPoint[i,1]==ifelse(is.null(lstSeries[[hor]][['name']]),
                                                  "",lstSeries[[hor]][['name']])){
                        sermarkPoint[i,2] <- hor
                    }
                }
            }
            if (is.na(sermarkPoint[i,2])){
                sermarkPoint[i,2] <- length(lstSeries)+1
                lstSeries[[sermarkPoint[i,2]]] <- list(
                    name=markPoint[i,1],
                    type="scatter", 
                    data=vector(mode="numeric")
                )
                if (type[1]=='map'){
                    lstSeries[[sermarkPoint[i,2]]][['type']] <- "map"
                    lstSeries[[sermarkPoint[i,2]]][['mapType']] <- type[2]
                    lstSeries[[sermarkPoint[i,2]]][['markPoint']] <- list(
                        symbolSize=JS('function(v){
                                      return 10+(v-',min(markPoint[,3]),')*',
                                      10/diff(range(markPoint[,3])),'}'),
                        itemStyle=list(
                            symbol='emptyCircle',
                            data=list()
                        )
                    )
            }
                lstLegend[['data']][[sermarkPoint[i,2]]] <- markPoint[i,1]
            }
        }
        markPoint <- plyr::join(markPoint,sermarkPoint,by=names(markPoint)[1])
        
        for (i in 1:nrow(markPoint)){  # loop over markPoint
            if (ncol(markPoint) %in% c(7)){ # full form
                if (any(is.na(as.numeric(markPoint[i,3:5])))){
                    stop(paste("The",i,"th row of markPoint is not of correct format."))
                }
                serIdx <- markPoint[i,7]
                if (serIdx==1 | serIdx<=length(lstSeries)){
                    nPoints <- length(lstSeries[[serIdx]][['markPoint']][['data']])
                    lstSeries[[serIdx]][['markPoint']][['data']][[nPoints+1]] <-
                        list(name=ifelse(is.na(markPoint[i,2]),
                                         paste("P(",round(markPoint[i,4],2),",",
                                               round(markPoint[i,5],2),")"),
                                         markPoint[i,2]),
                             value=round(as.numeric(markPoint[i,3]),2),
                             x=markPoint[i,4],
                             y=markPoint[i,5])
                    if (type[1] %in% c('line','linesmooth','bar','k','scatter')){
                        lstSeries[[serIdx]][['markPoint']][['data']][[nPoints+1]] <-
                            list(name=ifelse(is.na(markPoint[i,2]),
                                             paste("P(",round(markPoint[i,4],2),",",
                                                   round(markPoint[i,5],2),")"),
                                             markPoint[i,2]),
                                 value=round(as.numeric(markPoint[i,3]),2),
                                 xAxis=markPoint[i,4],
                                 yAxis=markPoint[i,5])
                    }else if (type[1] =='map'){
                        lstSeries[[serIdx]][['markPoint']][['data']][[nPoints+1]] <-
                            list(name=markPoint[i,2],
                                 value=round(as.numeric(markPoint[i,3]),2))
                        if (!any(is.na(markPoint[i,4:5]))){
                            lstSeries[[serIdx]][['geoCoord']][[markPoint[i,2]]] <-
                                c(markPoint[i,5],markPoint[i,4])
                        }
                    }
                }
                if (markPoint[i,6]==T) { # effect
                    lstSeries[[serIdx]][['markPoint']][['effect']] <- list(show=T,
                                                                           shadowBlur=0)
                }
                
            }else if (ncol(markPoint) %in% c(5)){  # short form
                serIdx <- markPoint[i,5]
                if (type[1] %in% c('line','linesmooth','bar','scatter','bubble')){
                    if (tolower(markPoint[i,2]) %in% c('min','max')){
                        if (serIdx==1 | serIdx<=length(lvlseries)){
                            nPoints <- length(lstSeries[[serIdx]][['markPoint']][['data']])
                            lstSeries[[serIdx]][['markPoint']][['data']][[nPoints+1]] <-
                                list(name=ifelse(is.na(markPoint[i,2]),
                                                 tolower(markPoint[i,3]),
                                                 markPoint[i,2]),
                                     type=tolower(markPoint[i,3]))
                        }
                    }
                    if (markPoint[i,4]==T) { # effect
                        lstSeries[[serIdx]][['markPoint']][['effect']] <- list(show=T)
                    }
                }
            }
            lstSeries[[serIdx]][['markPoint']][['symbolSize']] <- 9
            #lstSeries[[serIdx]][['markPoint']][['itemStyle']] <- 
            #    list(normal=list(label=list(show=F)))
            if (length(markPoint)>1000) {
                lstSeries[[serIdx]][['markPoint']][['large']] <- T
            }
        }
    }
    
    #-------SymbolList----------
    if (!is.null(lvlseries)){
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
    #if (!is.null(lstSeries[[1]][['name']]))   chartobj[['legend']] <- lstLegend
    if (!is.null(lvlseries))   chartobj[['legend']] <- lstLegend
    if (type[1] %in% c('scatter','bubble','line','bar','linesmooth','histogram',
                       'area','areasmooth')){
        chartobj[['xAxis']] <- lstXAxis
        chartobj[['yAxis']] <- lstYAxis
    }else if(type[1] %in% c('map')){
        chartobj[['roamController']] <- list(show=T,
                                             mapTypeControl=list(),
                                             width=60, height=90,
                                             x=vecPos(pos[['roam']])[1],
                                             y=vecPos(pos[['roam']])[2]
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
vecPos <- function(pos){
    TblPos=as.data.frame(rbind(c("right","top","horizontal"),
                               c("right","top","vertical"),
                               c("right","center","vertical"),
                               c("right","bottom","vertical"),
                               c("right","bottom","horizontal"),
                               c("center","bottom","horizontal"),
                               c("left","bottom","horizontal"),
                               c("left","bottom","vertical"),
                               c("left","center","vertical"),
                               c("left","top","vertical"),
                               c("left","top","horizontal"),
                               c("center","top","horizontal")),
                         stringsAsFactors=F)
    names(TblPos) <- c("x","y","z")
    return(as.vector(unlist(TblPos[pos,])))
}
