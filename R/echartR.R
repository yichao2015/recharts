#------------Require packages, if not installed, install it--------------
loadpkg <- function(pkg, url=NULL, repo='cran'){
    # alt accepts cran, github, bioconductor, omegahat
    if (class(pkg)!='character') pkg=deparse(subsitute(pkg))
    if (! pkg %in% rownames(installed.packages())){
        if (tolower(repo)=='cran'){
            install.packages(pkg,repos=getOption("repos"))
        }else if (tolower(repo)=='github') {
            if (length(unlist(strsplit(url,split="/")))==1) 
                url<-paste(url,pkg,collapse="/")
            if (! 'devtools' %in% rownames(installed.packages()))
                install.packages('devtools')
            require(devtools)
            install_github(url)
        }else if (tolower(repo)=='bioconductor'){
            source('http://bioconductor.org/biocLite.R')
            biocLite()
            biocLite('pkg')
        }else if (tolower(repo)=='omegahat'){
            if (! 'RCurl' %in% rownames(installed.packages()))
                install.packages('RCurl')
            install.packages(pkg, repos = "http://www.omegahat.org/R", 
                             type = "source")
        }
    }
    require(package=pkg,character.only = TRUE)
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
        if (!is(try(as.POSIXct,T),"try-error")) T else F
    }
}
isLatin <- function(x){
    if (is.factor(x)) x <- as.character(x)
    return(all(grepl("^[[:alnum:][:space:][:punct:]]+$",x,perl=TRUE)))
}
pct <- function(vector,digits=0){
    if (is.na(digits)) digits=0
    if (is.numeric(vector)){
        return(sprintf(paste0("%.",digits,"f%%"),100*vector))
    }else{
        stop("vector must be numeric!")
    }
}
#-----Palettes and others---------
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
rgba <- function(vecrgb){
    if (is.list(vecrgb)) rgb <- as.vector(unlist(vecrgb))
    if (!is.vector(vecrgb)) stop("Must be a vector!")
    if (min(vecrgb,na.rm=TRUE)<0 | max(vecrgb,na.rm=TRUE)>255) {
        stop("All elements should be numeric 0-255!")
    }
    if (length(vecrgb[!is.na(vecrgb)])==3){
        return(rgb(red=vecrgb[1],green=vecrgb[2],blue=vecrgb[3],max=255))
    }else if (length(vecrgb[!is.na(vecrgb)])==4){
        #return(rgb(red=vecrgb[1],green=vecrgb[2],blue=vecrgb[3],alpha=vecrgb[4],
        #           max=255))
        return(paste0('rgba(',vecrgb[1],',',vecrgb[2],',',vecrgb[3],',',
                      as.numeric(vecrgb[4])/255,')'))
    }else{
        stop("Must be of length 3 or 4!")
    }
}
funcPal <- function(palette){ # build a function to extract palette info
    if (length(palette)==1) {
        if (substr(palette,1,1)=="#"){
            if (nchar(palette)==7){
                return(palette)
            }else{
                palette <- paste0('0x',substring(palette,seq(2,8,2),seq(3,9,2)))
                palette <- strtoi(palette)
                return(rgba(palette))
            }
        }else{
            palettes <- unlist(strsplit(palette,"[\\(\\)]",perl=TRUE))
            if (length(palettes)==1){
                return(aetnaPal(palettes[1]))
            }else{
                aetPal <- aetnaPal(palettes[1],as.numeric(palettes[2]))
                if (as.numeric(palettes[2])<length(aetPal)){
                    return(sample(aetPal,as.numeric(palettes[2])))
                }else{
                    return(aetPal)
                }
            }
        }
    }else if(length(palette)>1){
        aetPal <- vector()
        for (i in 1:length(palette)){
            if (!is(try(col2rgb(palette[i]),T),"try-error")){
                if (substr(palette[i],1,1)=="#"){
                    aetPal <- c(aetPal,toupper(palette[i]))
                }else{
                    VecCol <- as.vector(col2rgb(palette[i]))
                    aetPal <- c(aetPal,rgba(VecCol))
                }
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
                         stringsAsFactors=FALSE)
    names(TblPos) <- c("x","y","z")
    return(as.vector(unlist(TblPos[pos,])))
}
#-------table format-----------
tableReheading <- function(dataset, # the dataset to draw table
                           heading, # the heading you want to input
                           footRows=0, # the last several rows as <tfoot>
                           # '|' indicates colspan, '=' indicates rowspan
                           align=c('left',rep('center',ncol-1)), # alignment of columns
                           concatCol=NULL, # index of columns to concatenate
                                           # to make the table look hierachical
                           caption=NULL, # table caption
                           tableWidth='100%'){
    if ((!is.null(dataset) & !is.data.frame(dataset)) | 
        !(is.data.frame(heading) | is.matrix(heading) | is.vector(heading))){
        stop(paste0('`dataset` must be a data.frame,',
                    '\n`heading` must be a vector/matrix/ data.frame.'))
    }else{
        if (is.vector(heading)) heading <- t(matrix(heading))
        if (!is.null(dataset)){
            ncol <- ncol(dataset)
            if (ncol!=ncol(heading)) stop("not equal counts of columns!")
        }else{
            ncol <- sub('(^[dhr]+?)[^dhr].+$','\\1',gsub('.+?<t([dhr]).+?','\\1',htmltable))
            ncol <- table(strsplit(ncol,"")[[1]])
            ncol <- floor((ncol[['h']]+ncol[['d']])/ncol[['r']])
        }
        align_simp <- substr(tolower(align),1,1)
        if (!all(align_simp %in% c('l','c','r'))){
            stop('`align` only accepts values of "l(eft)", "c(enter)" and "r(ight)".')
        }else{
            align[align_simp=="l"] <- "left"
            align[align_simp=="c"] <- "center"
            align[align_simp=="r"] <- "right"
        }
        if (length(align) > ncol(heading)){
            align <- align[1:ncol(heading)]
        }else if (length(align)<ncol(heading)){
            align <- c(align[1:length(align)],
                       rep(align[length(align)],ncol(heading)-length(align)))
        }
        align_simp <- substr(tolower(align),1,1)
        loadpkg('knitr')
        
        dataset <- as.data.frame(dataset)
        if (!is.null(concatCol)){
            for (icol in concatCol){
                col <- as.character(dataset[,icol])
                lag <- c(NA,as.character(dataset[1:(nrow(dataset)-1),icol]))
                col[col==lag] <- ""
                dataset[,icol] <- col
            }
        }
        
        if (!(is.null(footRows) | footRows==0)){
            if (footRows>=nrow(dataset))
                stop("footRows cannot be >= number of datatable rows!")
            htmlBody <- knitr::kable(dataset[1:(nrow(dataset)-footRows),],
                                     format='html',align=align_simp,row.names=FALSE)
            htmlFoot <- knitr::kable(dataset[(nrow(dataset)-footRows+1):
                                                      nrow(dataset),],
                                     format='html',align=align_simp,row.names=FALSE)
            htmlBody <- gsub("(^.+</tbody>).+$","\\1",htmlBody)
            htmlFoot <- gsub("^.+<tbody>(.+)</tbody>.+$","<tfoot>\\1</tfoot>",htmlFoot)
            htmltable <- paste0(htmlBody,"\n",htmlFoot,"\n</table>")
        }else{
            htmltable <- knitr::kable(dataset,format='html',
                                      align=align_simp,row.names=FALSE)
        }
        
        if (!is.null(caption)){
            htmltable <- gsub("<table>",paste0("<table>\n<caption>",caption,"</caption>"),
                              htmltable)
        }
        class(htmltable) <- 'knitr_kable'
        attributes(htmltable) <- list(format='html',class='knitr_kable')
        rehead <- '<thead>'
        for (j in 1:ncol(heading)){
            if (all(is.na(heading[,j]))){
                heading[1,j] <- '$'
                if (nrow(heading)>1) heading[2:nrow(heading),j] <- "|"
            }
        }
        heading[1,][is.na(heading[1,])] <- "="
        if (nrow(heading)>1){
            heading[2:nrow(heading),][is.na(heading[2:nrow(heading),])] <- "|"
        }
        dthead <- heading
        for (i in 1:nrow(heading)){
            for (j in 1:ncol(heading)){
                dthead[i,j] <- ifelse(heading[i,j] %in% c('|','='),"",
                                      paste0('<th style="text-align:',align[j],';"> ',
                                             heading[i,j],' </th>'))
                if (! heading[i,j] %in% c("|","=")){
                    if (i==1 & heading[i,j]=="$"){
                        dthead[i,j] <- paste0('<th rowspan="',nrow(heading),
                                              '" style="text-align:',align[j],
                                              ';">&nbsp;&nbsp;&nbsp;</th>')
                    }
                    if (j<ncol(heading)) {
                        if (heading[i,j+1] == "="){
                            colspan <- paste0(heading[i,(j+1):ncol(heading)],
                                              collapse="")
                            ncolspan <- nchar(sub("^(=+).*$","\\1",colspan))+1
                            dthead[i,j] <- sub('<th ',paste0('<th colspan="', 
                                                             ncolspan,'" '),
                                               dthead[i,j])
                            dthead[i,j] <- sub('align: *?(left|right)',
                                               paste0('align:center'),
                                               dthead[i,j])
                        }
                    }
                    if (i<nrow(heading)){
                        if (heading[i+1,j] == "|"){
                            rowspan <- paste0(heading[(i+1):nrow(heading),j],
                                              collapse="")
                            nrowspan <- nchar(sub("^(\\|+).*$","\\1",rowspan))+1
                            if (grepl("colspan",dthead[i,j])){
                                if (sum(!heading[i:(i+nrowspan-1),j:(j+ncolspan-1)] 
                                        %in% c('=','|'))==1){
                                    dthead[i,j] <- sub('<th ',paste0('<th rowspan="',
                                                                     nrowspan,'" '),
                                                       dthead[i,j])
                                }else{
                                    dthead[i,j] <- sub('colspan.+?style',
                                                       paste0('rowspan="',
                                                              nrowspan,'" style'),
                                                       dthead[i,j])
                                }
                            }else{
                                dthead[i,j] <- sub('<th ',paste0('<th rowspan="',
                                                                 nrowspan,'" '),
                                                   dthead[i,j])
                            }
                        }
                    }
                }
            }
        }
        for (i in 1:nrow(heading)){
            rehead <- paste0(rehead,'<tr>',paste0(dthead[i,],collapse=""),'</tr>',
                             collapse="")
        }
        rehead <- paste0(rehead,'</thead>')
        rehead <- gsub('<thead>.+</thead>',rehead,htmltable)
        class(rehead) <- class(htmltable)
        attributes(rehead) <- attributes(htmltable)
        return(sub('<table',paste0('<table width=',as.character(tableWidth)),rehead))
    }
}
