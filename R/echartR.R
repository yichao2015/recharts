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
##----------presiquite function---------
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
##----------draw dynamic charts using recharts---------------
echartR<-function(data,x,y,series=NULL,weight=NULL,type="scatter",stack=FALSE,
                  title=NULL,subtitle=NULL,
                  xlab=NULL,ylab=NULL,xyflip=FALSE,AxisAtZero=TRUE,scale=TRUE,
                  palette='aetnagreen',tooltip=TRUE,legend=TRUE, 
                  legend_pos=c('center','top'),
                  toolbox=TRUE, calculable=TRUE){
    type <- tolower(type)
    if (!type %in% c('scatter','bar','line','map','k','pie','chord','force',
                     'tree','treemap','wordcloud','heatmap','histogram','bubble',
                     'ring')){
        stop("The chart type is not supported! ",
             "we now only support following charts:\n",
             "scatter, bar, line, map, k, pie, chord, force, bubble, ",
             "tree, treemap, wordcloud, heatmap, histogram,ring")
    }
    loadpkg("Hmisc")
    loadpkg("reshape2")
    loadpkg("recharts","yihui/recharts")
    aetPal <- aetnaPal(tolower(palette))
    if (is.null(aetPal)){
        lstColor <- NULL
    }else{
        lstColor <- as.list(aetPal)
    }
    lstTitle <- list(text=ifelse(is.null(title),"",title),
                     subtext=ifelse(is.null(subtitle),"",subtitle),
                     x='center',y='bottom',padding=c(50,5,5,5))
    if (tooltip){
        lstTooltip <- list(
            trigger=ifelse(type %in% c('pie','ring'),
                           'item','axis'),
            axisPointer = list(
                show= T,lineStyle= list(type= 'dashed',width= 1)
            ),
            showDelay = 0
        )
        if (type %in% c('scatter','bubble')){
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
                    }
                }')
            }
            lstTooltip[['axisPointer']] <- list(
                show= T,type='cross',lineStyle= list(type= 'dashed',width= 1)
            )
        }else if (type %in% c('ring','pie')){
            lstTooltip[['formatter']] <- "{a} <br/>{b} : {c} ({d}%)"
        }
    }else{
        lstTooltip = list(show=FALSE)
    }
    if (toolbox){
        lstToolbox= list(
            show = TRUE,
            feature = list(
                mark =list(show= TRUE),
                dataView = list(show= TRUE, readOnly= TRUE),
                magicType = list(show=FALSE),
                restore = list(show= TRUE),
                saveAsImage = list(show= TRUE)
            )
        )
        
        if (type %in% c('line','bar')){
            lstToolbox[['feature']][['magicType']] <- 
                list(show=TRUE, type= c('line','bar','tiled','stack'))
        }else if (type %in% c('funnel','ring','pie')){
            lstToolbox[['feature']][['magicType']] <- 
                list(show=TRUE, type= c('pie','funnel'),
                     option=list(funnel=list(x='25%',width='50%',
                                             funnelAlign='center')))
        }
    }else{
        lstToolbox=list(show=FALSE)
    }
    
    if (!is.null(x)) xvar <- substr(deparse(x),2,nchar(deparse(x)))
    if (!is.null(y)) yvar <- substr(deparse(y),2,nchar(deparse(y)))
    if (!is.null(series)) svar <- substr(deparse(series),2,nchar(deparse(series)))
    if (!is.null(weight)) wvar <- substr(deparse(weight),2,nchar(deparse(weight)))
    if (!is.null(x)) x <- evalFormula(x,data)
    if (!is.null(y)) y <- evalFormula(y,data)
    if (!is.null(series)) series <- evalFormula(series,data)
    if (!is.null(weight)) weight <- evalFormula(weight,data)
    
    #-------pre-process of data-----------
    if (type %in% c('bubble') & is.null(weight)){
        wvar <- yvar
        weight <- y
    }
    if (type %in% c('pie','ring')){
        if (is.null(series) & !is.null(x)){
            svar <- xvar
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
    }
    
    if (!legend){
        lstLegend= list(show=FALSE)
    }else if (!is.null(series)){ 
        lstLegend= list(show=TRUE, data=levels(as.factor(series)))
    }else{
        lstLegend= list(show=TRUE, data=levels(x))
    }
    if (legend_pos[1] %in% c('left','right','center') & 
        legend_pos[2] %in% c('top','bottom','center')){
        lstLegend[['x']] <- legend_pos[1]
        lstLegend[['y']] <- legend_pos[2]
    }
    if (legend_pos[1] %in% c('left','right') & legend_pos[2]=='center'){
        lstLegend[['orient']] <- 'vertical'
    }
    
    if (!xyflip){
        lstXAxis = list(
            name = ifelse(is.null(xlab),xvar,xlab),
            type = ifelse(is.factor(x),'category','value'),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero),
            data = list()
        )
        if (is.factor(x)){
            lstXAxis[['data']] <- unique(x)
        }
        lstYAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = 'value',
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero),
            data = list()
        )
        
    }else{
        lstYAxis = list(
            name = ifelse(is.null(xlab),xvar,xlab),
            type = ifelse(is.factor(x),'category','value'),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero),
            data = list()
        )
        if (is.factor(x)) {
            lstYAxis[['data']] <- unique(x)
        }
        
        lstXAxis = list(
            name = ifelse(is.null(ylab),yvar,ylab),
            type = 'value',
            boundaryGap = c(0,0),
            scale = scale,
            axisLine = list(show=T, onZero=AxisAtZero),
            data = list()
        )
    }

    lstSeries <- list()
    if (is.null(weight)){
        symbolSizeFold <- 1
    }else{
        symbolSizeFold <- ifelse(max(weight)>50,1/ceiling(max(weight)/50),
                                 ceiling(2/min(weight)))
    }

    if (type %in% c('scatter','bubble')){
        if (is.null(series)){
            tmpMtx <- as.matrix(data[,c(xvar,yvar)])
            dimnames(tmpMtx) <- NULL
            lstSeries[[1]] <- list(
                type='scatter',
                data=tmpMtx
            )
            if (type=='bubble'){
                lstSeries[[1]][['data']] <-
                    as.matrix(data[,c(xvar,yvar,wvar)])
                lstSeries[[1]][['symbolSize']] <- 
                    JS('function (value){
                       return Math.round(value[2]*',symbolSizeFold,');
                    }')
            }
        }else{
            for (i in 1:ifelse(is.null(series),1,nlevels(series))){
                lstSeries[[i]] <- list(
                    name=  as.vector(levels(series)[i]),
                    type='scatter',
                    symbol='circle',
                    data=as.matrix(data[data[,svar]==
                                            levels(series)[i],c(xvar,yvar)])
                )
                if (type=='bubble'){
                    lstSeries[[i]][['data']] <-
                        as.matrix(data[data[,svar]==
                                           levels(series)[i],c(xvar,yvar,wvar)])
                    lstSeries[[i]][['symbolSize']] <- 
                        JS('function (value){
                            return Math.round(value[2]*',symbolSizeFold,');
                        }')
                }
            }
        }
    }else if (type %in% c('ring','pie')){
        lstSeries[[1]] <- list(
            name=svar,
            type='pie',
            data=list()
        )
        if (type=='ring'){
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
            lstSeries[[1]][['radius']] <- '60%'
            lstSeries[[1]][['center']] <- c('50%','50%')
        }
        for (i in 1:nrow(data)){
            lstSeries[[1]][['data']][[i]]<- list(
                value=data[i,2],name=as.character(data[i,1])
            )
        }
    }else{
        if (is.null(series)){
            lstSeries[[1]] <- list(
                type=type,
                data=data[,yvar]
            )
        }else{
            for (i in 1:ifelse(is.null(series),1,nlevels(series))){
                lstSeries[[i]] <- list(
                    name=as.vector(levels(series)[i]),
                    type=type,
                    data=data[data[,svar]==levels(series)[i],yvar]
                )
                if (stack){
                    lstSeries[[i]][['stack']] <- 'Stack'
                }
            }
        }
    }

    chartobj <- list(
        title=lstTitle,  tooltip=lstTooltip,
        toolbox=lstToolbox,
        calculable=calculable,
        series=lstSeries
    )
    if (!is.null(lstColor)) chartobj[['color']] <- lstColor
    if (!is.null(series))   chartobj[['legend']] <- lstLegend
    if (type %in% c('scatter','bubble','line','bar')){
        chartobj[['xAxis']] <- lstXAxis
        chartobj[['yAxis']] <- lstYAxis
    }
    echart(chartobj)
}






#-----Aetna palettes---------
aetnaPal <- function(palname){
    if (tolower(palname) %in% paste("aetna",
                           c('green','blue','teal','cranberry','orange','violet'),
                           sep="")){
        switch(tolower(palname),
            aetnagreen=c("#7AC143","#7D3F98","#F47721","#D20962","#00A78E",
                         "#00BCE4","#B8D936","#EE3D94","#FDB933","#F58F9F",
                         "#60C3AE","#5F78BB","#5E9732","#CEA979","#EF4135",
                         "#7090A5"),
            aetnablue=c("#00BCE4","#D20962","#7AC143","#F47721","#7D3F98","#00A78E",
                   "#F58F9F","#B8D936","#60C3AE","#FDB933","#EE3D94","#5E9732",
                   "#5F78BB","#CEA979","#EF4135","#7090A5"),
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
    }
    if (palname %in% c('BrBG','PiYG','PRGn','PuOr','RdBu','RdGy','RdYlBu',
                       'RdYlGn','Spectral','Accent','Dark2','Paired','Pastel1',
                       'Pastel2','Set1','Set2','Set3','Blues','BuGn','BuPu',
                       'GnBu','Greens','Greys','Oranges','OrRd','PuBu','PuBuGn',
                       'PuRd','Purples','RdPu','Reds','YlGn','YlGnBu','YlOrBr',
                       'YlOrRd')){
        loadpkg("RColorBrewer")
        maxcolors <- brewer.pal.info[row.names(brewer.pal.info)==palname,
                                     "maxcolors"]
        return(brewer.pal(maxcolors,palname))
    }
    if (tolower(palname) %in% c('calc','economist','economist_white','excel',
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
    }
}