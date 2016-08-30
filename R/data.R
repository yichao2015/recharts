#' @importFrom data.table melt
series_scatter <- function(lst, type, return=NULL, ...){
    # g = echartr(mtcars, wt, mpg, am)
    lst <- mergeList(list(weight=NULL, series=NULL), lst)
    if (!is.numeric(lst$x[,1])) stop('x and y must be numeric')
    data <- cbind(lst$y[,1], lst$x[,1])

    if (!is.null(lst$weight)){  # weight as symbolSize
        data <- cbind(data, lst$weight[,1])
        minWeight <- min(abs(lst$weight[,1]), na.rm=TRUE)
        maxWeight <- max(abs(lst$weight[,1]), na.rm=TRUE)
        range <- maxWeight - minWeight
        folds <- maxWeight / minWeight
        if (abs(folds) < 50){  # max/min < 50, linear
            jsSymbolSize <- JS(paste0('function (value){
                return ', switch(ceiling(abs(folds)/10), 4,3.5,3,2.5,2),
                '*Math.round(Math.abs(value[2]/', minWeight,'));
                }'))
        }else{  # max/min >= 50, normalize
            jsSymbolSize <- JS(paste0('function (value){
                return Math.round(1+29*(Math.abs(value[2])-', minWeight,')/', range, ');
            }'))
        }
    }
    obj <- list()
    if (is.null(lst$series)) {  # no series
        if (is.null(lst$weight)){
            obj <- list(list(type=type$type[1], data=asEchartData(data[,2:1])))
        }else{
            obj <- list(list(type=type$type[1], data=asEchartData(data[,c(2:1,3)])))
            if (grepl('bubble', type$misc[1])) obj[[1]]$symbolSize <- jsSymbolSize
        }
    }else{  # series-specific
        data <- cbind(data, lst$series[,1])
        data <- split(as.data.frame(data), lst$series[,1])
        if (is.null(lst$weight)){
            obj <- lapply(seq_along(data), function(i){
                list(name = names(data)[i], type = type$type[i],
                     data = asEchartData(data[[i]][,2:1]))
            })  ## only fetch col 1-2 of data, col 3 is series
        }else{
            obj <- lapply(seq_along(data), function(i){
                out <- list(name = names(data)[i], type = type$type[i],
                            data = asEchartData(data[[i]][,c(2:1, 3)]))
                if (grepl('bubble', type$misc[i])) out$symbolSize <- jsSymbolSize
                return(out)
            })  ## fetch col 1-2 and 3 (x, y, weight)
        }
    }

    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }
}

series_bar <- function(lst, type, return=NULL, ...){
    # example:
    # echartr(mtcars, row.names(mtcars), mpg,
    #     series=factor(am,labels=c('Manual','Automatic')),
    #     type=c('hbar','scatter'))
    lst <- mergeList(list(series=NULL), lst)
    data <- cbind(lst$y[,1], lst$x[,1])

    if (!'y' %in% names(lst)) {  # y is null, then...
        if (grepl('hist', type$misc)){  # histogram
            hist <- hist(data[,1], plot=FALSE)
            if (grepl('density', type$misc)){
                data <- as.matrix(cbind(hist$density, hist$mids))  # y, x
            }else{
                data <- as.matrix(cbind(hist$counts, hist$mids))  # y, x
            }
        }else{ # simply run freq of x
            if (is.numeric(data[,1])){
                data <- as.matrix(as.data.frame(table(data[,1])))
            }else{
                data <- as.matrix(table(data[,1]))
            }
        }
    }

    obj <- list()
    if (is.null(lst$series)) {  # no series
        if (is.numeric(lst$x[,1])){
            obj <- list(list(type=type$type[1], data=asEchartData(data[,2:1])))
            if (any(grepl("flip", type$misc))) obj[[1]]$barHeight=10
            if (grepl('hist',type$misc)) {
                obj[[1]]$barGap = '1%'
                obj[[1]]$barWidth = JS(paste0(
                    "(document.getElementById('temp').offsetWidth-200)/",
                    length(hist$breaks)))
                obj[[1]]$barMaxWidth = floor(820 / length(hist$breaks))
            }
        }else{
            obj <- list(list(type=type$type[1], data=asEchartData(data[,1])))
        }
    }else{  # series-specific
        dataCross <- tapply(data[,1], list(data[,2], lst$series[,1]), function(x) {
            if (length(x) == 1) return(x)
            stop('y must only have one value corresponding to each combination of x and series')
        })
        idx <- match(unique(data[,2]),rownames(dataCross))
        dataCross <- dataCross[idx,]
        #rownames(dataCross) <- data[,2]
        data <- dataCross

        obj <- lapply(seq_len(ncol(data)), function(i){
            if (is.numeric(lst$x[,1])){
                o = list(name = colnames(data)[i], type = type$type[i],
                         data = asEchartData(cbind(as.numeric(rownames(data)),
                                                        data[,i])))
                if (any(grepl("flip", type$misc)))
                    o <- mergeList(o, list(barHeight=10))
            }else{
                o = list(name = colnames(data)[i], type = type$type[i],
                         data = asEchartData(data[,i]))
            }
            if (type$stack[i]) o[['stack']] = 'Group'
            return(o)
        })
    }

    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }
}

series_line = function(lst, type, return=NULL, ...) {
    # Example:
    # g=echartr(airquality, as.character(Day), Temp,z=Month, type='curve')
    # g=echartr(airquality, as.character(Day), Temp,z=Month, type='area_smooth')
    lst <- mergeList(list(series=NULL), lst)
    data <- cbind(lst$y[,1], lst$x[,1])

    if (is.null(lst$x[,1]) && is.ts(lst$y[,1])) {
        lst$x[,1] = as.numeric(time(lst$y[,1]))
        lst$y[,1] = as.numeric(lst$y[,1])
    }
    obj <- list()

    if (is.numeric(lst$x[,1])) {
        obj = series_scatter(lst, type = type)
    }else{
        if (is.null(lst$series[,1])) {
            obj = list(list(type = 'line', data = asEchartData(lst$y[,1])))
        }
    }
    if (length(obj) == 0) obj = series_bar(lst, type = type)

    # area / stack / smooth
    areaIdx <- which(grepl("fill", type$misc))
    stackIdx <- which(type$stack)
    smoothIdx <- which(type$smooth)
    if (length(areaIdx) > 0){
        for (i in areaIdx)  obj[[i]][['itemStyle']] <-
                list(normal=list(areaStyle=list(
                    type='default')))
    }
    if (length(stackIdx) > 0) {
        for (i in stackIdx) obj[[i]][['stack']] <- 'Group'
    }
    if (length(smoothIdx) > 0) {
        for (i in smoothIdx) obj[[i]][['smooth']] <- TRUE
    }

    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }

}

series_k <- function(lst, type, return=NULL, ...){
    # Example:
    # g=echartr(stock, date, c(open, close, low, high), type='k')

    data <- cbind(lst$y[,1], lst$x[,1])
    obj <- list(list(name='Stock', type=type$type[1], data=asEchartData(lst$y[,1:4])))
    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }
}

series_pie <- function(lst, type, return=NULL, ...){
    # Example:
    # g=echartr(iris, Species, Sepal.Width, type='pie')
    # g=echartr(mtcars, am, mpg, gear, type='pie')
    # g=echartr(mtcars, y=mpg, series=gear,type='ring')
    ## ring_info
    # ds=data.frame(q=c('68% feel good', '29% feel bad', '3% have no feelings'),
    #               a=c(68, 29, 3))
    # g=echartr(ds, q, a, type='ring_info')
    # dev.width=paste0("document.getElementById('", g$elementId,"').offsetWidth")
    # dev.height=paste0("document.getElementById('", g$elementId,"').offsetHeight")
    # g %>% setLegend(pos=c('center','top','vertical'),
    #                 itemGap=JS(paste0(dev.height,"*0.4/3"))) %>%
    #       relocLegend(x=JS(paste0(dev.width,"/2")), y=JS(paste0(dev.height,"/10")))

    if (is.null(lst$y)) stop('pie/funnel charts need y!')
    if (is.null(lst$x) && is.null(lst$series)) stop('pie/funnel charts need either x or series!')
    data <- data.frame(lst$y[,1])
    if (!is.null(lst$x)){
        data[,2] <- if (any(grepl('infographic', type$misc))) 'TRUE' else lst$x[,1]
        series <- if (any(grepl('infographic', type$misc))) c('TRUE', 'FALSE')
                  else as.character(unique(lst$x[,1]))
    }else{
        data[,2] <- if (any(grepl('infographic', type$misc))) lst$series[,1] else 'TRUE'
        series <- if (any(grepl('infographic', type$misc)))
            as.character(unique(lst$series[,1])) else c('TRUE','FALSE')
    }
    if (!is.null(lst$series)){
        data[,3] <- lst$series[,1]
        pies <- as.character(unique(lst$series[,1]))
    }else{
        data[,3] <- if (any(grepl('infographic', type$misc)))
            lst$x[,1] else 'Proportion'
        pies <- if (any(grepl('infographic', type$misc)))
            as.character(unique(lst$x[,1])) else 'Proportion'
        if (any(grepl('infographic', type$misc)))
            type[2:length(pies),] <- type[1,]
    }
    names(data) <- c('y', 'x', 'series')
    data <- data.table::dcast(data, x~series, sum, value.var='y')

    if (all(data$x == 'TRUE')) {
        sum.prop <- sum(data[data$x == 'TRUE', 2:ncol(data)], na.rm=TRUE)
        data[nrow(data)+1, ] <- c('FALSE', sum.prop - data[data$x == 'TRUE', 2:ncol(data)])
    }
    if (is.null(lst$z)){
        layouts <- autoMultiPolarChartLayout(length(pies))
    }else{
        layouts <- autoMultiPolarChartLayout(length(pies), bottom=15)
    }

    rows <- layouts$rows
    cols <- layouts$cols
    centers <- layouts$centers
    rownames(centers) <- pies
    radius <- layouts$radius

    ## place holder styles
    placeHolderStyle = list(normal = list(
            color = 'rgba(0,0,0,0)', label = list(show=FALSE), labelLine = list(show=FALSE)
        ),
        emphasis = list(color = 'rgba(0,0,0,0)')
    )
    grayStyle = list(normal = list(
        color='#ccc', label=list(show=FALSE, position='center'),
        labelLine=list(show=FALSE)
        ),
        emphasis=list(color='rgba(0,0,0,0)')
    )
    normalStyle = list(normal=list(label=list(show=FALSE),
                                  labelLine=list(show=FALSE)))

    obj <- list()
    for (pie in pies){
        iType <- type[which(pies == pie),]
        o <- list(
            name=pie, type=iType$type,
            data=unname(apply(data[,c('x', pie)], 1, function(row) {
                if (row[1] == 'FALSE')
                    return(list(name='', value= ifna(as.numeric(unname(row[2])), '-'),
                         itemStyle=grayStyle))
                else
                    return(list(name=ifelse(as.character(unname(row[1]))=='TRUE',
                                            pie, as.character(unname(row[1]))),
                                value=ifna(as.numeric(unname(row[2])), '-'),
                                itemStyle=normalStyle))
                })),
            center=paste0(unname(centers[pie,]), '%'), width=paste0(radius, '%'),
            x=paste0(centers[pie, 1]-radius/2, '%'),
            max=ifelse(all(is.na(data[,pie])), 0,
                       max(unname(data[,pie]), na.rm=TRUE)),
            height=ifelse(rows==1, '70%', paste0(radius, '%')),
            y=ifelse(rows==1, rep('15%', length(pies)), paste0(centers[pie, 2]-radius/2, '%')),
            selectedMode='multiple'
        )
        if (grepl('ring', iType$misc)){
            o[['radius']] <- paste0(c(radius * 2/3, radius), '%')
            o[['itemStyle']] <- list(
                normal=list(label=list(show=TRUE)),
                emphasis=list(label=list(show=TRUE, position='center', textStyle=list(
                    fontSize='30',fontWeight='bold'
                )))
            )
            o[['clockWise']] <- FALSE
        }else if (grepl('radius', iType$misc)){
            o[['roseType']] <- 'radius'
            o[['radius']] <- paste0(c(radius/5, radius), '%')
        }else if (grepl('area', iType$misc)){
            o[['roseType']] <- 'area'
            o[['radius']] <- paste0(c(radius/5, radius), '%')
        }else if (grepl('infographic', iType$misc)){
            o[['data']][[2]][['itemStyle']] <- placeHolderStyle
            ringWidth <- 40 / length(pies)
            o[['radius']] <- paste0(c(80 - ringWidth*(which(pies == pie)-1),
                                      80 - ringWidth*which(pies == pie)), '%')
            o[['center']] <- c('50%', '50%')
            o[['clockWise']] <- FALSE
        }else{
            o[['radius']] <- paste0(radius, '%')
        }
        ## additional for funnel charts
        if (iType$type == 'funnel'){
            if (grepl('ascending', iType$misc)) o[['sort']] <- 'ascending'
            o[['itemStyle']] <- mergeList(o[['itemStyle']], list(normal=list(
                labelLine=list(show=TRUE)))
            )
        }

        obj[[pie]] <- o
    }
    obj <- unname(obj)

    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }
}

series_funnel <- series_pie

series_radar <- function(lst, type, return=NULL, ...){
    # Example:
    # cars = mtcars[c('Merc 450SE','Merc 450SL','Merc 450SLC'),
    #               c('mpg','disp','hp','qsec','wt','drat')]
    # cars$model <- rownames(cars)
    # cars <- data.table::melt(cars, id.vars='model')
    # names(cars) <- c('model', 'indicator', 'Parameter')
    # echartr(cars, indicator, Parameter, model, type='radar') %>%
    #        setTitle('Merc 450SE  vs  450SL  vs  450SLC')
    # echartr(cars, c(indicator, model), Parameter, type='radar_fill')
    # echartr(cars, c(indicator, model), Parameter, type='target') %>%
    #         setSymbols('none')
    #
    # echartr(cars, indicator, Parameter, z=model, type='radar')
    # ----------------
    #
    # carstat = data.table::dcast(data.table::data.table(mtcars),
    #               am + carb + gear ~., mean,
    #               value.var=c('mpg','disp','hp','qsec','wt','drat'))
    # carstat = data.table::melt(carstat, id=c('am', 'carb', 'gear'))
    # names(carstat) <- c('am', 'carb', 'gear', 'indicator', 'Parameter')
    # levels(carstat$indicator) <- gsub("_mean_\\.", "",
    #                                   levels(carstat$indicator))
    # carstat$am <- factor(carstat$am, labels=c('A', 'M'))
    # fullData <- data.frame(expand.grid(levels(carstat$indicator),
    #             levels(carstat$am), unique(carstat$carb)))
    # carstat <- merge(fullData, carstat, all.x=TRUE)
    # echartr(carstat, c(indicator, am),
    #         Parameter, carb, z=gear, type='radar')

    # x[,1] is x, x[,2] is series; y[,1] is y; series[,1] is polorIndex
    if (is.null(lst$y) || is.null(lst$x)) stop('radar charts need x and y!')
    data <- data.frame(lst$y[,1], lst$x[,1:(ifelse(ncol(lst$x) > 1, 2, 1))])
    if (ncol(lst$x) == 1) data[,ncol(data)+1] <- names(lst$y)[1]
    if (is.null(lst$series)) data[,ncol(data)+1] <- 0
    else data[,ncol(data)+1] <- lst$series[,1]
    names(data) <- c('y', 'x', 'series', 'index')

    data <- data.table::dcast(data, index+x+series~., sum, value.var='y')
    names(data) <- c('index', 'x', 'series', 'y')
    if (is.factor(lst$x[,2])){
        fullData <- data.frame(expand.grid(
            if (is.null(lst$series)) unique(data$index) else lst$series[,1],
            unique(data$x), levels(lst$x[,2])))
    }else{
        fullData <- data.frame(expand.grid(
            if (is.null(lst$series)) unique(data$index) else lst$series[,1],
            unique(data$x), unique(data$series)))
    }
    names(fullData) <- c('index', 'x', 'series')
    data <- merge(fullData, data, all.x=TRUE)
    data$x <- as.character(data$x)
    index <- 0:(length(unique(data$index))-1)
    obj <- lapply(index, function(i){
        dt <- data[data$index==unique(data$index)[i+1],]
        out <- list(type=type[i+1, 'type'],
                    name=unname(unique(as.character(data$index))[i+1]),
                    data=lapply(unique(dt$series), function(s){
                        list(name=as.character(s),
                             value=lapply(dt[dt$series==s, 'y'], function(x){
                                 ifna(x, '-')}))
                    }))
        if (i>0) out[['polarIndex']] <- i
        if (grepl('fill', type[i+1, 'misc']))
            out[['itemStyle']] <- list(normal=list(areaStyle=list(type='default')))
        return(out)
    })

    if (is.null(return)){
        return(obj)
    }else{
        return(obj[intersect(names(obj), return)])
    }
}

series_force <- function(lst, type, return=NULL, ...){
    # x: node/link, x2: link, series: series/relation, y: weight/value
    # or x: name column, y: matrix
    # Example
    # echartr(yu, c(source, target), value, relation, type='force')
    if (is.null(lst$y) || is.null(lst$x))
        stop('radar charts need x and y!')
    if (is.null(lst$series)){
        if (ncol(lst$y) != nrow(lst$y)) stop('When there is no sereis, y must be a matrix!')
    }else{
        if (ncol(lst$x) < 2) stop('x must have at least 2 columns: 1st as source, 2nd as target!')
    }

    if (is.null(lst$series)){  #matrix mode
        data <- data.frame(lst$y, lst$x[,1])
        matrix <- unname(as.matrix(lst$y))
        categories <- as.character(unique(lst$x[,1]))
    }else{  # nodes and links mode
        data <- data.frame(lst$y[,1], lst$x[,1:2], lst$series[,1])
        nodes <- data[is.na(data[,3]), c(1,2,4)]
        names(nodes) <- c("value", "name", "series")
        links <- data[!is.na(data[,3]),]
        names(links) <- c("value", "source", "target", "name")
        categories <- as.character(unique(nodes$series))
    }

    if (any(type$type %in% c('force', 'chord'))){
        types <- type$type
        miscs <- type$misc[type$type %in% c('force', 'chord')]
        o <- list(list(
            type=types[1], name='Connection', roam='move',
            itemStyle=list(normal=list(
                label=list(show=TRUE, textStyle=list(color='#333')),
                nodeStyle=list(brushType='both', strokeColor='rgba(255,215,0,0.4)'),
                linkStyle=list(type=ifelse(grepl('line', miscs[1]), 'line',
                                           ifelse(is.null(lst$series), 'line', 'curve')))
            ), emphasis=list(
                label=list(show=FALSE), nodeStyle=list(), lineStyle=list()
            ))
        ))
        # nodes/links or matrix
        if (is.null(lst$series)){  # data/matrix
            o[[1]]$matrix <- asEchartData(matrix)
            o[[1]]$data <- lapply(categories, function(catg){
                list(name=unname(catg))})
        }else{  # categories, nodes/links
            o[[1]]$categories <- lapply(categories, function(catg){
                list(name=unname(catg))})
            o[[1]]$nodes <- unname(apply(nodes, 1, function(row){
                list(category=which(categories==row[['series']])-1,
                     name=row[['name']], value=as.numeric(row[['value']]))
            }))
            o[[1]]$links <- unname(apply(links, 1, function(row){
                list(source=row[['source']], target=row[['target']],
                     name=row[['name']], weight=as.numeric(row[['value']]))
            }))
        }

        #other params
        ## linkSymbol
        if (grepl('(arrow|triangle)', miscs[1]))
            o[[1]]$linkSymbol <- gsub('(arrow|triangle)', '\\1', miscs[1])

        ## auto ribbon
        if (types[1] == 'force'){
            if (is.null(lst$series)){
                 o[[1]]$ribbonType <- TRUE
            }else{
                if (sum(paste(links$source, links$target) ==
                        paste(links$target, links$source), na.rm=TRUE) / nrow(links) > 0.5)
                    o[[1]]$ribbonType <- TRUE
                else o[[1]]$ribbonType <- FALSE
            }
        }else{
            o[[1]]$ribbonType <- grepl('ribbon', miscs[1])
        }

        ## sort and sortSub
        if (grepl('asc', miscs[1])) o[[1]]$sort = o[[1]]$sortSub <- 'ascending'
        if (grepl('desc', miscs[1])) o[[1]]$sort = o[[1]]$sortSub <- 'descending'

        ## clockWise
        if (grepl('clock', miscs[1])) o[[1]]$closeWise <- TRUE

        if (is.null(return)){
            return(o)
        }else{
            return(o[intersect(names(o), return)])
        }
    }
}

series_chord <- series_force

series_gauge <- function(lst, type, return=NULL, ...){

}

series_map <- function(lst, type, return=NULL, ...){

}

series_wordCloud <- function(lst, type, return=NULL, ...){
    if (is.null(lst$y) || is.null(lst$x))
        stop('radar charts need x and y!')
    data <- data.frame(lst$y[,1], lst$x[,1])
    names(data)[1:2] <- c('y', 'x')
    data <- data.table::dcast(data, x~., sum, value.var='y')
    names(data)[2] <- 'y'

    colors <- getColFromPal()

    if (is.null(lst$series)){
        o <- list(list(data=unname(apply(data, 1, function(row){
            list(name=unname(row['x']), value=unname(as.numeric(row['y'])),
                 itemStyle=list(normal=list(color=sample(colors,1))))
            })), textRotation=c(0,-45,45,90), type=type$type[1]))

    }else{
        data$series <- as.factor(lst$series[,1])
        if (length(colors) < length(nlevels(data$series)))
            colors <- rep(colors, ceiling(nlevels(data$series)/length(colors)))
        data$color <- colors[as.numeric(data$series)]

        o <- list(list(data=unname(apply(data, 1, function(row){
            list(name=unname(row['x']), value=unname(ifna(as.numeric(row['y']), '-')),
                 itemStyle=list(normal=list(color=unname(row['color']))))
        })), textRotation=c(0,-45,45,90), type=type$type[1]))
    }

    if (is.null(return)){
        return(o)
    }else{
        return(o[intersect(names(o), return)])
    }
}

series_eventRiver <- function(lst, type, return=NULL, ...){

}

series_venn <- function(lst, type, return=NULL, ...){
    if (is.null(lst$x) || is.null(lst$y)) stop('venn charts need x and y!')
    if (nrow(lst$y) < 3) stop('y has to have 3 rows with the last row be intersection.')
    data <- data.frame(y=lst$y[,1], x=lst$x[,1])[1:3,]
    o <- list(list(type='venn', itemStyle=list(
        normal=list(label=list(show=TRUE)),
        emphasis=list(borderWidth=3, borderColor='yellow')
        ),
        data=unname(apply(data, 1, function(row){
            list(value=unname(ifna(as.numeric(row['y']), '-')),
                 name=unname(row['x']))
        }))
    ))

    if (is.null(return)){
        return(o)
    }else{
        return(o[intersect(names(o), return)])
    }
}

series_tree <- function(lst, type, return=NULL, ...){

}

series_treemap <- function(lst, type, return=NULL, ...){

}

series_heatmap <- function(lst, type, return=NULL, ...){

}

#---------------------------legacy functions-----------------------------------
# split the data matrix for a scatterplot by series
data_scatter = function(x, y, series = NULL, type = 'scatter') {
  xy = unname(cbind(x, y))
  if (is.null(series)) return(list(list(type = type, data = xy)))
  xy = split(as.data.frame(xy), series)
  nms = names(xy)
  obj = list()
  for (i in seq_along(xy)) {
    obj[[i]] = list(name = nms[i], type = type, data = unname(as.matrix(xy[[i]])))
  }
  obj
}

data_bar = function(x, y, series = NULL, type = 'bar') {

  # plot the frequencies of x when y is not provided
  if (is.null(y)) {

    if (is.null(series)) {
      y = table(x)
      return(list(list(type = type, data = unname(c(y)))))
    }

    y = table(x, series)
    nms = colnames(y)
    obj = list()
    for (i in seq_len(ncol(y))) {
      obj[[i]] = list(name = nms[i], type = type, data = unname(y[, i]))
    }
    return(obj)

  }

  # when y is provided, use y as the height of bars
  if (is.null(series)) {
    return(list(list(type = type, data = y)))
  }

  xy = tapply(y, list(x, series), function(z) {
    if (length(z) == 1) return(z)
    stop('y must only have one value corresponding to each combination of x and series')
  })
  xy[is.na(xy)] = 0
  nms = colnames(xy)
  obj = list()
  for (i in seq_len(ncol(xy))) {
    obj[[i]] = list(name = nms[i], type = type, data = unname(xy[, i]))
  }
  obj

}

data_line = function(x, y, series = NULL) {
  if (is.null(x) && is.ts(y)) {
    x = as.numeric(time(y))
    y = as.numeric(y)
  }
  if (is.numeric(x)) {
    return(data_scatter(x, y, series, type = 'line'))
  }
  if (is.null(series)) {
    return(list(list(type = 'line', data = y)))
  }
  data_bar(x, y, series, type = 'line')
}
