# recharts

[![Build Status](https://travis-ci.org/yihui/recharts.svg)](https://travis-ci.org/yihui/recharts)

# Intro 前言

本工具来源于百度开发的国内顶尖水平的开源`d3-js`可视项目[Echarts](http://echarts.baidu.com/)([Github Repo](https://github.com/ecomfe/echarts))。Yang Zhou和Taiyun Wei基于该工具开发了[recharts](https://github.com/taiyun/recharts)包，经Yihui Xie[修改](https://github.com/yihui/recharts)后，可通过`htmlwidgets`传递js参数，大大简化了开发难度。但此包开发仍未完成。为了赶紧上手用，基于该包做了一个函数`echartR`，用于制作基础Echart交互图。需要R版本>=3.2.0.

This tool originates from a top-tier `d3-js` visualization project of China: [Baidu Echarts](http://echarts.baidu.com/)([Github Repo](https://github.com/ecomfe/echarts)). Yang Zhou and Taiyun Wei developed an experimental R package [recharts](https://github.com/taiyun/recharts) based on it, which then evoluted into [yihui/recharts](https://github.com/yihui/recharts) by Yihui Xie to pass js parameters through `htmlwidgets`. The package is sill uder development. I developed a function `echartR` based on this package to make basic Echarts interation charts. This function requires R>=3.2.0.

`echartR`的主要工作是将Echarts参数封装成list，Yihui Xie的原型函数`echart`被用来处理这个list。`echart`函数的[基本用法](http://yihui.name/recharts)如下，除了数据本身，并没有提供其他参数的位置。

`echartR` majorly packs Echarts parameters into a list while `echart`, the prototype function developed by Yihui Xie, is used to parse the list. The [basic examples](http://yihui.name/recharts) of `echart` is as follows, which does not provide parameters entry other than dataset itself.

```r
if (! 'recharts' %in% installed.packages()[,1]){
    install.packages('recharts',
                     repos = c('http://yihui.name/xran', 'http://cran.rstudio.com')
                     )
}
library(recharts)
echart(iris, ~Sepal.Length, ~Sepal.Width)
```

<!--html_preserve--><div id="htmlwidget-1616" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-1616">{"x":{"series":[{"type":"scatter","data":[[5.1,3.5],[4.9,3],[4.7,3.2],[4.6,3.1],[5,3.6],[5.4,3.9],[4.6,3.4],[5,3.4],[4.4,2.9],[4.9,3.1],[5.4,3.7],[4.8,3.4],[4.8,3],[4.3,3],[5.8,4],[5.7,4.4],[5.4,3.9],[5.1,3.5],[5.7,3.8],[5.1,3.8],[5.4,3.4],[5.1,3.7],[4.6,3.6],[5.1,3.3],[4.8,3.4],[5,3],[5,3.4],[5.2,3.5],[5.2,3.4],[4.7,3.2],[4.8,3.1],[5.4,3.4],[5.2,4.1],[5.5,4.2],[4.9,3.1],[5,3.2],[5.5,3.5],[4.9,3.6],[4.4,3],[5.1,3.4],[5,3.5],[4.5,2.3],[4.4,3.2],[5,3.5],[5.1,3.8],[4.8,3],[5.1,3.8],[4.6,3.2],[5.3,3.7],[5,3.3],[7,3.2],[6.4,3.2],[6.9,3.1],[5.5,2.3],[6.5,2.8],[5.7,2.8],[6.3,3.3],[4.9,2.4],[6.6,2.9],[5.2,2.7],[5,2],[5.9,3],[6,2.2],[6.1,2.9],[5.6,2.9],[6.7,3.1],[5.6,3],[5.8,2.7],[6.2,2.2],[5.6,2.5],[5.9,3.2],[6.1,2.8],[6.3,2.5],[6.1,2.8],[6.4,2.9],[6.6,3],[6.8,2.8],[6.7,3],[6,2.9],[5.7,2.6],[5.5,2.4],[5.5,2.4],[5.8,2.7],[6,2.7],[5.4,3],[6,3.4],[6.7,3.1],[6.3,2.3],[5.6,3],[5.5,2.5],[5.5,2.6],[6.1,3],[5.8,2.6],[5,2.3],[5.6,2.7],[5.7,3],[5.7,2.9],[6.2,2.9],[5.1,2.5],[5.7,2.8],[6.3,3.3],[5.8,2.7],[7.1,3],[6.3,2.9],[6.5,3],[7.6,3],[4.9,2.5],[7.3,2.9],[6.7,2.5],[7.2,3.6],[6.5,3.2],[6.4,2.7],[6.8,3],[5.7,2.5],[5.8,2.8],[6.4,3.2],[6.5,3],[7.7,3.8],[7.7,2.6],[6,2.2],[6.9,3.2],[5.6,2.8],[7.7,2.8],[6.3,2.7],[6.7,3.3],[7.2,3.2],[6.2,2.8],[6.1,3],[6.4,2.8],[7.2,3],[7.4,2.8],[7.9,3.8],[6.4,2.8],[6.3,2.8],[6.1,2.6],[7.7,3],[6.3,3.4],[6.4,3.1],[6,3],[6.9,3.1],[6.7,3.1],[6.9,3.1],[5.8,2.7],[6.8,3.2],[6.7,3.3],[6.7,3],[6.3,2.5],[6.5,3],[6.2,3.4],[5.9,3]]}],"xAxis":{"type":"value","show":true,"position":"bottom","name":"Sepal.Length","nameLocation":"end","nameTextStyle":{},"boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"axisTick":{"show":false},"axisLabel":{"show":true},"splitLine":{"show":true},"splitArea":{"show":false},"data":[]},"yAxis":{"type":"value","show":true,"position":"left","name":"Sepal.Width","nameLocation":"end","nameTextStyle":{},"boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"axisTick":{"show":false},"axisLabel":{"show":true},"splitLine":{"show":true},"splitArea":{"show":false},"data":[]}},"evals":[]}</script><!--/html_preserve-->

```r
echart(iris, ~Sepal.Length, ~Sepal.Width, series = ~Species)
```

<!--html_preserve--><div id="htmlwidget-686" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-686">{"x":{"series":[{"name":"setosa","type":"scatter","data":[[5.1,3.5],[4.9,3],[4.7,3.2],[4.6,3.1],[5,3.6],[5.4,3.9],[4.6,3.4],[5,3.4],[4.4,2.9],[4.9,3.1],[5.4,3.7],[4.8,3.4],[4.8,3],[4.3,3],[5.8,4],[5.7,4.4],[5.4,3.9],[5.1,3.5],[5.7,3.8],[5.1,3.8],[5.4,3.4],[5.1,3.7],[4.6,3.6],[5.1,3.3],[4.8,3.4],[5,3],[5,3.4],[5.2,3.5],[5.2,3.4],[4.7,3.2],[4.8,3.1],[5.4,3.4],[5.2,4.1],[5.5,4.2],[4.9,3.1],[5,3.2],[5.5,3.5],[4.9,3.6],[4.4,3],[5.1,3.4],[5,3.5],[4.5,2.3],[4.4,3.2],[5,3.5],[5.1,3.8],[4.8,3],[5.1,3.8],[4.6,3.2],[5.3,3.7],[5,3.3]]},{"name":"versicolor","type":"scatter","data":[[7,3.2],[6.4,3.2],[6.9,3.1],[5.5,2.3],[6.5,2.8],[5.7,2.8],[6.3,3.3],[4.9,2.4],[6.6,2.9],[5.2,2.7],[5,2],[5.9,3],[6,2.2],[6.1,2.9],[5.6,2.9],[6.7,3.1],[5.6,3],[5.8,2.7],[6.2,2.2],[5.6,2.5],[5.9,3.2],[6.1,2.8],[6.3,2.5],[6.1,2.8],[6.4,2.9],[6.6,3],[6.8,2.8],[6.7,3],[6,2.9],[5.7,2.6],[5.5,2.4],[5.5,2.4],[5.8,2.7],[6,2.7],[5.4,3],[6,3.4],[6.7,3.1],[6.3,2.3],[5.6,3],[5.5,2.5],[5.5,2.6],[6.1,3],[5.8,2.6],[5,2.3],[5.6,2.7],[5.7,3],[5.7,2.9],[6.2,2.9],[5.1,2.5],[5.7,2.8]]},{"name":"virginica","type":"scatter","data":[[6.3,3.3],[5.8,2.7],[7.1,3],[6.3,2.9],[6.5,3],[7.6,3],[4.9,2.5],[7.3,2.9],[6.7,2.5],[7.2,3.6],[6.5,3.2],[6.4,2.7],[6.8,3],[5.7,2.5],[5.8,2.8],[6.4,3.2],[6.5,3],[7.7,3.8],[7.7,2.6],[6,2.2],[6.9,3.2],[5.6,2.8],[7.7,2.8],[6.3,2.7],[6.7,3.3],[7.2,3.2],[6.2,2.8],[6.1,3],[6.4,2.8],[7.2,3],[7.4,2.8],[7.9,3.8],[6.4,2.8],[6.3,2.8],[6.1,2.6],[7.7,3],[6.3,3.4],[6.4,3.1],[6,3],[6.9,3.1],[6.7,3.1],[6.9,3.1],[5.8,2.7],[6.8,3.2],[6.7,3.3],[6.7,3],[6.3,2.5],[6.5,3],[6.2,3.4],[5.9,3]]}],"xAxis":{"type":"value","show":true,"position":"bottom","name":"Sepal.Length","nameLocation":"end","nameTextStyle":{},"boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"axisTick":{"show":false},"axisLabel":{"show":true},"splitLine":{"show":true},"splitArea":{"show":false},"data":[]},"yAxis":{"type":"value","show":true,"position":"left","name":"Sepal.Width","nameLocation":"end","nameTextStyle":{},"boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"axisTick":{"show":false},"axisLabel":{"show":true},"splitLine":{"show":true},"splitArea":{"show":false},"data":[]},"legend":{"data":["setosa","versicolor","virginica"]}},"evals":[]}</script><!--/html_preserve-->

# Usage 用法
## Installation 安装
- 安装 Install `devtools` (`install.packages('devtools')`)
- 安装 Insall recharts (`install_github('yihui/recharts')`)
- 下载 Download `echartR.R`脚本文件到本地位置 script file to local disk:  [https://github.com/madlogos/recharts/blob/master/R/echartR.R](https://github.com/madlogos/recharts/blob/master/R/echartR.R))
- 调用 Source `echartR` 脚本 script (假设我将脚本放在本地 suppose I stored the script to local GitHub Repo: `source("~/Github/recharts/R/echartR.R")`)

## Grammar 语法

```
echartR(data, x=NULL, y, z=NULL, series=NULL, weight=NULL, 
        type="scatter", stack=FALSE,
        title=NULL, subtitle=NULL, title_pos=c('center','bottom'),
        symbolList=NULL, dataZoom=NULL, dataZoomRange=NULL,
        dataRange=NULL, splitNumber=NULL, dataRangePalette=NULL,
        xlab=NULL, ylab=NULL, xyflip=FALSE, AxisAtZero=TRUE, scale=TRUE,
        palette='aetnagreen', tooltip=TRUE, legend=TRUE,
        legend_pos=c('center','top'), 
        toolbox=TRUE, toolbox_pos=c('right','top'), 
        calculable=TRUE, asImage=FALSE))
```

- **data**: 数据集 dataset
- x: x变量，直方图可省略。x variable, only omitable for histograms。
- **y**: y变量 y variable
- z: z变量，只接受时间/日期变量，并打开时间轴。z variable, only accept data/time variable to open time axis
- series: Series(系列)变量 series variable
- weight: 权重变量，可用于直方图、气泡图等 weight variable, used in histogram, bubble, etc
- type: 默认 default `scatter`，可选 options 'scatter', 'bubble', 'bar', 'line', 'linesmooth', 'map', 'k', 'pie', 'ring', 'area', 'areasmooth', 'chord', 'force', 'tree', 'treemap', 'wordcloud', 'heatmap', 'histogram', 'funnel', 'pyramid', 'radar', 'radarfill'
    - 如选择map，则控制项必须写作一个长度为3的向量：c('map',`mapType`,`area/point`)。mapType可选'world'、'china'，或简体中文表示的具体中国地名。area/point为area时，用区块颜色表示效应大小；为point时，用点在地图上做标注。默认为c('map','china','area')。If `map` was chosen, the control option should be a vector of length 3: c('map',`mapType`,`area/point`). `mapType` could be either 'world' or 'china', of which simplified Chinese names are required for 'china'. When `area/point` equals to 'area', the function colors polygons to show the effects; while equals to 'point', it ticks droplets on the map.
- stack: 默认FALSE，是否堆积。用于制作堆积条图、柱图、线图和面积图等。Default to FALSE (do not stack). Used in stacked hbar/vbar, line and area chart, etc.
- title: 标题 
- subtitle: 副标题
- title_pos: 标题位置，可用c('left|center|right','top|center|bottom')，默认c("center","bottom")表示底部居中位置。Legend position which is a vector of length 2 (c('left|center|right','top|center|bottom')). Default to c('center','bottom') which means bottom meiddle.
- symbolList: 图形标志。可使用数组循环使用，如数组长度小于series水平数，则以最后一个标志填充。如设置为NULL或不设置，则循环显示Echarts默认的标志图形列表：c('circle','rectangle','triangle','diamond','emptyCircle','emptyRectangle','emptyTriangle','emptyDiamond')。也可任意指定'heart','droplet','pin','arrow','star5','star6'等非标图形。设为'none'则不显示。A vector assigning symbols. You can use an array of symbols. If the length of the symbols array is smaller than number of levels of the series, the last symbol will be used to extend the array. If you set symbolList NULL or leave it unset, the function circulates the default symbol list of Echarts: c('circle','rectangle','triangle','diamond','emptyCircle','emptyRectangle','emptyTriangle','emptyDiamond'). You can also assign non-standard symbols, such as 'heart','droplet','pin','arrow','star5','star6', 'star7', etc. When assigned to 'none', no symbols are shown.
- dataZoom: 数据缩放轴，默认FALSE. The axis to zoom data. Default to FALSE.
- dataZoomRange: 如`dataZoom=TRUE`，默认范围为0-100%。可用一个长度为2的向量控制初始范围，如`c(30,70)`显示初始30-70%。If `dataZoom=TRUE`, the default range is 0-100%. You can assign a vector with length of 2 to `dataZoomRange` to control the initial range. E.g.,`c(30,70)` means from 30% to 70% at the initial view.
- dataRange: 数据范围漫游范围，默认不打开。如要打开，设置dataRange=c(`高值标签`,`低值标签`) The range to zoom the data. Default to FALSE. Set dataRange=c(`High value label`,`Low value label`) to enable dataRange.
- splitNumber: 如打开数据漫游，可指定数据范围切分段数，默认为连续漫游轴(0)。在直方图里，如设定splitNumber，则将数据切分成splitNumber个块。When dataRange is on, assign splitNumber to cut the range into discrete sections. Default to 0 (continuous range). In histogram, if splitNumber is set, the y variable will be cut into splitNumber groups.
- dataRangePalette: 如打开数据漫游，可单独指定漫游色板(同palette功能)，否则采用Echarts默认值。You can independently assign palettes to dataRange (similar to overall palette). Default to NULL (applies echarts defaults).
- xlab: x轴标题 title of x-axis
- ylab: y轴标题 title of y-axis
- xyflip: 默认FALSE，是否翻转坐标轴。Flip x,y-axies. Default to FALSE.
- AxisAtZero: 默认FALSE，坐标轴是否交叉于零点。Axes cross at zero. Default to FALSE.
- scale: 默认TRUE，是否基于最大、最小值调整坐标尺度。Rescale the axes based on min and max values. Default to TRUE.
- palette: 默认aetnagreen，使用调色板。Overall palette. Default to 'aetnagreen'.
    - 种类 Palette names:
        - Aetna palettes: 可用 Including 'aetnagreen', 'aetnablue', 'aetnaviolet', 'aetnaorange', 'aetnateal', 'aetnacranberry'
        - RColorBrewer palettes: 可用 Including 'BrBG', 'PiYG', 'PRGn', 'PuOr', 'RdBu', 'RdGy', 'RdYlBu', 'RdYlGn', 'Spectral', 'Accent', 'Dark2', 'Paired', 'Pastel1', 'Pastel2', 'Set1', 'Set2', 'Set3', 'Blues', 'BuGn', 'BuPu', 'GnBu', 'Greens', 'Greys', 'Oranges', 'OrRd', 'PuBu', 'PuBuGn', 'PuRd', 'Purples', 'RdPu', 'Reds', 'YlGn', 'YlGnBu', 'YlOrBr', 'YlOrRd'
        - ggthemes palettes: 'calc', 'economist', 'economist_white', 'excel', 'few', 'fivethirtyeight', 'gdocs', 'pander', 'tableau', 'stata', 'tableau20', 'tableau10medium', 'tableaugray', 'tableauprgy', 'tableaublrd', 'tableaugnor', 'tableaucyclic', 'tableau10light', 'tableaublrd12','tableauprgy12', 'tableaugnor12','hc','darkunica', 'solarized','solarized_red', 'solarized_yellow', 'solarized_orange','solarized_magenta','solarized_violet', 'solarized_blue', 'solarized_cyan', 'solarized_green', 'wsj','colorblind', 'trafficlight'
        - 其他Other palettes: 'rainbow', 'terrain', 'topo', 'heat', 'cm'
    - 用法 Usage:
        - 可以不指定，使用函数默认。Do not set the value and function defaults will be loaded
        - 可以`palette=NULL`，使用Echarts默认。Set `palette=NULL` to use Echarts defaults
        - 可以`palette=palette name`指定上述任何一种色板。Set `palette=palette name` to assign any palette listed above
        - 规定色板的同时跟个数限定，限定色板颜色的个数，如`palette='calc(3)'`，会从calc色板中**随机**取3种颜色。Set `palette=palette name(number)` to restrict number of colors within the palette (e.g., `palette='calc(3)'` picks 3 colors out of 'calc' **RANDOMLY**)
        - 可以`palette=c(color1,color2,color3,...)`自定义色板向量，向量可以是颜色名，也可以是Hex表达式。可以用`colors()`函数查看所有支持的颜色名称，`demo(colors)`查看颜色效果。Set `palette=c(color1,color2,color3,...)` to define a palette vector, made of which either color names or Hex expressions. Use `colors()` to check available color names and check the effects using `demo(colors)`.
- tooltip: 默认TRUE，鼠标指针特效。Mouse tip effects swtich. Default to TRUE.
- legend: 默认TRUE，是否显示图例。Whether show the legend. Default to TRUE.
- legend_pos: 图例位置，长度为2的向量，设置方法参考`title_pos`。Legend position, a vector of length 2. Refer to `title_pos` for configuration.
- toolbox: 默认TRUE，是否显示工具箱。Echarts Tool box switch. Default to TRUE.
- toolbox_pos: 工具箱位置，默认右上方。参考`title_pos`的设置方法。Toolbox position, default to c('right','top'). Refer to `title_pos` for configuration.
- calculable: 默认TRUE，是否支持拖曳重算(Echarts专利) Calculable switch (Echarts patent).
- asImage: 默认FALSE，是否出静态图。renderAsImage switch.Deafult to FALSE.

# Examples 示例


```r
Sys.setlocale("LC_CTYPE","Chs")
source("~/Github/recharts/R/echartR.R")
#source("C:/HMSProjects/Data Analytics/R_scripts/CommonFunctions.R")
knitr::opts_chunk$set(message=FALSE,warning=FALSE,results='asis')
```

## Scatter 散点图

### Singular-series Scatter 单系列散点图


```r
echartR(data = iris, x = ~Sepal.Width, y = ~Petal.Width, 
        type = 'scatter', palette='solarized_magenta',
        title = 'Scatter - Sepal Width vs Petal Width (iris)', 
        xlab = 'Sepal Width', ylab = 'Petal Width')
```

<!--html_preserve--><div id="htmlwidget-7888" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-7888">{"x":{"title":{"text":"Scatter - Sepal Width vs Petal Width (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"scatter","data":[[3.5,0.2],[3,0.2],[3.2,0.2],[3.1,0.2],[3.6,0.2],[3.9,0.4],[3.4,0.3],[3.4,0.2],[2.9,0.2],[3.1,0.1],[3.7,0.2],[3.4,0.2],[3,0.1],[3,0.1],[4,0.2],[4.4,0.4],[3.9,0.4],[3.5,0.3],[3.8,0.3],[3.8,0.3],[3.4,0.2],[3.7,0.4],[3.6,0.2],[3.3,0.5],[3.4,0.2],[3,0.2],[3.4,0.4],[3.5,0.2],[3.4,0.2],[3.2,0.2],[3.1,0.2],[3.4,0.4],[4.1,0.1],[4.2,0.2],[3.1,0.2],[3.2,0.2],[3.5,0.2],[3.6,0.1],[3,0.2],[3.4,0.2],[3.5,0.3],[2.3,0.3],[3.2,0.2],[3.5,0.6],[3.8,0.4],[3,0.3],[3.8,0.2],[3.2,0.2],[3.7,0.2],[3.3,0.2],[3.2,1.4],[3.2,1.5],[3.1,1.5],[2.3,1.3],[2.8,1.5],[2.8,1.3],[3.3,1.6],[2.4,1],[2.9,1.3],[2.7,1.4],[2,1],[3,1.5],[2.2,1],[2.9,1.4],[2.9,1.3],[3.1,1.4],[3,1.5],[2.7,1],[2.2,1.5],[2.5,1.1],[3.2,1.8],[2.8,1.3],[2.5,1.5],[2.8,1.2],[2.9,1.3],[3,1.4],[2.8,1.4],[3,1.7],[2.9,1.5],[2.6,1],[2.4,1.1],[2.4,1],[2.7,1.2],[2.7,1.6],[3,1.5],[3.4,1.6],[3.1,1.5],[2.3,1.3],[3,1.3],[2.5,1.3],[2.6,1.2],[3,1.4],[2.6,1.2],[2.3,1],[2.7,1.3],[3,1.2],[2.9,1.3],[2.9,1.3],[2.5,1.1],[2.8,1.3],[3.3,2.5],[2.7,1.9],[3,2.1],[2.9,1.8],[3,2.2],[3,2.1],[2.5,1.7],[2.9,1.8],[2.5,1.8],[3.6,2.5],[3.2,2],[2.7,1.9],[3,2.1],[2.5,2],[2.8,2.4],[3.2,2.3],[3,1.8],[3.8,2.2],[2.6,2.3],[2.2,1.5],[3.2,2.3],[2.8,2],[2.8,2],[2.7,1.8],[3.3,2.1],[3.2,1.8],[2.8,1.8],[3,1.8],[2.8,2.1],[3,1.6],[2.8,1.9],[3.8,2],[2.8,2.2],[2.8,1.5],[2.6,1.4],[3,2.3],[3.4,2.4],[3.1,1.8],[3,1.8],[3.1,2.1],[3.1,2.4],[3.1,2.3],[2.7,1.9],[3.2,2.3],[3.3,2.5],[3,2.3],[2.5,1.9],[3,2],[3.4,2.3],[3,1.8]],"large":false}],"renderAsImage":true,"color":["#d33682","#b58900","#cb4b16","#dc322f","#6c71c4","#268bd2","#2aa198","#859900"],"xAxis":{"name":"Sepal Width","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Petal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

### Multi-series Scatter 多系列散点图

指定series，且显示范围从零点开始(`scale=FALSE`)


```r
echartR(data = iris, x = ~Sepal.Width, y = ~Petal.Width, series = ~Species,
        type = 'scatter', palette='aetnaviolet', symbolList='circle', scale=F,
        title = 'Scatter - Sepal Width vs Petal Width, by Species (iris)',
        xlab = 'Sepal Width', ylab = 'Petal Width')
```

<!--html_preserve--><div id="htmlwidget-3279" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3279">{"x":{"title":{"text":"Scatter - Sepal Width vs Petal Width, by Species (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"formatter":"function (params) {\n                                                if (params.value.length > 1) {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.value[0] + \" ,    \" +\n                                                + params.value[1];\n                                                } else {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.name + \" : \"\n                                                + params.value;\n                                                }}"},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"scatter","data":[[3.5,0.2],[3,0.2],[3.2,0.2],[3.1,0.2],[3.6,0.2],[3.9,0.4],[3.4,0.3],[3.4,0.2],[2.9,0.2],[3.1,0.1],[3.7,0.2],[3.4,0.2],[3,0.1],[3,0.1],[4,0.2],[4.4,0.4],[3.9,0.4],[3.5,0.3],[3.8,0.3],[3.8,0.3],[3.4,0.2],[3.7,0.4],[3.6,0.2],[3.3,0.5],[3.4,0.2],[3,0.2],[3.4,0.4],[3.5,0.2],[3.4,0.2],[3.2,0.2],[3.1,0.2],[3.4,0.4],[4.1,0.1],[4.2,0.2],[3.1,0.2],[3.2,0.2],[3.5,0.2],[3.6,0.1],[3,0.2],[3.4,0.2],[3.5,0.3],[2.3,0.3],[3.2,0.2],[3.5,0.6],[3.8,0.4],[3,0.3],[3.8,0.2],[3.2,0.2],[3.7,0.2],[3.3,0.2]],"large":false,"name":"setosa"},{"type":"scatter","data":[[3.2,1.4],[3.2,1.5],[3.1,1.5],[2.3,1.3],[2.8,1.5],[2.8,1.3],[3.3,1.6],[2.4,1],[2.9,1.3],[2.7,1.4],[2,1],[3,1.5],[2.2,1],[2.9,1.4],[2.9,1.3],[3.1,1.4],[3,1.5],[2.7,1],[2.2,1.5],[2.5,1.1],[3.2,1.8],[2.8,1.3],[2.5,1.5],[2.8,1.2],[2.9,1.3],[3,1.4],[2.8,1.4],[3,1.7],[2.9,1.5],[2.6,1],[2.4,1.1],[2.4,1],[2.7,1.2],[2.7,1.6],[3,1.5],[3.4,1.6],[3.1,1.5],[2.3,1.3],[3,1.3],[2.5,1.3],[2.6,1.2],[3,1.4],[2.6,1.2],[2.3,1],[2.7,1.3],[3,1.2],[2.9,1.3],[2.9,1.3],[2.5,1.1],[2.8,1.3]],"large":false,"name":"versicolor"},{"type":"scatter","data":[[3.3,2.5],[2.7,1.9],[3,2.1],[2.9,1.8],[3,2.2],[3,2.1],[2.5,1.7],[2.9,1.8],[2.5,1.8],[3.6,2.5],[3.2,2],[2.7,1.9],[3,2.1],[2.5,2],[2.8,2.4],[3.2,2.3],[3,1.8],[3.8,2.2],[2.6,2.3],[2.2,1.5],[3.2,2.3],[2.8,2],[2.8,2],[2.7,1.8],[3.3,2.1],[3.2,1.8],[2.8,1.8],[3,1.8],[2.8,2.1],[3,1.6],[2.8,1.9],[3.8,2],[2.8,2.2],[2.8,1.5],[2.6,1.4],[3,2.3],[3.4,2.4],[3.1,1.8],[3,1.8],[3.1,2.1],[3.1,2.4],[3.1,2.3],[2.7,1.9],[3.2,2.3],[3.3,2.5],[3,2.3],[2.5,1.9],[3,2],[3.4,2.3],[3,1.8]],"large":false,"name":"virginica"}],"renderAsImage":true,"color":["#7D3F98","#7AC143","#F47721","#00A78E","#00BCE4","#D20962","#F58F9F","#B8D936","#FDB933","#60C3AE","#5F78BB","#EE3D94","#5E9732","#CEA979","#EF4135","#7090A5"],"symbolList":["circle","circle","circle"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"left","y":"top"},"xAxis":{"name":"Sepal Width","type":"value","boundaryGap":[0,0],"scale":false,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Petal Width","type":"value","scale":false,"axisLine":{"show":true,"onZero":false}}},"evals":["tooltip.formatter"]}</script><!--/html_preserve-->

使用三套非标准图形(箭头、心形、八角星)区分数据系列


```r
echartR(data = iris, x = ~Sepal.Width, y = ~Petal.Width, series = ~Species,
        type = 'scatter', palette='aetnateal',
        symbolList=c('arrow','heart','star8'),
        title = 'Scatter - Sepal Width vs Petal Width, by Species (iris)',
        xlab = 'Sepal Width', ylab = 'Petal Width')
```

<!--html_preserve--><div id="htmlwidget-9141" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-9141">{"x":{"title":{"text":"Scatter - Sepal Width vs Petal Width, by Species (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"formatter":"function (params) {\n                                                if (params.value.length > 1) {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.value[0] + \" ,    \" +\n                                                + params.value[1];\n                                                } else {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.name + \" : \"\n                                                + params.value;\n                                                }}"},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"scatter","data":[[3.5,0.2],[3,0.2],[3.2,0.2],[3.1,0.2],[3.6,0.2],[3.9,0.4],[3.4,0.3],[3.4,0.2],[2.9,0.2],[3.1,0.1],[3.7,0.2],[3.4,0.2],[3,0.1],[3,0.1],[4,0.2],[4.4,0.4],[3.9,0.4],[3.5,0.3],[3.8,0.3],[3.8,0.3],[3.4,0.2],[3.7,0.4],[3.6,0.2],[3.3,0.5],[3.4,0.2],[3,0.2],[3.4,0.4],[3.5,0.2],[3.4,0.2],[3.2,0.2],[3.1,0.2],[3.4,0.4],[4.1,0.1],[4.2,0.2],[3.1,0.2],[3.2,0.2],[3.5,0.2],[3.6,0.1],[3,0.2],[3.4,0.2],[3.5,0.3],[2.3,0.3],[3.2,0.2],[3.5,0.6],[3.8,0.4],[3,0.3],[3.8,0.2],[3.2,0.2],[3.7,0.2],[3.3,0.2]],"large":false,"name":"setosa"},{"type":"scatter","data":[[3.2,1.4],[3.2,1.5],[3.1,1.5],[2.3,1.3],[2.8,1.5],[2.8,1.3],[3.3,1.6],[2.4,1],[2.9,1.3],[2.7,1.4],[2,1],[3,1.5],[2.2,1],[2.9,1.4],[2.9,1.3],[3.1,1.4],[3,1.5],[2.7,1],[2.2,1.5],[2.5,1.1],[3.2,1.8],[2.8,1.3],[2.5,1.5],[2.8,1.2],[2.9,1.3],[3,1.4],[2.8,1.4],[3,1.7],[2.9,1.5],[2.6,1],[2.4,1.1],[2.4,1],[2.7,1.2],[2.7,1.6],[3,1.5],[3.4,1.6],[3.1,1.5],[2.3,1.3],[3,1.3],[2.5,1.3],[2.6,1.2],[3,1.4],[2.6,1.2],[2.3,1],[2.7,1.3],[3,1.2],[2.9,1.3],[2.9,1.3],[2.5,1.1],[2.8,1.3]],"large":false,"name":"versicolor"},{"type":"scatter","data":[[3.3,2.5],[2.7,1.9],[3,2.1],[2.9,1.8],[3,2.2],[3,2.1],[2.5,1.7],[2.9,1.8],[2.5,1.8],[3.6,2.5],[3.2,2],[2.7,1.9],[3,2.1],[2.5,2],[2.8,2.4],[3.2,2.3],[3,1.8],[3.8,2.2],[2.6,2.3],[2.2,1.5],[3.2,2.3],[2.8,2],[2.8,2],[2.7,1.8],[3.3,2.1],[3.2,1.8],[2.8,1.8],[3,1.8],[2.8,2.1],[3,1.6],[2.8,1.9],[3.8,2],[2.8,2.2],[2.8,1.5],[2.6,1.4],[3,2.3],[3.4,2.4],[3.1,1.8],[3,1.8],[3.1,2.1],[3.1,2.4],[3.1,2.3],[2.7,1.9],[3.2,2.3],[3.3,2.5],[3,2.3],[2.5,1.9],[3,2],[3.4,2.3],[3,1.8]],"large":false,"name":"virginica"}],"renderAsImage":true,"color":["#00A78E","#F47721","#7AC143","#00BCE4","#D20962","#7D3F98","#60C3AE","#FDB933","#B8D936","#5F78BB","#F58F9F","#EE3D94","#5E9732","#CEA979","#EF4135","#7090A5"],"symbolList":["arrow","heart","star8"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"left","y":"top"},"xAxis":{"name":"Sepal Width","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Petal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":["tooltip.formatter"]}</script><!--/html_preserve-->

## Bubble 气泡图

气泡图同样来源于散点图。type改为`bubble`即可，如不指定`weight`变量，函数默认指定y为气泡权重。

### Singular-series Bubble 单系列气泡图


```r
echartR(data = iris, x = ~Sepal.Width, y = ~Petal.Width, 
        weight = ~Petal.Length,
        type = 'bubble', palette='solarized_cyan',
        title = paste("Bubble - Sepal Width vs Petal Width,",
                      "weighed by Petal Length (iris)"),
        xlab = 'Sepal Width', ylab = 'Petal Width')
```

<!--html_preserve--><div id="htmlwidget-9217" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-9217">{"x":{"title":{"text":"Bubble - Sepal Width vs Petal Width, weighed by Petal Length (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"scatter","data":[[3.5,0.2,1.4],[3,0.2,1.4],[3.2,0.2,1.3],[3.1,0.2,1.5],[3.6,0.2,1.4],[3.9,0.4,1.7],[3.4,0.3,1.4],[3.4,0.2,1.5],[2.9,0.2,1.4],[3.1,0.1,1.5],[3.7,0.2,1.5],[3.4,0.2,1.6],[3,0.1,1.4],[3,0.1,1.1],[4,0.2,1.2],[4.4,0.4,1.5],[3.9,0.4,1.3],[3.5,0.3,1.4],[3.8,0.3,1.7],[3.8,0.3,1.5],[3.4,0.2,1.7],[3.7,0.4,1.5],[3.6,0.2,1],[3.3,0.5,1.7],[3.4,0.2,1.9],[3,0.2,1.6],[3.4,0.4,1.6],[3.5,0.2,1.5],[3.4,0.2,1.4],[3.2,0.2,1.6],[3.1,0.2,1.6],[3.4,0.4,1.5],[4.1,0.1,1.5],[4.2,0.2,1.4],[3.1,0.2,1.5],[3.2,0.2,1.2],[3.5,0.2,1.3],[3.6,0.1,1.4],[3,0.2,1.3],[3.4,0.2,1.5],[3.5,0.3,1.3],[2.3,0.3,1.3],[3.2,0.2,1.3],[3.5,0.6,1.6],[3.8,0.4,1.9],[3,0.3,1.4],[3.8,0.2,1.6],[3.2,0.2,1.4],[3.7,0.2,1.5],[3.3,0.2,1.4],[3.2,1.4,4.7],[3.2,1.5,4.5],[3.1,1.5,4.9],[2.3,1.3,4],[2.8,1.5,4.6],[2.8,1.3,4.5],[3.3,1.6,4.7],[2.4,1,3.3],[2.9,1.3,4.6],[2.7,1.4,3.9],[2,1,3.5],[3,1.5,4.2],[2.2,1,4],[2.9,1.4,4.7],[2.9,1.3,3.6],[3.1,1.4,4.4],[3,1.5,4.5],[2.7,1,4.1],[2.2,1.5,4.5],[2.5,1.1,3.9],[3.2,1.8,4.8],[2.8,1.3,4],[2.5,1.5,4.9],[2.8,1.2,4.7],[2.9,1.3,4.3],[3,1.4,4.4],[2.8,1.4,4.8],[3,1.7,5],[2.9,1.5,4.5],[2.6,1,3.5],[2.4,1.1,3.8],[2.4,1,3.7],[2.7,1.2,3.9],[2.7,1.6,5.1],[3,1.5,4.5],[3.4,1.6,4.5],[3.1,1.5,4.7],[2.3,1.3,4.4],[3,1.3,4.1],[2.5,1.3,4],[2.6,1.2,4.4],[3,1.4,4.6],[2.6,1.2,4],[2.3,1,3.3],[2.7,1.3,4.2],[3,1.2,4.2],[2.9,1.3,4.2],[2.9,1.3,4.3],[2.5,1.1,3],[2.8,1.3,4.1],[3.3,2.5,6],[2.7,1.9,5.1],[3,2.1,5.9],[2.9,1.8,5.6],[3,2.2,5.8],[3,2.1,6.6],[2.5,1.7,4.5],[2.9,1.8,6.3],[2.5,1.8,5.8],[3.6,2.5,6.1],[3.2,2,5.1],[2.7,1.9,5.3],[3,2.1,5.5],[2.5,2,5],[2.8,2.4,5.1],[3.2,2.3,5.3],[3,1.8,5.5],[3.8,2.2,6.7],[2.6,2.3,6.9],[2.2,1.5,5],[3.2,2.3,5.7],[2.8,2,4.9],[2.8,2,6.7],[2.7,1.8,4.9],[3.3,2.1,5.7],[3.2,1.8,6],[2.8,1.8,4.8],[3,1.8,4.9],[2.8,2.1,5.6],[3,1.6,5.8],[2.8,1.9,6.1],[3.8,2,6.4],[2.8,2.2,5.6],[2.8,1.5,5.1],[2.6,1.4,5.6],[3,2.3,6.1],[3.4,2.4,5.6],[3.1,1.8,5.5],[3,1.8,4.8],[3.1,2.1,5.4],[3.1,2.4,5.6],[3.1,2.3,5.1],[2.7,1.9,5.1],[3.2,2.3,5.9],[3.3,2.5,5.7],[3,2.3,5.2],[2.5,1.9,5],[3,2,5.2],[3.4,2.3,5.4],[3,1.8,5.1]],"large":false,"symbolSize":"function (value){\n                       return Math.round(value[2]*\n2\n);}"}],"renderAsImage":true,"color":["#2aa198","#b58900","#cb4b16","#dc322f","#d33682","#6c71c4","#268bd2","#859900"],"xAxis":{"name":"Sepal Width","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Petal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":["series.0.symbolSize"]}</script><!--/html_preserve-->

### Multi-series Bubble 多系列气泡图

用`symbolList=c('circle','emptyCircle')`设置第1个数据系列为实心圆、剩下的数据系列以空心圆作为标志图形。palette设置为tableauGnOr(3)，只随机取该色板的3种颜色。


```r
echartR(data = iris, x = ~Sepal.Width, y = ~Petal.Width, 
        weight = ~Petal.Length, series = ~Species, 
        symbolList=c('emptyCircle','circle'),
        type = 'bubble', palette='tableaugnor(3)',
        title = paste('Bubble - Sepal Width vs Petal Width, by Species,',
                      'weighed by Petal Length (iris)'), 
        xlab = 'Sepal Width', ylab = 'Petal Width')
```

<!--html_preserve--><div id="htmlwidget-2979" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2979">{"x":{"title":{"text":"Bubble - Sepal Width vs Petal Width, by Species, weighed by Petal Length (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"formatter":"function (params) {\n                                                if (params.value.length > 1) {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.value[0] + \" ,    \" +\n                                                + params.value[1];\n                                                } else {\n                                                return params.seriesName + \" :<br/>\"\n                                                + params.name + \" : \"\n                                                + params.value;\n                                                }}"},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"scatter","data":[[3.5,0.2,1.4],[3,0.2,1.4],[3.2,0.2,1.3],[3.1,0.2,1.5],[3.6,0.2,1.4],[3.9,0.4,1.7],[3.4,0.3,1.4],[3.4,0.2,1.5],[2.9,0.2,1.4],[3.1,0.1,1.5],[3.7,0.2,1.5],[3.4,0.2,1.6],[3,0.1,1.4],[3,0.1,1.1],[4,0.2,1.2],[4.4,0.4,1.5],[3.9,0.4,1.3],[3.5,0.3,1.4],[3.8,0.3,1.7],[3.8,0.3,1.5],[3.4,0.2,1.7],[3.7,0.4,1.5],[3.6,0.2,1],[3.3,0.5,1.7],[3.4,0.2,1.9],[3,0.2,1.6],[3.4,0.4,1.6],[3.5,0.2,1.5],[3.4,0.2,1.4],[3.2,0.2,1.6],[3.1,0.2,1.6],[3.4,0.4,1.5],[4.1,0.1,1.5],[4.2,0.2,1.4],[3.1,0.2,1.5],[3.2,0.2,1.2],[3.5,0.2,1.3],[3.6,0.1,1.4],[3,0.2,1.3],[3.4,0.2,1.5],[3.5,0.3,1.3],[2.3,0.3,1.3],[3.2,0.2,1.3],[3.5,0.6,1.6],[3.8,0.4,1.9],[3,0.3,1.4],[3.8,0.2,1.6],[3.2,0.2,1.4],[3.7,0.2,1.5],[3.3,0.2,1.4]],"large":false,"name":"setosa","symbolSize":"function (value){\n                           return Math.round(value[2]*\n2\n);\n                     }"},{"type":"scatter","data":[[3.2,1.4,4.7],[3.2,1.5,4.5],[3.1,1.5,4.9],[2.3,1.3,4],[2.8,1.5,4.6],[2.8,1.3,4.5],[3.3,1.6,4.7],[2.4,1,3.3],[2.9,1.3,4.6],[2.7,1.4,3.9],[2,1,3.5],[3,1.5,4.2],[2.2,1,4],[2.9,1.4,4.7],[2.9,1.3,3.6],[3.1,1.4,4.4],[3,1.5,4.5],[2.7,1,4.1],[2.2,1.5,4.5],[2.5,1.1,3.9],[3.2,1.8,4.8],[2.8,1.3,4],[2.5,1.5,4.9],[2.8,1.2,4.7],[2.9,1.3,4.3],[3,1.4,4.4],[2.8,1.4,4.8],[3,1.7,5],[2.9,1.5,4.5],[2.6,1,3.5],[2.4,1.1,3.8],[2.4,1,3.7],[2.7,1.2,3.9],[2.7,1.6,5.1],[3,1.5,4.5],[3.4,1.6,4.5],[3.1,1.5,4.7],[2.3,1.3,4.4],[3,1.3,4.1],[2.5,1.3,4],[2.6,1.2,4.4],[3,1.4,4.6],[2.6,1.2,4],[2.3,1,3.3],[2.7,1.3,4.2],[3,1.2,4.2],[2.9,1.3,4.2],[2.9,1.3,4.3],[2.5,1.1,3],[2.8,1.3,4.1]],"large":false,"name":"versicolor","symbolSize":"function (value){\n                           return Math.round(value[2]*\n2\n);\n                     }"},{"type":"scatter","data":[[3.3,2.5,6],[2.7,1.9,5.1],[3,2.1,5.9],[2.9,1.8,5.6],[3,2.2,5.8],[3,2.1,6.6],[2.5,1.7,4.5],[2.9,1.8,6.3],[2.5,1.8,5.8],[3.6,2.5,6.1],[3.2,2,5.1],[2.7,1.9,5.3],[3,2.1,5.5],[2.5,2,5],[2.8,2.4,5.1],[3.2,2.3,5.3],[3,1.8,5.5],[3.8,2.2,6.7],[2.6,2.3,6.9],[2.2,1.5,5],[3.2,2.3,5.7],[2.8,2,4.9],[2.8,2,6.7],[2.7,1.8,4.9],[3.3,2.1,5.7],[3.2,1.8,6],[2.8,1.8,4.8],[3,1.8,4.9],[2.8,2.1,5.6],[3,1.6,5.8],[2.8,1.9,6.1],[3.8,2,6.4],[2.8,2.2,5.6],[2.8,1.5,5.1],[2.6,1.4,5.6],[3,2.3,6.1],[3.4,2.4,5.6],[3.1,1.8,5.5],[3,1.8,4.8],[3.1,2.1,5.4],[3.1,2.4,5.6],[3.1,2.3,5.1],[2.7,1.9,5.1],[3.2,2.3,5.9],[3.3,2.5,5.7],[3,2.3,5.2],[2.5,1.9,5],[3,2,5.2],[3.4,2.3,5.4],[3,1.8,5.1]],"large":false,"name":"virginica","symbolSize":"function (value){\n                           return Math.round(value[2]*\n2\n);\n                     }"}],"renderAsImage":true,"color":["#3CB7CC","#39737C","#32A251"],"symbolList":["emptyCircle","circle","circle"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"left","y":"top"},"xAxis":{"name":"Sepal Width","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Petal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":["tooltip.formatter","series.0.symbolSize","series.1.symbolSize","series.2.symbolSize"]}</script><!--/html_preserve-->

## Column 柱图

先生成一个汇总数据集`dtiris`。


```r
library(reshape2)
dfiris <- iris
dfiris$id <- row.names(iris)
dfiris <- melt(dfiris,id=c("Species","id"))
names(dfiris) <- c("Species","id","Param","Value")
dtiris <- dcast(dfiris[,c(1,3,4)],Species+Param~.,value.var="Value",mean)
names(dtiris) <- c("Species","Param","Mean")
knitr::kable(dcast(dtiris,Param~Species,sum,value.var="Mean"),
             format='html',caption="Table: Mean of parameters (iris)")
```

<table>
<caption>Table: Mean of parameters (iris)</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Param </th>
   <th style="text-align:right;"> setosa </th>
   <th style="text-align:right;"> versicolor </th>
   <th style="text-align:right;"> virginica </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Sepal.Length </td>
   <td style="text-align:right;"> 5.006 </td>
   <td style="text-align:right;"> 5.936 </td>
   <td style="text-align:right;"> 6.588 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sepal.Width </td>
   <td style="text-align:right;"> 3.428 </td>
   <td style="text-align:right;"> 2.770 </td>
   <td style="text-align:right;"> 2.974 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Petal.Length </td>
   <td style="text-align:right;"> 1.462 </td>
   <td style="text-align:right;"> 4.260 </td>
   <td style="text-align:right;"> 5.552 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Petal.Width </td>
   <td style="text-align:right;"> 0.246 </td>
   <td style="text-align:right;"> 1.326 </td>
   <td style="text-align:right;"> 2.026 </td>
  </tr>
</tbody>
</table>

### Tiled Column 平铺柱图


```r
echartR(data = dtiris, x = ~Param, y = ~Mean,  series = ~Species,
        type = 'bar', palette='fivethirtyeight',
        title = paste("VBar - Parameter Mean by Species", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-5381" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-5381">{"x":{"title":{"text":"VBar - Parameter Mean by Species (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246]},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326]},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026]}],"renderAsImage":true,"color":["#008FD5","#FF2700","#77AB43"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Parameter","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]},"yAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

### Stacked Column 堆积柱图


```r
echartR(data = dtiris, x = ~Param, y = ~Mean, 
        series = ~Species, stack=T,
        type = 'bar', palette='pander',
        title = paste("VBar - Parameter Mean by Species", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-8911" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-8911">{"x":{"title":{"text":"VBar - Parameter Mean by Species (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246],"stack":"Stack"},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326],"stack":"Stack"},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026],"stack":"Stack"}],"renderAsImage":true,"color":["#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999","#E69F00"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Parameter","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]},"yAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

堆积与否，也可以简单地通过工具栏的`平铺`和`堆积`按钮切换。非常强大(但也得在函数配置项里正确地码出代码)。

## Bar 条图

条图和柱图的区别只在于`xyflip`开关选项。

### Tiled Bar 平铺条图


```r
echartR(data = dtiris, x = ~Species, y = ~Mean, series = ~Param, 
        type = 'bar', palette='stata', xyflip=T,
        title = 'Species-specific Mean by Parameters (iris)', 
        xlab = 'Species', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-3028" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3028">{"x":{"title":{"text":"Species-specific Mean by Parameters (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"bar","data":[5.006,5.936,6.588]},{"name":"Sepal.Width","type":"bar","data":[3.428,2.77,2.974]},{"name":"Petal.Length","type":"bar","data":[1.462,4.26,5.552]},{"name":"Petal.Width","type":"bar","data":[0.246,1.326,2.026]}],"renderAsImage":true,"color":["#1a476f","#90353b","#55752f","#e37e00","#6e8e84","#c10534","#938dd2","#cac27e","#a0522d","#7b92a8","#2d6d66","#9c8847","#bfa19c","#ffd200","#d9e6eb"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Species","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["setosa","versicolor","virginica"]}},"evals":[]}</script><!--/html_preserve-->

### Stacked Bar 堆积条图

palette设为calc的随机4种颜色。打开stack (`stack=TRUE`)。


```r
echartR(data = dtiris, x = ~Param, y = ~Mean, 
        series = ~Species, stack=T, xyflip=T,
        type = 'bar', palette='calc',
        title = 'Parameter Mean by Species (iris)', 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-3882" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3882">{"x":{"title":{"text":"Parameter Mean by Species (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246],"stack":"Stack"},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326],"stack":"Stack"},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026],"stack":"Stack"}],"renderAsImage":true,"color":["#004586","#FF420E","#FFD320","#579D1C","#7E0021","#83CAFF","#314004","#AECF00","#4B1F6F","#FF950E","#C5000B","#0084D1"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}},"yAxis":{"name":"Parameter","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]}},"evals":[]}</script><!--/html_preserve-->

## Histogram 直方图

直方图是柱图的一种特例，只需要指定y变量。可通过`splitNumber`指定直方数(默认9)。`xyflip`设为TRUE则成为等价的横条图。

> Echarts规定柱/条图和散点图的自变量轴均为category类型，因此暂时无法简单地做出传统外观的直方图。


```r
echartR(airquality, y=~Temp, type='histogram', splitNumber=13,
        palette='pastel2', title='Histogram of temperature (airquality)')
```

<!--html_preserve--><div id="htmlwidget-2944" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2944">{"x":{"title":{"text":"Histogram of temperature (airquality)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"type":"bar","data":[7,5,5,11,7,12,26,22,18,17,8,10,4],"barGap":"1%"}],"renderAsImage":true,"color":["#B3E2CD","#FDCDAC","#CBD5E8","#F4CAE4","#E6F5C9","#FFF2AE","#F1E2CC","#CCCCCC"],"xAxis":{"name":"Temp","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["~59.2","59.2~","62.3~","65.5~","68.6~","71.8~","74.9~","78.1~","81.2~","84.4~","87.5~","90.7~","93.8~"]},"yAxis":{"name":"Freq","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

## Pie 饼图

用`mtcars`作为作图数据集。


```r
dtcars <- mtcars
dtcars$car <- row.names(dtcars)
dtcars$transmission <- as.factor(dtcars$am)
levels(dtcars$transmission) <- c("Automatic","Manual")
dtcars$cylinder <- as.factor(dtcars$cyl)
dtcars$carburetor <-as.factor(dtcars$carb)
```


```r
echartR(dtcars, x = ~transmission,  y = ~car, type='pie',
        palette='darkunica', 
        title='Number of cars by transmission (mtcars)')
```

<!--html_preserve--><div id="htmlwidget-223" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-223">{"x":{"title":{"text":"Number of cars by transmission (mtcars)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"formatter":"{a} <br/>{b} : {c} ({d}%)"},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["pie","funnel"],"option":{"funnel":{"x":"25%","width":"80%","funnelAlign":"center"}},"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"transmission","type":"pie","data":[{"value":19,"name":"Automatic"},{"value":13,"name":"Manual"}],"radius":"70%","center":["50%","50%"]}],"renderAsImage":true,"color":["#2b908f","#90ee7e","#f45b5b","#7798BF","#aaeeee","#ff0066","#eeaaee","#55BF3B","#DF5353","#7798BF","#aaeeee"],"legend":{"show":true,"data":["Automatic","Manual"],"x":"left","y":"top"}},"evals":[]}</script><!--/html_preserve-->

## Ring 环图

环形图是饼图的变形，只需将`type`改为'ring'。Echarts中只需要把饼图的半径参数扩展为包含内、外径的长度为2的向量即可。


```r
echartR(dtcars, x = ~cylinder,  y = ~car, type='ring',
        palette='hc', title='Number of Cylinders (mtcars)')
```

<!--html_preserve--><div id="htmlwidget-8328" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-8328">{"x":{"title":{"text":"Number of Cylinders (mtcars)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"formatter":"{a} <br/>{b} : {c} ({d}%)"},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["pie","funnel"],"option":{"funnel":{"x":"25%","width":"80%","funnelAlign":"center"}},"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"cylinder","type":"pie","data":[{"value":11,"name":"4"},{"value":7,"name":"6"},{"value":14,"name":"8"}],"radius":["60%","80%"],"itemStyle":{"emphasis":{"label":{"show":true,"position":"center","textStyle":{"fontSize":"30","fontWeight":"bold"}}}}}],"renderAsImage":true,"color":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#8085e8"],"legend":{"show":true,"data":["4","6","8"],"x":"left","y":"top"}},"evals":[]}</script><!--/html_preserve-->

## Line 线图

### Unstacked Line 平铺线图

打开数据缩放`dataZoom=T`


```r
data(airquality)
airquality$Date <- strptime(paste(2015,airquality$Month,airquality$Day,sep="-")
                            ,format="%Y-%m-%d")
airquality$strDate <- with(airquality,paste(2015,Month,Day,sep="-"))
airquality$TempG <- cut(airquality$Temp,breaks=c(0,60,70,80,100))
#echartR(airquality, x = ~Date, y= ~Wind,
#          type='line', dataZoom=T,
#        palette='tableauBlRd', xlab = 'Date', ylab = 'Wind',
#        title='Wind by day (airquality)')
echartR(airquality, x = ~Day, y= ~Wind, series=~Month,
          type='line', dataZoom=T, dataZoomRange=c(30,70),
        palette='tableauBlRd', xlab = 'Days', ylab = 'Wind',
        title='Day-specific Wind by month (airquality)', symbolList='none')
```

<!--html_preserve--><div id="htmlwidget-9589" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-9589">{"x":{"title":{"text":"Day-specific Wind by month (airquality)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"5","type":"line","data":["7.4","8","12.6","11.5","14.3","14.9","8.6","13.8","20.1","8.6","6.9","9.7","9.2","10.9","13.2","11.5","12","18.4","11.5","9.7","9.7","16.6","9.7","12","16.6","14.9","8","12","14.9","5.7","7.4"]},{"name":"6","type":"line","data":["8.6","9.7","16.1","9.2","8.6","14.3","9.7","6.9","13.8","11.5","10.9","9.2","8","13.8","11.5","14.9","20.7","9.2","11.5","10.3","6.3","1.7","4.6","6.3","8","8","10.3","11.5","14.9","8"]},{"name":"7","type":"line","data":["4.1","9.2","9.2","10.9","4.6","10.9","5.1","6.3","5.7","7.4","8.6","14.3","14.9","14.9","14.3","6.9","10.3","6.3","5.1","11.5","6.9","9.7","11.5","8.6","8","8.6","12","7.4","7.4","7.4","9.2"]},{"name":"8","type":"line","data":["6.9","13.8","7.4","6.9","7.4","4.6","4","10.3","8","8.6","11.5","11.5","11.5","9.7","11.5","10.3","6.3","7.4","10.9","10.3","15.5","14.3","12.6","9.7","3.4","8","5.7","9.7","2.3","6.3","6.3"]},{"name":"9","type":"line","data":["6.9","5.1","2.8","4.6","7.4","15.5","10.9","10.3","10.9","9.7","14.9","15.5","6.3","10.9","11.5","6.9","13.8","10.3","10.3","8","12.6","9.2","10.3","10.3","16.6","6.9","13.2","14.3","8","11.5"]}],"renderAsImage":true,"color":["#2C69B0","#F02720","#AC613C","#6BA3D6","#AC8763","#BD0A36"],"symbolList":["none","none","none","none","none"],"dataZoom":{"show":true,"start":30,"end":70},"legend":{"show":true,"data":["5","6","7","8","9"],"x":"left","y":"top"},"xAxis":{"name":"Days","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]},"yAxis":{"name":"Wind","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

线段平滑(`type='linesmooth'`)，不显示标志图形(`symbolList='none'`)。Echarts对缺失值默认不填补，因此有很多断线。需要在数据前处理时自行作插值运算。


```r
airq <- melt(airquality[,c("Ozone","Solar.R","Wind","Temp","strDate")],
             id=c("strDate"))
echartR(airq, x = ~strDate, y= ~value, series= ~variable, type='linesmooth',
        symbolList='none', dataZoom=T, dataZoomRange=c(20,50),
        palette='tableauPrGy', xlab = 'Date', ylab = 'Measure',
        title='Climate measures by day (airquality)')
```

<!--html_preserve--><div id="htmlwidget-3582" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3582">{"x":{"title":{"text":"Climate measures by day (airquality)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Ozone","type":"line","data":["41","36","12","18","-","28","23","19","8","-","7","16","11","14","18","14","34","6","30","11","1","11","4","32","-","-","-","23","45","115","37","-","-","-","-","-","-","29","-","71","39","-","-","23","-","-","21","37","20","12","13","-","-","-","-","-","-","-","-","-","-","135","49","32","-","64","40","77","97","97","85","-","10","27","-","7","48","35","61","79","63","16","-","-","80","108","20","52","82","50","64","59","39","9","16","78","35","66","122","89","110","-","-","44","28","65","-","22","59","23","31","44","21","9","-","45","168","73","-","76","118","84","85","96","78","73","91","47","32","20","23","21","24","44","21","28","9","13","46","18","13","24","16","13","23","36","7","14","30","-","14","18","20"],"smooth":true},{"name":"Solar.R","type":"line","data":["190","118","149","313","-","-","299","99","19","194","-","256","290","274","65","334","307","78","322","44","8","320","25","92","66","266","-","13","252","223","279","286","287","242","186","220","264","127","273","291","323","259","250","148","332","322","191","284","37","120","137","150","59","91","250","135","127","47","98","31","138","269","248","236","101","175","314","276","267","272","175","139","264","175","291","48","260","274","285","187","220","7","258","295","294","223","81","82","213","275","253","254","83","24","77","-","-","-","255","229","207","222","137","192","273","157","64","71","51","115","244","190","259","36","255","212","238","215","153","203","225","237","188","167","197","183","189","95","92","252","220","230","259","236","259","238","24","112","237","224","27","238","201","238","14","139","49","20","193","145","191","131","223"],"smooth":true},{"name":"Wind","type":"line","data":["7.4","8","12.6","11.5","14.3","14.9","8.6","13.8","20.1","8.6","6.9","9.7","9.2","10.9","13.2","11.5","12","18.4","11.5","9.7","9.7","16.6","9.7","12","16.6","14.9","8","12","14.9","5.7","7.4","8.6","9.7","16.1","9.2","8.6","14.3","9.7","6.9","13.8","11.5","10.9","9.2","8","13.8","11.5","14.9","20.7","9.2","11.5","10.3","6.3","1.7","4.6","6.3","8","8","10.3","11.5","14.9","8","4.1","9.2","9.2","10.9","4.6","10.9","5.1","6.3","5.7","7.4","8.6","14.3","14.9","14.9","14.3","6.9","10.3","6.3","5.1","11.5","6.9","9.7","11.5","8.6","8","8.6","12","7.4","7.4","7.4","9.2","6.9","13.8","7.4","6.9","7.4","4.6","4","10.3","8","8.6","11.5","11.5","11.5","9.7","11.5","10.3","6.3","7.4","10.9","10.3","15.5","14.3","12.6","9.7","3.4","8","5.7","9.7","2.3","6.3","6.3","6.9","5.1","2.8","4.6","7.4","15.5","10.9","10.3","10.9","9.7","14.9","15.5","6.3","10.9","11.5","6.9","13.8","10.3","10.3","8","12.6","9.2","10.3","10.3","16.6","6.9","13.2","14.3","8","11.5"],"smooth":true},{"name":"Temp","type":"line","data":["67","72","74","62","56","66","65","59","61","69","74","69","66","68","58","64","66","57","68","62","59","73","61","61","57","58","57","67","81","79","76","78","74","67","84","85","79","82","87","90","87","93","92","82","80","79","77","72","65","73","76","77","76","76","76","75","78","73","80","77","83","84","85","81","84","83","83","88","92","92","89","82","73","81","91","80","81","82","84","87","85","74","81","82","86","85","82","86","88","86","83","81","81","81","82","86","85","87","89","90","90","92","86","86","82","80","79","77","79","76","78","78","77","72","75","79","81","86","88","97","94","96","94","91","92","93","93","87","84","80","78","75","73","81","76","77","71","71","78","67","76","68","82","64","71","81","69","63","70","77","75","76","68"],"smooth":true}],"renderAsImage":true,"color":["#7B66D2","#DC5FBD","#5F5A41","#995688","#AB6AD5","#8B7C6E"],"symbolList":["none","none","none","none"],"dataZoom":{"show":true,"start":20,"end":50},"legend":{"show":true,"data":["Ozone","Solar.R","Wind","Temp"],"x":"left","y":"top"},"xAxis":{"name":"Date","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["2015-5-1","2015-5-2","2015-5-3","2015-5-4","2015-5-5","2015-5-6","2015-5-7","2015-5-8","2015-5-9","2015-5-10","2015-5-11","2015-5-12","2015-5-13","2015-5-14","2015-5-15","2015-5-16","2015-5-17","2015-5-18","2015-5-19","2015-5-20","2015-5-21","2015-5-22","2015-5-23","2015-5-24","2015-5-25","2015-5-26","2015-5-27","2015-5-28","2015-5-29","2015-5-30","2015-5-31","2015-6-1","2015-6-2","2015-6-3","2015-6-4","2015-6-5","2015-6-6","2015-6-7","2015-6-8","2015-6-9","2015-6-10","2015-6-11","2015-6-12","2015-6-13","2015-6-14","2015-6-15","2015-6-16","2015-6-17","2015-6-18","2015-6-19","2015-6-20","2015-6-21","2015-6-22","2015-6-23","2015-6-24","2015-6-25","2015-6-26","2015-6-27","2015-6-28","2015-6-29","2015-6-30","2015-7-1","2015-7-2","2015-7-3","2015-7-4","2015-7-5","2015-7-6","2015-7-7","2015-7-8","2015-7-9","2015-7-10","2015-7-11","2015-7-12","2015-7-13","2015-7-14","2015-7-15","2015-7-16","2015-7-17","2015-7-18","2015-7-19","2015-7-20","2015-7-21","2015-7-22","2015-7-23","2015-7-24","2015-7-25","2015-7-26","2015-7-27","2015-7-28","2015-7-29","2015-7-30","2015-7-31","2015-8-1","2015-8-2","2015-8-3","2015-8-4","2015-8-5","2015-8-6","2015-8-7","2015-8-8","2015-8-9","2015-8-10","2015-8-11","2015-8-12","2015-8-13","2015-8-14","2015-8-15","2015-8-16","2015-8-17","2015-8-18","2015-8-19","2015-8-20","2015-8-21","2015-8-22","2015-8-23","2015-8-24","2015-8-25","2015-8-26","2015-8-27","2015-8-28","2015-8-29","2015-8-30","2015-8-31","2015-9-1","2015-9-2","2015-9-3","2015-9-4","2015-9-5","2015-9-6","2015-9-7","2015-9-8","2015-9-9","2015-9-10","2015-9-11","2015-9-12","2015-9-13","2015-9-14","2015-9-15","2015-9-16","2015-9-17","2015-9-18","2015-9-19","2015-9-20","2015-9-21","2015-9-22","2015-9-23","2015-9-24","2015-9-25","2015-9-26","2015-9-27","2015-9-28","2015-9-29","2015-9-30"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

### Stacked Line 堆积线图

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='line',stack=T,
        palette='tableauBlRd12', xlab = 'Sample ID', ylab = 'Measure',
        title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-4048" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-4048">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"stack":"Stack"},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"stack":"Stack"},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"stack":"Stack"},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"stack":"Stack"}],"renderAsImage":true,"color":["#2C69B0","#B5C8E2","#F02720","#FFB6B0","#AC613C","#E9C39B","#6BA3D6","#B5DFFD","#AC8763","#DDC9B4","#BD0A36","#F4737A"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

线段平滑，不显示标志图形

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='linesmooth',stack=T,
        palette='tableauGnOr12', xlab = 'Sample ID', ylab = 'Measure',
        symbolList='none',
        title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-2962" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2962">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"stack":"Stack","smooth":true},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"stack":"Stack","smooth":true},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"stack":"Stack","smooth":true},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"stack":"Stack","smooth":true}],"renderAsImage":true,"color":["#32A251","#ACD98D","#FF7F0F","#FFB977","#3CB7CC","#98D9E4","#B85A0D","#FFD94A","#39737C","#86B4A9","#82853B","#CCC94D"],"symbolList":["none","none","none","none"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

## Area 面积图
Echarts中，面积图本质上被定义为线图，只需通过`itemStyle`参数渲染颜色。

### Tiled Area 平铺面积图

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='area',
        palette='brbg', xlab = 'Sample ID', ylab = 'Measure',
        symbolList='emptyDiamond',title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-479" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-479">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}}}],"renderAsImage":true,"color":["#543005","#8C510A","#BF812D","#DFC27D","#F6E8C3","#F5F5F5","#C7EAE5","#80CDC1","#35978F","#01665E","#003C30"],"symbolList":["emptyDiamond","emptyDiamond","emptyDiamond","emptyDiamond"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

线段平滑`type='areasmooth'`，并打开数据缩放`dataZoom=TRUE`，初始显示40%-80%。

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='areasmooth',
        palette='PiYG', xlab = 'Sample ID', ylab = 'Measure', 
        symbolList='none', dataZoom=T, dataZoomRange=c(40,80),
        title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-6258" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-6258">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true}],"renderAsImage":true,"color":["#8E0152","#C51B7D","#DE77AE","#F1B6DA","#FDE0EF","#F7F7F7","#E6F5D0","#B8E186","#7FBC41","#4D9221","#276419"],"symbolList":["none","none","none","none"],"dataZoom":{"show":true,"start":40,"end":80},"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

### Stacked Area 堆积面积图

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='area',stack=T,
        palette='PRGn', xlab = 'Sample ID', ylab = 'Measure',
        symbolList='emptyCircle',
        title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-3021" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3021">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}}},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}}}],"renderAsImage":true,"color":["#40004B","#762A83","#9970AB","#C2A5CF","#E7D4E8","#F7F7F7","#D9F0D3","#A6DBA0","#5AAE61","#1B7837","#00441B"],"symbolList":["emptyCircle","emptyCircle","emptyCircle","emptyCircle"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

线段平滑(`type='areasmooth'`)。自定义色板向量。

```r
echartR(dfiris, x = ~id, y= ~Value, series= ~Param, type='areasmooth',stack=T,
        palette=c('red','yellow','limegreen','skyblue'), 
        xlab = 'Sample ID', ylab = 'Measure', 
        symbolList='none',
        title='Parameter measures (iris)')
```

<!--html_preserve--><div id="htmlwidget-994" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-994">{"x":{"title":{"text":"Parameter measures (iris)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":true,"type":["line","bar","tiled","stack"],"title":{"line":"鎶樼嚎鍥惧垏鎹? Switch to line chart","bar":"鏌卞舰鍥惧垏鎹? Switch to bar chart","stack":"鍫嗙Н Stack","tiled":"骞抽摵 Tile","force":"鍔涘鍚戝竷灞�鍥惧垏鎹? Switch to force chart","pie":"楗煎浘鍒囨崲 Switch to pie chart","funnel":"婕忔枟鍥惧垏鎹? Switch to funnel chart"}},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"Sepal.Length","type":"line","data":["5.1","4.9","4.7","4.6","5","5.4","4.6","5","4.4","4.9","5.4","4.8","4.8","4.3","5.8","5.7","5.4","5.1","5.7","5.1","5.4","5.1","4.6","5.1","4.8","5","5","5.2","5.2","4.7","4.8","5.4","5.2","5.5","4.9","5","5.5","4.9","4.4","5.1","5","4.5","4.4","5","5.1","4.8","5.1","4.6","5.3","5","7","6.4","6.9","5.5","6.5","5.7","6.3","4.9","6.6","5.2","5","5.9","6","6.1","5.6","6.7","5.6","5.8","6.2","5.6","5.9","6.1","6.3","6.1","6.4","6.6","6.8","6.7","6","5.7","5.5","5.5","5.8","6","5.4","6","6.7","6.3","5.6","5.5","5.5","6.1","5.8","5","5.6","5.7","5.7","6.2","5.1","5.7","6.3","5.8","7.1","6.3","6.5","7.6","4.9","7.3","6.7","7.2","6.5","6.4","6.8","5.7","5.8","6.4","6.5","7.7","7.7","6","6.9","5.6","7.7","6.3","6.7","7.2","6.2","6.1","6.4","7.2","7.4","7.9","6.4","6.3","6.1","7.7","6.3","6.4","6","6.9","6.7","6.9","5.8","6.8","6.7","6.7","6.3","6.5","6.2","5.9"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Sepal.Width","type":"line","data":["3.5","3","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1","3.7","3.4","3","3","4","4.4","3.9","3.5","3.8","3.8","3.4","3.7","3.6","3.3","3.4","3","3.4","3.5","3.4","3.2","3.1","3.4","4.1","4.2","3.1","3.2","3.5","3.6","3","3.4","3.5","2.3","3.2","3.5","3.8","3","3.8","3.2","3.7","3.3","3.2","3.2","3.1","2.3","2.8","2.8","3.3","2.4","2.9","2.7","2","3","2.2","2.9","2.9","3.1","3","2.7","2.2","2.5","3.2","2.8","2.5","2.8","2.9","3","2.8","3","2.9","2.6","2.4","2.4","2.7","2.7","3","3.4","3.1","2.3","3","2.5","2.6","3","2.6","2.3","2.7","3","2.9","2.9","2.5","2.8","3.3","2.7","3","2.9","3","3","2.5","2.9","2.5","3.6","3.2","2.7","3","2.5","2.8","3.2","3","3.8","2.6","2.2","3.2","2.8","2.8","2.7","3.3","3.2","2.8","3","2.8","3","2.8","3.8","2.8","2.8","2.6","3","3.4","3.1","3","3.1","3.1","3.1","2.7","3.2","3.3","3","2.5","3","3.4","3"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Petal.Length","type":"line","data":["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5","1.5","1.6","1.4","1.1","1.2","1.5","1.3","1.4","1.7","1.5","1.7","1.5","1","1.7","1.9","1.6","1.6","1.5","1.4","1.6","1.6","1.5","1.5","1.4","1.5","1.2","1.3","1.4","1.3","1.5","1.3","1.3","1.3","1.6","1.9","1.4","1.6","1.4","1.5","1.4","4.7","4.5","4.9","4","4.6","4.5","4.7","3.3","4.6","3.9","3.5","4.2","4","4.7","3.6","4.4","4.5","4.1","4.5","3.9","4.8","4","4.9","4.7","4.3","4.4","4.8","5","4.5","3.5","3.8","3.7","3.9","5.1","4.5","4.5","4.7","4.4","4.1","4","4.4","4.6","4","3.3","4.2","4.2","4.2","4.3","3","4.1","6","5.1","5.9","5.6","5.8","6.6","4.5","6.3","5.8","6.1","5.1","5.3","5.5","5","5.1","5.3","5.5","6.7","6.9","5","5.7","4.9","6.7","4.9","5.7","6","4.8","4.9","5.6","5.8","6.1","6.4","5.6","5.1","5.6","6.1","5.6","5.5","4.8","5.4","5.6","5.1","5.1","5.9","5.7","5.2","5","5.2","5.4","5.1"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true},{"name":"Petal.Width","type":"line","data":["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1","0.2","0.2","0.1","0.1","0.2","0.4","0.4","0.3","0.3","0.3","0.2","0.4","0.2","0.5","0.2","0.2","0.4","0.2","0.2","0.2","0.2","0.4","0.1","0.2","0.2","0.2","0.2","0.1","0.2","0.2","0.3","0.3","0.2","0.6","0.4","0.3","0.2","0.2","0.2","0.2","1.4","1.5","1.5","1.3","1.5","1.3","1.6","1","1.3","1.4","1","1.5","1","1.4","1.3","1.4","1.5","1","1.5","1.1","1.8","1.3","1.5","1.2","1.3","1.4","1.4","1.7","1.5","1","1.1","1","1.2","1.6","1.5","1.6","1.5","1.3","1.3","1.3","1.2","1.4","1.2","1","1.3","1.2","1.3","1.3","1.1","1.3","2.5","1.9","2.1","1.8","2.2","2.1","1.7","1.8","1.8","2.5","2","1.9","2.1","2","2.4","2.3","1.8","2.2","2.3","1.5","2.3","2","2","1.8","2.1","1.8","1.8","1.8","2.1","1.6","1.9","2","2.2","1.5","1.4","2.3","2.4","1.8","1.8","2.1","2.4","2.3","1.9","2.3","2.5","2.3","1.9","2","2.3","1.8"],"stack":"Stack","itemStyle":{"normal":{"areaStyle":{"type":"default"}}},"smooth":true}],"renderAsImage":true,"color":["#FF0000","#FFFF00","#32CD32","#87CEEB"],"symbolList":["none","none","none","none"],"legend":{"show":true,"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"],"x":"left","y":"top"},"xAxis":{"name":"Sample ID","type":"category","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":false},"data":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]},"yAxis":{"name":"Measure","type":"value","scale":true,"axisLine":{"show":true,"onZero":false}}},"evals":[]}</script><!--/html_preserve-->

## Funnel 漏斗图

### Funnel 普通漏斗图


```r
echartR(dtcars, x = ~carburetor,  y = ~car, type='funnel',
        palette='RdBu', title='Number of carburetors of cars (mtcars)')
```

<!--html_preserve--><div id="htmlwidget-2032" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2032">{"x":{"title":{"text":"Number of carburetors of cars (mtcars)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"carburetor","type":"funnel","data":[{"value":7,"name":"1"},{"value":10,"name":"2"},{"value":3,"name":"3"},{"value":10,"name":"4"},{"value":1,"name":"6"},{"value":1,"name":"8"}],"x":"10%"}],"renderAsImage":true,"color":["#67001F","#B2182B","#D6604D","#F4A582","#FDDBC7","#F7F7F7","#D1E5F0","#92C5DE","#4393C3","#2166AC","#053061"],"legend":{"show":true,"data":["1","2","3","4","6","8"],"x":"left","y":"top"}},"evals":[]}</script><!--/html_preserve-->

### Pyramid 金字塔图
金字塔图即逆序漏斗图。


```r
echartR(dtcars, x = ~carburetor,  y = ~car, type='pyramid',
        palette='RdGy', title='Number of carburetors of cars (mtcars)')
```

<!--html_preserve--><div id="htmlwidget-8549" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-8549">{"x":{"title":{"text":"Number of carburetors of cars (mtcars)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"carburetor","type":"funnel","data":[{"value":7,"name":"1"},{"value":10,"name":"2"},{"value":3,"name":"3"},{"value":10,"name":"4"},{"value":1,"name":"6"},{"value":1,"name":"8"}],"x":"25%","sort":"ascending"}],"renderAsImage":true,"color":["#67001F","#B2182B","#D6604D","#F4A582","#FDDBC7","#FFFFFF","#E0E0E0","#BABABA","#878787","#4D4D4D","#1A1A1A"],"legend":{"show":true,"data":["1","2","3","4","6","8"],"x":"left","y":"top"}},"evals":[]}</script><!--/html_preserve-->

## Radar 雷达图

雷达图就是极坐标系下的线图/面积图，通过Echarts的`polar`参数模块控制。

```r
player <- data.frame(name=c(rep("Philipp Lahm",8),rep("Dani Alves",8)),
                     para=rep(c("Passing%","Key passing","Comp crosses",
                                "Crossing%","Successful dribbles",
                                "Dispossessed","Dribbled past","Fouls"),2),
                     value=c(89.67, 1.51, 0.97, 24.32, 0.83, 0.86, 1.15, 0.47,
                            86.62, 2.11, 0.99, 20.78, 1.58, 1.64, 0.9, 1.71))
```

### Hollow Radar 空心雷达


```r
echartR(player, x= ~para, y= ~value, series= ~name, type='radar',
        symbolList='none', palette=c('red','blue'),
        title='Lahm vs Alves (by @mixedknuts)')
```

<!--html_preserve--><div id="htmlwidget-6657" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-6657">{"x":{"title":{"text":"Lahm vs Alves (by @mixedknuts)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"value","type":"radar","data":[{"value":[86.62,2.11,0.99,20.78,1.58,1.64,0.9,1.71],"name":"Dani Alves"},{"value":[89.67,1.51,0.97,24.32,0.83,0.86,1.15,0.47],"name":"Philipp Lahm"}]}],"renderAsImage":true,"color":["#FF0000","#0000FF"],"symbolList":["none","none"],"legend":{"show":true,"data":["Dani Alves","Philipp Lahm"],"x":"left","y":"top"},"polar":[{"indicator":[{"text":"Passing%","max":112.0875},{"text":"Key passing","max":2.6375},{"text":"Comp crosses","max":1.2375},{"text":"Crossing%","max":30.4},{"text":"Successful dribbles","max":1.975},{"text":"Dispossessed","max":2.05},{"text":"Dribbled past","max":1.4375},{"text":"Fouls","max":2.1375}]}]},"evals":[]}</script><!--/html_preserve-->

### Solid Radar 实心雷达


```r
echartR(player, x= ~para, y= ~value, series= ~name, type='radarfill',
        symbolList='none', palette=c('firebrick1','dodgerblue'),
        title='Lahm vs Alves (by @mixedknuts)')
```

<!--html_preserve--><div id="htmlwidget-1271" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-1271">{"x":{"title":{"text":"Lahm vs Alves (by @mixedknuts)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"top"},"calculable":true,"series":[{"name":"value","type":"radar","data":[{"value":[86.62,2.11,0.99,20.78,1.58,1.64,0.9,1.71],"name":"Dani Alves"},{"value":[89.67,1.51,0.97,24.32,0.83,0.86,1.15,0.47],"name":"Philipp Lahm"}],"itemStyle":{"normal":{"areaStyle":{"type":"default"}}}}],"renderAsImage":true,"color":["#FF3030","#1E90FF"],"symbolList":["none","none"],"legend":{"show":true,"data":["Dani Alves","Philipp Lahm"],"x":"left","y":"top"},"polar":[{"indicator":[{"text":"Passing%","max":112.0875},{"text":"Key passing","max":2.6375},{"text":"Comp crosses","max":1.2375},{"text":"Crossing%","max":30.4},{"text":"Successful dribbles","max":1.975},{"text":"Dispossessed","max":2.05},{"text":"Dribbled past","max":1.4375},{"text":"Fouls","max":2.1375}]}]},"evals":[]}</script><!--/html_preserve-->

## Map 地图

R和Rstudio的中文转码在Windows里一直是老大难。在本文档，Rstudio的默认编码采用CP936编码，文档用UTF-8。如直接在程序内读数据集，用iconv转码后，落单的汉字仍然会显示为乱码。可先下载[ChinaGDP.txt](https://raw.githubusercontent.com/madlogos/Shared_Doc/master/Shared_Documents/ChinaGDP.txt)到本地，`readLines`读入。


```r
#gdp <- readLines("https://raw.githubusercontent.com/madlogos/Shared_Doc/master/Shared_Documents/ChinaGDP.txt")
gdp <- readLines("ChinaGDP.txt")
dtgdp <- unlist(strsplit(gdp,split=","))
dtgdp <- as.data.frame(t(matrix(dtgdp,nrow=3)),stringsAsFactors=F)
names(dtgdp) <- c('Year','Prov',"GDP")
dtgdp$GDP <- as.numeric(dtgdp$GDP) 
knitr::kable(dcast(dtgdp,Prov~Year,sum,value.var="GDP"), format='html',
         caption="Table: 2012-2014 GDP of Provinces in China (Million USD)")
```

<table>
<caption>Table: 2012-2014 GDP of Provinces in China (Million USD)</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Prov </th>
   <th style="text-align:right;"> 2012 </th>
   <th style="text-align:right;"> 2013 </th>
   <th style="text-align:right;"> 2014 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 安徽 </td>
   <td style="text-align:right;"> 272666 </td>
   <td style="text-align:right;"> 307416 </td>
   <td style="text-align:right;"> 339401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 北京 </td>
   <td style="text-align:right;"> 283238 </td>
   <td style="text-align:right;"> 314871 </td>
   <td style="text-align:right;"> 347249 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 福建 </td>
   <td style="text-align:right;"> 312107 </td>
   <td style="text-align:right;"> 351347 </td>
   <td style="text-align:right;"> 391609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 甘肃 </td>
   <td style="text-align:right;"> 89508 </td>
   <td style="text-align:right;"> 101208 </td>
   <td style="text-align:right;"> 111273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 广东 </td>
   <td style="text-align:right;"> 904046 </td>
   <td style="text-align:right;"> 1003746 </td>
   <td style="text-align:right;"> 1103605 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 广西 </td>
   <td style="text-align:right;"> 206497 </td>
   <td style="text-align:right;"> 232158 </td>
   <td style="text-align:right;"> 255144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 贵州 </td>
   <td style="text-align:right;"> 108550 </td>
   <td style="text-align:right;"> 129284 </td>
   <td style="text-align:right;"> 150599 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 海南 </td>
   <td style="text-align:right;"> 45236 </td>
   <td style="text-align:right;"> 50805 </td>
   <td style="text-align:right;"> 56989 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 河北 </td>
   <td style="text-align:right;"> 420990 </td>
   <td style="text-align:right;"> 456976 </td>
   <td style="text-align:right;"> 478953 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 河南 </td>
   <td style="text-align:right;"> 468900 </td>
   <td style="text-align:right;"> 519212 </td>
   <td style="text-align:right;"> 568786 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 黑龙江 </td>
   <td style="text-align:right;"> 216896 </td>
   <td style="text-align:right;"> 232237 </td>
   <td style="text-align:right;"> 244829 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 湖北 </td>
   <td style="text-align:right;"> 352482 </td>
   <td style="text-align:right;"> 398316 </td>
   <td style="text-align:right;"> 445514 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 湖南 </td>
   <td style="text-align:right;"> 350958 </td>
   <td style="text-align:right;"> 395622 </td>
   <td style="text-align:right;"> 440328 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 吉林 </td>
   <td style="text-align:right;"> 189136 </td>
   <td style="text-align:right;"> 209608 </td>
   <td style="text-align:right;"> 224715 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 江苏 </td>
   <td style="text-align:right;"> 856368 </td>
   <td style="text-align:right;"> 955269 </td>
   <td style="text-align:right;"> 1059587 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 江西 </td>
   <td style="text-align:right;"> 205131 </td>
   <td style="text-align:right;"> 231520 </td>
   <td style="text-align:right;"> 255724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 辽宁 </td>
   <td style="text-align:right;"> 393607 </td>
   <td style="text-align:right;"> 437216 </td>
   <td style="text-align:right;"> 466018 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 内蒙古 </td>
   <td style="text-align:right;"> 251574 </td>
   <td style="text-align:right;"> 271788 </td>
   <td style="text-align:right;"> 289274 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 宁夏 </td>
   <td style="text-align:right;"> 37090 </td>
   <td style="text-align:right;"> 41417 </td>
   <td style="text-align:right;"> 44802 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 青海 </td>
   <td style="text-align:right;"> 29997 </td>
   <td style="text-align:right;"> 33925 </td>
   <td style="text-align:right;"> 37460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 山东 </td>
   <td style="text-align:right;"> 792289 </td>
   <td style="text-align:right;"> 882974 </td>
   <td style="text-align:right;"> 967419 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 山西 </td>
   <td style="text-align:right;"> 191886 </td>
   <td style="text-align:right;"> 203485 </td>
   <td style="text-align:right;"> 207714 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 陕西 </td>
   <td style="text-align:right;"> 228969 </td>
   <td style="text-align:right;"> 259078 </td>
   <td style="text-align:right;"> 287978 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 上海 </td>
   <td style="text-align:right;"> 319710 </td>
   <td style="text-align:right;"> 348804 </td>
   <td style="text-align:right;"> 383554 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 四川 </td>
   <td style="text-align:right;"> 378183 </td>
   <td style="text-align:right;"> 424026 </td>
   <td style="text-align:right;"> 464555 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 天津 </td>
   <td style="text-align:right;"> 204259 </td>
   <td style="text-align:right;"> 232031 </td>
   <td style="text-align:right;"> 255950 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 西藏 </td>
   <td style="text-align:right;"> 11105 </td>
   <td style="text-align:right;"> 13041 </td>
   <td style="text-align:right;"> 14990 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 新疆 </td>
   <td style="text-align:right;"> 118896 </td>
   <td style="text-align:right;"> 134991 </td>
   <td style="text-align:right;"> 150812 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 云南 </td>
   <td style="text-align:right;"> 163318 </td>
   <td style="text-align:right;"> 189255 </td>
   <td style="text-align:right;"> 208612 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 浙江 </td>
   <td style="text-align:right;"> 549154 </td>
   <td style="text-align:right;"> 606609 </td>
   <td style="text-align:right;"> 653668 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 重庆 </td>
   <td style="text-align:right;"> 180746 </td>
   <td style="text-align:right;"> 204364 </td>
   <td style="text-align:right;"> 232230 </td>
  </tr>
</tbody>
</table>

```r
dtgdp$Prov <- as.factor(enc2native(dtgdp$Prov))
dtgdp$Year<- as.factor(dtgdp$Year)
```

### Area 区块标注

开启数据漫游，并定义色板。


```r
echartR(dtgdp, x = ~Prov, y = ~GDP, series= ~Year, 
        type=c('map','china','area'), palette='gdocs',
        title="GDPs of China Provinces, 2012-2014 (Million USD)",
        dataRangePalette=c('red','orange','yellow','green','limegreen'),
        dataRange=c('High',"Low"),toolbox_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-5054" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-5054">{"x":{"title":{"text":"GDPs of China Provinces, 2012-2014 (Million USD)","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"center","orient":"vertical"},"calculable":true,"series":[{"type":"map","mapType":"china","roam":true,"data":[{"value":904046,"name":"广东"},{"value":856368,"name":"江苏"},{"value":792289,"name":"山东"},{"value":549154,"name":"浙江"},{"value":468900,"name":"河南"},{"value":420990,"name":"河北"},{"value":393607,"name":"辽宁"},{"value":378183,"name":"四川"},{"value":352482,"name":"湖北"},{"value":350958,"name":"湖南"},{"value":319710,"name":"上海"},{"value":312107,"name":"福建"},{"value":283238,"name":"北京"},{"value":272666,"name":"安徽"},{"value":251574,"name":"内蒙古"},{"value":228969,"name":"陕西"},{"value":216896,"name":"黑龙江"},{"value":206497,"name":"广西"},{"value":205131,"name":"江西"},{"value":204259,"name":"天津"},{"value":191886,"name":"山西"},{"value":189136,"name":"吉林"},{"value":180746,"name":"重庆"},{"value":163318,"name":"云南"},{"value":118896,"name":"新疆"},{"value":108550,"name":"贵州"},{"value":89508,"name":"甘肃"},{"value":45236,"name":"海南"},{"value":37090,"name":"宁夏"},{"value":29997,"name":"青海"},{"value":11105,"name":"西藏"}],"name":"2012","itemStyle":{"normal":{"label":{"show":false}},"emphasis":{"label":{"show":true}}}},{"type":"map","mapType":"china","roam":true,"data":[{"value":1003746,"name":"广东"},{"value":955269,"name":"江苏"},{"value":882974,"name":"山东"},{"value":606609,"name":"浙江"},{"value":519212,"name":"河南"},{"value":456976,"name":"河北"},{"value":437216,"name":"辽宁"},{"value":424026,"name":"四川"},{"value":398316,"name":"湖北"},{"value":395622,"name":"湖南"},{"value":351347,"name":"福建"},{"value":348804,"name":"上海"},{"value":314871,"name":"北京"},{"value":307416,"name":"安徽"},{"value":271788,"name":"内蒙古"},{"value":259078,"name":"陕西"},{"value":232237,"name":"黑龙江"},{"value":232158,"name":"广西"},{"value":232031,"name":"天津"},{"value":231520,"name":"江西"},{"value":209608,"name":"吉林"},{"value":204364,"name":"重庆"},{"value":203485,"name":"山西"},{"value":189255,"name":"云南"},{"value":134991,"name":"新疆"},{"value":129284,"name":"贵州"},{"value":101208,"name":"甘肃"},{"value":50805,"name":"海南"},{"value":41417,"name":"宁夏"},{"value":33925,"name":"青海"},{"value":13041,"name":"西藏"}],"name":"2013","itemStyle":{"normal":{"label":{"show":false}},"emphasis":{"label":{"show":true}}}},{"type":"map","mapType":"china","roam":true,"data":[{"value":1103605,"name":"广东"},{"value":1059587,"name":"江苏"},{"value":967419,"name":"山东"},{"value":653668,"name":"浙江"},{"value":568786,"name":"河南"},{"value":478953,"name":"河北"},{"value":466018,"name":"辽宁"},{"value":464555,"name":"四川"},{"value":445514,"name":"湖北"},{"value":440328,"name":"湖南"},{"value":391609,"name":"福建"},{"value":383554,"name":"上海"},{"value":347249,"name":"北京"},{"value":339401,"name":"安徽"},{"value":289274,"name":"内蒙古"},{"value":287978,"name":"陕西"},{"value":255950,"name":"天津"},{"value":255724,"name":"江西"},{"value":255144,"name":"广西"},{"value":244829,"name":"黑龙江"},{"value":232230,"name":"重庆"},{"value":224715,"name":"吉林"},{"value":208612,"name":"云南"},{"value":207714,"name":"山西"},{"value":150812,"name":"新疆"},{"value":150599,"name":"贵州"},{"value":111273,"name":"甘肃"},{"value":56989,"name":"海南"},{"value":44802,"name":"宁夏"},{"value":37460,"name":"青海"},{"value":14990,"name":"西藏"}],"name":"2014","itemStyle":{"normal":{"label":{"show":false}},"emphasis":{"label":{"show":true}}}}],"renderAsImage":true,"color":["#3366CC","#DC3912","#FF9900","#109618","#990099","#0099C6","#DD4477","#66AA00","#B82E2E","#316395","#994499","#22AA99","#AAAA11","#6633CC","#E67300","#8B0707","#651067","#329262","#5574A6","#3B3EAC"],"dataRange":{"show":true,"calculable":[],"text":["High","Low"],"itemGap":5,"min":0,"max":3308624,"color":["#FF0000","#FFA500","#FFFF00","#00FF00","#32CD32"],"splitNumber":0},"legend":{"show":true,"data":["2012","2013","2014"],"x":"left","y":"top"},"roamController":{"show":true,"mapTypeControl":{"china":true},"x":"right","width":60,"height":90}},"evals":[]}</script><!--/html_preserve-->

用世界GDP前20粗糙演示世界地图。漫游轴切分为10档(`splitNumber=10`)。


```r
worldgdp <- data.frame(
    country=c('United States of America','China','Japan','Germany',
              'United Kingdom','France','Brazil', 'Italy','India','Russia',
              'Canada','Australia','South Korea','Spain','Mexico','Indonesia',
             'Netherlands','Turkey','Saudi Arabia','Switzerland'),
    GDP=c(17418925,10380380,4616335,3859547,2945146,2846889,2353025,2147952,
          2049501,1857461,1788717,1444189,1416949,1406855,1282725,888648,866354,
          806108,752459,712050))
echartR(worldgdp, x = ~country, y = ~GDP, type=c('map','world','area'),
        title="Nations with top 20 GDPs, 2014 (Million USD) - Wikipedia",
        dataRangePalette='rainbow(5)', dataRange=c("High","Low"), 
        splitNumber=10, toolbox_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-5893" style="width:768px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-5893">{"x":{"title":{"text":"Nations with top 20 GDPs, 2014 (Million USD) - Wikipedia","subtext":"","padding":[25,5,5,5],"x":"center","y":"bottom"},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}}},"toolbox":{"show":true,"feature":{"mark":{"show":true,"title":{"mark":"杈呭姪绾垮紑鍏? Auxiliary conductor switch","markUndo":"鍒犻櫎杈呭姪绾? Undo auxiliary conductor","markClear":"娓呯┖杈呭姪绾? Clear auxiliary conductor"}},"dataView":{"show":true,"readOnly":false,"title":"鏁版嵁瑙嗗浘 Data view"},"magicType":{"show":false},"restore":{"show":true,"title":"杩樺師 Restore"},"saveAsImage":{"show":true,"title":"淇濆瓨涓哄浘鐗? Save as image"}},"x":"right","y":"center","orient":"vertical"},"calculable":true,"series":[{"type":"map","mapType":"world","roam":true,"data":[{"value":17418925,"name":"United States of America"},{"value":10380380,"name":"China"},{"value":4616335,"name":"Japan"},{"value":3859547,"name":"Germany"},{"value":2945146,"name":"United Kingdom"},{"value":2846889,"name":"France"},{"value":2353025,"name":"Brazil"},{"value":2147952,"name":"Italy"},{"value":2049501,"name":"India"},{"value":1857461,"name":"Russia"},{"value":1788717,"name":"Canada"},{"value":1444189,"name":"Australia"},{"value":1416949,"name":"South Korea"},{"value":1406855,"name":"Spain"},{"value":1282725,"name":"Mexico"},{"value":888648,"name":"Indonesia"},{"value":866354,"name":"Netherlands"},{"value":806108,"name":"Turkey"},{"value":752459,"name":"Saudi Arabia"},{"value":712050,"name":"Switzerland"}],"name":"GDP","itemStyle":{"normal":{"label":{"show":false}},"emphasis":{"label":{"show":true}}}}],"renderAsImage":true,"color":["#7AC143","#7D3F98","#F47721","#D20962","#00A78E","#00BCE4","#B8D936","#EE3D94","#FDB933","#F58F9F","#60C3AE","#5F78BB","#5E9732","#CEA979","#EF4135","#7090A5"],"dataRange":{"show":true,"calculable":false,"text":["High","Low"],"itemGap":5,"min":0,"max":19089613,"color":["#FF0000","#CCFF00","#00FF66","#0066FF","#CC00FF"],"splitNumber":10},"roamController":{"show":true,"mapTypeControl":{"world":true},"x":"right","width":60,"height":90}},"evals":[]}</script><!--/html_preserve-->

### Point 点标注


## Chord 和弦图


## Force 力导向布局图

# Recognized Issues 已知的问题

1. `echartR`比较接近于`lattice`，而不是`ggplot2`图层叠加的思路。每次使用都要一次性编辑很多参数；
1. 函数本身写得比较笨重，技术还不行；
1. 未实现的功能：
    1. Force，Chord，Wordcloud，candlestick(k)和点标注地图还没有开发；
    1. 仍然不支持时间格式的坐标轴（series中数据格式有问题）；
    1. 仍然不支持动态时间轴；
    1. tooltip不够智能；
    1. 进阶功能（包括多图联动、双坐标轴等）仍未开发；
1. **注意**：如要改进，千万不要在函数代码中`set.seed()`，这会全局锁定种子数，导致knitr时每做一图都按该种子随机化`htmlwidget id`。最终的文档中，某些图会无法按指定代码出图，而是重复其他的图（串id）。