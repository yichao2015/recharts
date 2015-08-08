# Recharts UDF
`r Sys.info()[['user']]`  
`r format(Sys.time(),'%x %X')`  

# Intro 前言

本工具来源于百度开发的国内顶尖水平的开源d3-js可视项目[Echarts](http://echarts.baidu.com/)([Github Repo](https://github.com/ecomfe/echarts))。Yang Zhou和Taiyun Wei基于该工具开发了[recharts](https://github.com/taiyun/recharts)包，经Yihui Xie[修改](https://github.com/yihui/recharts)后，可通过`htmlwidgets`传递js参数，大大简化了开发难度。但此包开发仍未完成。为了赶紧上手用，基于该包做了一个函数`echartR`，用于制作基础Echart交互图。

# Usage 用法
## Installation 安装
- 安装`devtools`
- 安装recharts (`install_github('yihui/recharts')`)
- 下载`echartR`文件到work directory(位置: [https://github.com/madlogos/recharts/blob/master/R/echartR.R](https://github.com/madlogos/recharts/blob/master/R/echartR.R))
- 调用`echartR`(`source("~/Github/recharts/R/echartR.R")`)

## Grammar 语法

```
echartR(data,x,y,series=NULL,weight=NULL,type="scatter",stack=FALSE,
                  title=NULL,subtitle=NULL,
                  xlab=NULL,ylab=NULL,xyflip=FALSE,AxisAtZero=TRUE,scale=TRUE,
                  palette='aetnagreen',tooltip=TRUE,legend=TRUE,
                  legend_pos=c('center','top')
                  toolbox=TRUE,calculable=TRUE))
```

- **data**: 数据集
- **x**: x变量
- **y**: y变量
- series: Series(系列)变量
- weight: 权重变量，在气泡图等时用
- type: 默认scatter，可选'scatter','bar','line','map','k','pie','chord','force','tree','treemap','wordcloud','heatmap','histogram','bubble', 'ring'
- stack: 默认FALSE，是否堆积。制作堆积条图、柱图时用
- title: 标题 
- subtitle: 副标题
- xlab: x轴标题
- ylab: y轴标题
- xyflip: 默认FALSE，是否翻转坐标轴
- AxisAtZero: 默认TRUE，坐标轴是否交叉于零点
- scale: 默认TRUE，是否基于最大、最小值调整坐标尺度
- palette: 默认aetnagreen，使用调色板
    - Aetna palettes: 可用 'aetnagreen', 'aetnablue', 'aetnaviolet', 'aetnaorange', 'aetnateal', 'aetnacranberry'
    - RColorBrewer palettes(区分大小写): 可用'BrBG', 'PiYG', 'PRGn', 'PuOr', 'RdBu', 'RdGy', 'RdYlBu', 'RdYlGn', 'Spectral', 'Accent', 'Dark2', 'Paired', 'Pastel1', 'Pastel2', 'Set1', 'Set2', 'Set3', 'Blues', 'BuGn', 'BuPu', 'GnBu', 'Greens', 'Greys', 'Oranges', 'OrRd', 'PuBu', 'PuBuGn', 'PuRd', 'Purples', 'RdPu', 'Reds', 'YlGn', 'YlGnBu', 'YlOrBr', 'YlOrRd'
    - ggthemes palettes: 'calc', 'economist', 'economist_white', 'excel', 'few', 'fivethirtyeight', 'gdocs', 'pander', 'tableau', 'stata', 'tableau20', 'tableau10medium', 'tableaugray', 'tableauprgy', 'tableaublrd', 'tableaugnor', 'tableaucyclic', 'tableau10light', 'tableaublrd12','tableauprgy12', 'tableaugnor12','hc','darkunica', 'solarized','solarized_red', 'solarized_yellow', 'solarized_orange','solarized_magenta','solarized_violet', 'solarized_blue', 'solarized_cyan', 'solarized_green', 'wsj','colorblind', 'trafficlight'
- tooltip: 默认TRUE，鼠标指针特效
- legend: 默认TRUE，是否显示图例
- legend_pos: 图例位置，c("center","top")表示中间顶端位置
- toolbox: 默认TRUE，是否显示工具箱
- calculable: 默认TRUE，是否支持拖曳重算(Echarts专利)

# Examples


## Scatter 散点图
### Singular-series Scatter 单系列散点图

```r
echartR(data = iris, x = ~Sepal.Width, y = ~Sepal.Length, 
        type = 'scatter', palette='solarized_magenta',
        title = 'Scatter - Sepal Width vs Length (iris)', 
        xlab = 'Sepal Width', ylab = 'Sepal Length')
```

<!--html_preserve--><div id="htmlwidget-6594" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-6594">{"x":{"title":{"text":"Scatter - Sepal Width vs Length (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":false},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"type":"scatter","data":[[3.5,5.1],[3,4.9],[3.2,4.7],[3.1,4.6],[3.6,5],[3.9,5.4],[3.4,4.6],[3.4,5],[2.9,4.4],[3.1,4.9],[3.7,5.4],[3.4,4.8],[3,4.8],[3,4.3],[4,5.8],[4.4,5.7],[3.9,5.4],[3.5,5.1],[3.8,5.7],[3.8,5.1],[3.4,5.4],[3.7,5.1],[3.6,4.6],[3.3,5.1],[3.4,4.8],[3,5],[3.4,5],[3.5,5.2],[3.4,5.2],[3.2,4.7],[3.1,4.8],[3.4,5.4],[4.1,5.2],[4.2,5.5],[3.1,4.9],[3.2,5],[3.5,5.5],[3.6,4.9],[3,4.4],[3.4,5.1],[3.5,5],[2.3,4.5],[3.2,4.4],[3.5,5],[3.8,5.1],[3,4.8],[3.8,5.1],[3.2,4.6],[3.7,5.3],[3.3,5],[3.2,7],[3.2,6.4],[3.1,6.9],[2.3,5.5],[2.8,6.5],[2.8,5.7],[3.3,6.3],[2.4,4.9],[2.9,6.6],[2.7,5.2],[2,5],[3,5.9],[2.2,6],[2.9,6.1],[2.9,5.6],[3.1,6.7],[3,5.6],[2.7,5.8],[2.2,6.2],[2.5,5.6],[3.2,5.9],[2.8,6.1],[2.5,6.3],[2.8,6.1],[2.9,6.4],[3,6.6],[2.8,6.8],[3,6.7],[2.9,6],[2.6,5.7],[2.4,5.5],[2.4,5.5],[2.7,5.8],[2.7,6],[3,5.4],[3.4,6],[3.1,6.7],[2.3,6.3],[3,5.6],[2.5,5.5],[2.6,5.5],[3,6.1],[2.6,5.8],[2.3,5],[2.7,5.6],[3,5.7],[2.9,5.7],[2.9,6.2],[2.5,5.1],[2.8,5.7],[3.3,6.3],[2.7,5.8],[3,7.1],[2.9,6.3],[3,6.5],[3,7.6],[2.5,4.9],[2.9,7.3],[2.5,6.7],[3.6,7.2],[3.2,6.5],[2.7,6.4],[3,6.8],[2.5,5.7],[2.8,5.8],[3.2,6.4],[3,6.5],[3.8,7.7],[2.6,7.7],[2.2,6],[3.2,6.9],[2.8,5.6],[2.8,7.7],[2.7,6.3],[3.3,6.7],[3.2,7.2],[2.8,6.2],[3,6.1],[2.8,6.4],[3,7.2],[2.8,7.4],[3.8,7.9],[2.8,6.4],[2.8,6.3],[2.6,6.1],[3,7.7],[3.4,6.3],[3.1,6.4],[3,6],[3.1,6.9],[3.1,6.7],[3.1,6.9],[2.7,5.8],[3.2,6.8],[3.3,6.7],[3,6.7],[2.5,6.3],[3,6.5],[3.4,6.2],[3,5.9]]}],"color":["#d33682","#b58900","#cb4b16","#dc322f","#6c71c4","#268bd2","#2aa198","#859900"],"xAxis":{"name":"Sepal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Sepal Length","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":[]}</script><!--/html_preserve-->

### Multi-series Scatter 多系列散点图

```r
echartR(data = iris, x = ~Sepal.Width, y = ~Sepal.Length, series = ~Species,
        type = 'scatter', palette='aetnaviolet',
        title = 'Scatter - Sepal Width vs Length by Species (iris)',
        xlab = 'Sepal Width', ylab = 'Sepal Length')
```

<!--html_preserve--><div id="htmlwidget-3140" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3140">{"x":{"title":{"text":"Scatter - Sepal Width vs Length by Species (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"showDelay":0,"formatter":"function (params) {\n                    if (params.value.length > 1) {\n                        return params.seriesName + \" :<br/>\"\n                        + params.value[0] + \" ,    \" +\n                        + params.value[1];\n                    } else {\n                        return params.seriesName + \" :<br/>\"\n                        + params.name + \" : \"\n                        + params.value;\n                    }\n                }"},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":false},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"scatter","symbol":"circle","data":[[3.5,5.1],[3,4.9],[3.2,4.7],[3.1,4.6],[3.6,5],[3.9,5.4],[3.4,4.6],[3.4,5],[2.9,4.4],[3.1,4.9],[3.7,5.4],[3.4,4.8],[3,4.8],[3,4.3],[4,5.8],[4.4,5.7],[3.9,5.4],[3.5,5.1],[3.8,5.7],[3.8,5.1],[3.4,5.4],[3.7,5.1],[3.6,4.6],[3.3,5.1],[3.4,4.8],[3,5],[3.4,5],[3.5,5.2],[3.4,5.2],[3.2,4.7],[3.1,4.8],[3.4,5.4],[4.1,5.2],[4.2,5.5],[3.1,4.9],[3.2,5],[3.5,5.5],[3.6,4.9],[3,4.4],[3.4,5.1],[3.5,5],[2.3,4.5],[3.2,4.4],[3.5,5],[3.8,5.1],[3,4.8],[3.8,5.1],[3.2,4.6],[3.7,5.3],[3.3,5]]},{"name":"versicolor","type":"scatter","symbol":"circle","data":[[3.2,7],[3.2,6.4],[3.1,6.9],[2.3,5.5],[2.8,6.5],[2.8,5.7],[3.3,6.3],[2.4,4.9],[2.9,6.6],[2.7,5.2],[2,5],[3,5.9],[2.2,6],[2.9,6.1],[2.9,5.6],[3.1,6.7],[3,5.6],[2.7,5.8],[2.2,6.2],[2.5,5.6],[3.2,5.9],[2.8,6.1],[2.5,6.3],[2.8,6.1],[2.9,6.4],[3,6.6],[2.8,6.8],[3,6.7],[2.9,6],[2.6,5.7],[2.4,5.5],[2.4,5.5],[2.7,5.8],[2.7,6],[3,5.4],[3.4,6],[3.1,6.7],[2.3,6.3],[3,5.6],[2.5,5.5],[2.6,5.5],[3,6.1],[2.6,5.8],[2.3,5],[2.7,5.6],[3,5.7],[2.9,5.7],[2.9,6.2],[2.5,5.1],[2.8,5.7]]},{"name":"virginica","type":"scatter","symbol":"circle","data":[[3.3,6.3],[2.7,5.8],[3,7.1],[2.9,6.3],[3,6.5],[3,7.6],[2.5,4.9],[2.9,7.3],[2.5,6.7],[3.6,7.2],[3.2,6.5],[2.7,6.4],[3,6.8],[2.5,5.7],[2.8,5.8],[3.2,6.4],[3,6.5],[3.8,7.7],[2.6,7.7],[2.2,6],[3.2,6.9],[2.8,5.6],[2.8,7.7],[2.7,6.3],[3.3,6.7],[3.2,7.2],[2.8,6.2],[3,6.1],[2.8,6.4],[3,7.2],[2.8,7.4],[3.8,7.9],[2.8,6.4],[2.8,6.3],[2.6,6.1],[3,7.7],[3.4,6.3],[3.1,6.4],[3,6],[3.1,6.9],[3.1,6.7],[3.1,6.9],[2.7,5.8],[3.2,6.8],[3.3,6.7],[3,6.7],[2.5,6.3],[3,6.5],[3.4,6.2],[3,5.9]]}],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"center","y":"top"},"xAxis":{"name":"Sepal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Sepal Length","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":["tooltip.formatter"]}</script><!--/html_preserve-->

## Bubble 气泡图

气泡图同样来源于散点图。type改为`bubble`即可，如不指定`weight`变量，函数默认指定y为气泡权重。

### Singular-series Bubble 单系列气泡图

```r
echartR(data = iris, x = ~Sepal.Width, y = ~Sepal.Length, 
        weight = ~Petal.Length,
        type = 'bubble', palette='solarized_cyan',
        title = 'Bubble - Sepal Width vs Length weighed by Petal Length (iris)', 
        xlab = 'Sepal Width', ylab = 'Sepal Length')
```

<!--html_preserve--><div id="htmlwidget-2561" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2561">{"x":{"title":{"text":"Bubble - Sepal Width vs Length weighed by Petal Length (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":false},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"type":"scatter","data":[[3.5,5.1,1.4],[3,4.9,1.4],[3.2,4.7,1.3],[3.1,4.6,1.5],[3.6,5,1.4],[3.9,5.4,1.7],[3.4,4.6,1.4],[3.4,5,1.5],[2.9,4.4,1.4],[3.1,4.9,1.5],[3.7,5.4,1.5],[3.4,4.8,1.6],[3,4.8,1.4],[3,4.3,1.1],[4,5.8,1.2],[4.4,5.7,1.5],[3.9,5.4,1.3],[3.5,5.1,1.4],[3.8,5.7,1.7],[3.8,5.1,1.5],[3.4,5.4,1.7],[3.7,5.1,1.5],[3.6,4.6,1],[3.3,5.1,1.7],[3.4,4.8,1.9],[3,5,1.6],[3.4,5,1.6],[3.5,5.2,1.5],[3.4,5.2,1.4],[3.2,4.7,1.6],[3.1,4.8,1.6],[3.4,5.4,1.5],[4.1,5.2,1.5],[4.2,5.5,1.4],[3.1,4.9,1.5],[3.2,5,1.2],[3.5,5.5,1.3],[3.6,4.9,1.4],[3,4.4,1.3],[3.4,5.1,1.5],[3.5,5,1.3],[2.3,4.5,1.3],[3.2,4.4,1.3],[3.5,5,1.6],[3.8,5.1,1.9],[3,4.8,1.4],[3.8,5.1,1.6],[3.2,4.6,1.4],[3.7,5.3,1.5],[3.3,5,1.4],[3.2,7,4.7],[3.2,6.4,4.5],[3.1,6.9,4.9],[2.3,5.5,4],[2.8,6.5,4.6],[2.8,5.7,4.5],[3.3,6.3,4.7],[2.4,4.9,3.3],[2.9,6.6,4.6],[2.7,5.2,3.9],[2,5,3.5],[3,5.9,4.2],[2.2,6,4],[2.9,6.1,4.7],[2.9,5.6,3.6],[3.1,6.7,4.4],[3,5.6,4.5],[2.7,5.8,4.1],[2.2,6.2,4.5],[2.5,5.6,3.9],[3.2,5.9,4.8],[2.8,6.1,4],[2.5,6.3,4.9],[2.8,6.1,4.7],[2.9,6.4,4.3],[3,6.6,4.4],[2.8,6.8,4.8],[3,6.7,5],[2.9,6,4.5],[2.6,5.7,3.5],[2.4,5.5,3.8],[2.4,5.5,3.7],[2.7,5.8,3.9],[2.7,6,5.1],[3,5.4,4.5],[3.4,6,4.5],[3.1,6.7,4.7],[2.3,6.3,4.4],[3,5.6,4.1],[2.5,5.5,4],[2.6,5.5,4.4],[3,6.1,4.6],[2.6,5.8,4],[2.3,5,3.3],[2.7,5.6,4.2],[3,5.7,4.2],[2.9,5.7,4.2],[2.9,6.2,4.3],[2.5,5.1,3],[2.8,5.7,4.1],[3.3,6.3,6],[2.7,5.8,5.1],[3,7.1,5.9],[2.9,6.3,5.6],[3,6.5,5.8],[3,7.6,6.6],[2.5,4.9,4.5],[2.9,7.3,6.3],[2.5,6.7,5.8],[3.6,7.2,6.1],[3.2,6.5,5.1],[2.7,6.4,5.3],[3,6.8,5.5],[2.5,5.7,5],[2.8,5.8,5.1],[3.2,6.4,5.3],[3,6.5,5.5],[3.8,7.7,6.7],[2.6,7.7,6.9],[2.2,6,5],[3.2,6.9,5.7],[2.8,5.6,4.9],[2.8,7.7,6.7],[2.7,6.3,4.9],[3.3,6.7,5.7],[3.2,7.2,6],[2.8,6.2,4.8],[3,6.1,4.9],[2.8,6.4,5.6],[3,7.2,5.8],[2.8,7.4,6.1],[3.8,7.9,6.4],[2.8,6.4,5.6],[2.8,6.3,5.1],[2.6,6.1,5.6],[3,7.7,6.1],[3.4,6.3,5.6],[3.1,6.4,5.5],[3,6,4.8],[3.1,6.9,5.4],[3.1,6.7,5.6],[3.1,6.9,5.1],[2.7,5.8,5.1],[3.2,6.8,5.9],[3.3,6.7,5.7],[3,6.7,5.2],[2.5,6.3,5],[3,6.5,5.2],[3.4,6.2,5.4],[3,5.9,5.1]],"symbolSize":"function (value){\n                       return Math.round(value[2]*\n2\n);\n                    }"}],"color":["#2aa198","#b58900","#cb4b16","#dc322f","#d33682","#6c71c4","#268bd2","#859900"],"xAxis":{"name":"Sepal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Sepal Length","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":["series.0.symbolSize"]}</script><!--/html_preserve-->

### Multi-series Bubble 多系列气泡图

```r
echartR(data = iris, x = ~Sepal.Width, y = ~Sepal.Length, 
        weight = ~Petal.Length, series = ~Species,
        type = 'bubble', palette='tableauGnOr',
        title = paste("Bubble - Sepal Width vs Length by Species,",
                      "weighed by Petal Length(iris)"), 
        xlab = 'Sepal Width', ylab = 'Sepal Length')
```

<!--html_preserve--><div id="htmlwidget-920" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-920">{"x":{"title":{"text":"Bubble - Sepal Width vs Length by Species, weighed by Petal Length(iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"type":"cross","lineStyle":{"type":"dashed","width":1}},"showDelay":0,"formatter":"function (params) {\n                    if (params.value.length > 1) {\n                        return params.seriesName + \" :<br/>\"\n                        + params.value[0] + \" ,    \" +\n                        + params.value[1];\n                    } else {\n                        return params.seriesName + \" :<br/>\"\n                        + params.name + \" : \"\n                        + params.value;\n                    }\n                }"},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":false},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"scatter","symbol":"circle","data":[[3.5,5.1,1.4],[3,4.9,1.4],[3.2,4.7,1.3],[3.1,4.6,1.5],[3.6,5,1.4],[3.9,5.4,1.7],[3.4,4.6,1.4],[3.4,5,1.5],[2.9,4.4,1.4],[3.1,4.9,1.5],[3.7,5.4,1.5],[3.4,4.8,1.6],[3,4.8,1.4],[3,4.3,1.1],[4,5.8,1.2],[4.4,5.7,1.5],[3.9,5.4,1.3],[3.5,5.1,1.4],[3.8,5.7,1.7],[3.8,5.1,1.5],[3.4,5.4,1.7],[3.7,5.1,1.5],[3.6,4.6,1],[3.3,5.1,1.7],[3.4,4.8,1.9],[3,5,1.6],[3.4,5,1.6],[3.5,5.2,1.5],[3.4,5.2,1.4],[3.2,4.7,1.6],[3.1,4.8,1.6],[3.4,5.4,1.5],[4.1,5.2,1.5],[4.2,5.5,1.4],[3.1,4.9,1.5],[3.2,5,1.2],[3.5,5.5,1.3],[3.6,4.9,1.4],[3,4.4,1.3],[3.4,5.1,1.5],[3.5,5,1.3],[2.3,4.5,1.3],[3.2,4.4,1.3],[3.5,5,1.6],[3.8,5.1,1.9],[3,4.8,1.4],[3.8,5.1,1.6],[3.2,4.6,1.4],[3.7,5.3,1.5],[3.3,5,1.4]],"symbolSize":"function (value){\n                            return Math.round(value[2]*\n2\n);\n                        }"},{"name":"versicolor","type":"scatter","symbol":"circle","data":[[3.2,7,4.7],[3.2,6.4,4.5],[3.1,6.9,4.9],[2.3,5.5,4],[2.8,6.5,4.6],[2.8,5.7,4.5],[3.3,6.3,4.7],[2.4,4.9,3.3],[2.9,6.6,4.6],[2.7,5.2,3.9],[2,5,3.5],[3,5.9,4.2],[2.2,6,4],[2.9,6.1,4.7],[2.9,5.6,3.6],[3.1,6.7,4.4],[3,5.6,4.5],[2.7,5.8,4.1],[2.2,6.2,4.5],[2.5,5.6,3.9],[3.2,5.9,4.8],[2.8,6.1,4],[2.5,6.3,4.9],[2.8,6.1,4.7],[2.9,6.4,4.3],[3,6.6,4.4],[2.8,6.8,4.8],[3,6.7,5],[2.9,6,4.5],[2.6,5.7,3.5],[2.4,5.5,3.8],[2.4,5.5,3.7],[2.7,5.8,3.9],[2.7,6,5.1],[3,5.4,4.5],[3.4,6,4.5],[3.1,6.7,4.7],[2.3,6.3,4.4],[3,5.6,4.1],[2.5,5.5,4],[2.6,5.5,4.4],[3,6.1,4.6],[2.6,5.8,4],[2.3,5,3.3],[2.7,5.6,4.2],[3,5.7,4.2],[2.9,5.7,4.2],[2.9,6.2,4.3],[2.5,5.1,3],[2.8,5.7,4.1]],"symbolSize":"function (value){\n                            return Math.round(value[2]*\n2\n);\n                        }"},{"name":"virginica","type":"scatter","symbol":"circle","data":[[3.3,6.3,6],[2.7,5.8,5.1],[3,7.1,5.9],[2.9,6.3,5.6],[3,6.5,5.8],[3,7.6,6.6],[2.5,4.9,4.5],[2.9,7.3,6.3],[2.5,6.7,5.8],[3.6,7.2,6.1],[3.2,6.5,5.1],[2.7,6.4,5.3],[3,6.8,5.5],[2.5,5.7,5],[2.8,5.8,5.1],[3.2,6.4,5.3],[3,6.5,5.5],[3.8,7.7,6.7],[2.6,7.7,6.9],[2.2,6,5],[3.2,6.9,5.7],[2.8,5.6,4.9],[2.8,7.7,6.7],[2.7,6.3,4.9],[3.3,6.7,5.7],[3.2,7.2,6],[2.8,6.2,4.8],[3,6.1,4.9],[2.8,6.4,5.6],[3,7.2,5.8],[2.8,7.4,6.1],[3.8,7.9,6.4],[2.8,6.4,5.6],[2.8,6.3,5.1],[2.6,6.1,5.6],[3,7.7,6.1],[3.4,6.3,5.6],[3.1,6.4,5.5],[3,6,4.8],[3.1,6.9,5.4],[3.1,6.7,5.6],[3.1,6.9,5.1],[2.7,5.8,5.1],[3.2,6.8,5.9],[3.3,6.7,5.7],[3,6.7,5.2],[2.5,6.3,5],[3,6.5,5.2],[3.4,6.2,5.4],[3,5.9,5.1]],"symbolSize":"function (value){\n                            return Math.round(value[2]*\n2\n);\n                        }"}],"color":["#32A251","#FF7F0F","#3CB7CC","#B85A0D","#39737C","#82853B"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"center","y":"top"},"xAxis":{"name":"Sepal Width","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Sepal Length","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":["tooltip.formatter","series.0.symbolSize","series.1.symbolSize","series.2.symbolSize"]}</script><!--/html_preserve-->

## vBar 柱图

先生成一个汇总数据集`dt`。


```r
library(reshape2)
df <- melt(iris,id="Species")
names(df) <- c("Species","Param","Value")
dt <- dcast(df,Species+Param~.,value.var="Value",mean)
names(dt) <- c("Species","Param","Mean")
knitr::kable(dt,format='html',caption="Table: Mean of parameters")
```

<table>
<caption>Table: Mean of parameters</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Species </th>
   <th style="text-align:left;"> Param </th>
   <th style="text-align:right;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> setosa </td>
   <td style="text-align:left;"> Sepal.Length </td>
   <td style="text-align:right;"> 5.006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> setosa </td>
   <td style="text-align:left;"> Sepal.Width </td>
   <td style="text-align:right;"> 3.428 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> setosa </td>
   <td style="text-align:left;"> Petal.Length </td>
   <td style="text-align:right;"> 1.462 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> setosa </td>
   <td style="text-align:left;"> Petal.Width </td>
   <td style="text-align:right;"> 0.246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> versicolor </td>
   <td style="text-align:left;"> Sepal.Length </td>
   <td style="text-align:right;"> 5.936 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> versicolor </td>
   <td style="text-align:left;"> Sepal.Width </td>
   <td style="text-align:right;"> 2.770 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> versicolor </td>
   <td style="text-align:left;"> Petal.Length </td>
   <td style="text-align:right;"> 4.260 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> versicolor </td>
   <td style="text-align:left;"> Petal.Width </td>
   <td style="text-align:right;"> 1.326 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> virginica </td>
   <td style="text-align:left;"> Sepal.Length </td>
   <td style="text-align:right;"> 6.588 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> virginica </td>
   <td style="text-align:left;"> Sepal.Width </td>
   <td style="text-align:right;"> 2.974 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> virginica </td>
   <td style="text-align:left;"> Petal.Length </td>
   <td style="text-align:right;"> 5.552 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> virginica </td>
   <td style="text-align:left;"> Petal.Width </td>
   <td style="text-align:right;"> 2.026 </td>
  </tr>
</tbody>
</table>

### Unstacked vBar 平铺柱图

```r
echartR(data = dt, x = ~Param, y = ~Mean, 
        series = ~Species,
        type = 'bar', palette='fivethirtyeight',
        title = paste("VBar - Parameter Mean by Species,", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-7683" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-7683">{"x":{"title":{"text":"VBar - Parameter Mean by Species, (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["line","bar","tiled","stack"]},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246]},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326]},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026]}],"color":["#008FD5","#FF2700","#77AB43"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Parameter","type":"category","scale":true,"axisLine":{"show":true,"onZero":true},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]},"yAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":[]}</script><!--/html_preserve-->

### Stacked vBar 堆积柱图

```r
echartR(data = dt, x = ~Param, y = ~Mean, 
        series = ~Species, stack=T,
        type = 'bar', palette='pander',
        title = paste("VBar - Parameter Mean by Species,", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-9778" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-9778">{"x":{"title":{"text":"VBar - Parameter Mean by Species, (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["line","bar","tiled","stack"]},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246],"stack":"Stack"},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326],"stack":"Stack"},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026],"stack":"Stack"}],"color":["#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999","#E69F00"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Parameter","type":"category","scale":true,"axisLine":{"show":true,"onZero":true},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]},"yAxis":{"name":"Mean","type":"value","scale":true,"axisLine":{"show":true,"onZero":true},"data":[]}},"evals":[]}</script><!--/html_preserve-->

堆积与否，也可以简单地通过工具栏的`平铺`、`堆积`按钮切换。非常强大(但也得在函数配置项里正确地码出代码)。

## hBar 条图

条图和柱图的区别只在于`xyflip`开关选项。

### Unstacked hBar 平铺条图

```r
echartR(data = dt, x = ~Param, y = ~Mean, 
        series = ~Species, xyflip=T,
        type = 'bar', palette='stata',
        title = paste("hBar - Parameter Mean by Species,", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-1585" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-1585">{"x":{"title":{"text":"hBar - Parameter Mean by Species, (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["line","bar","tiled","stack"]},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246]},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326]},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026]}],"color":["#1a476f","#90353b","#55752f","#e37e00","#6e8e84","#c10534","#938dd2","#cac27e","#a0522d","#7b92a8","#2d6d66","#9c8847","#bfa19c","#ffd200","#d9e6eb"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Mean","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Parameter","type":"category","scale":true,"axisLine":{"show":true,"onZero":true},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]}},"evals":[]}</script><!--/html_preserve-->

### Stacked hBar 堆积条图

```r
echartR(data = dt, x = ~Param, y = ~Mean, 
        series = ~Species, stack=T, xyflip=T,
        type = 'bar', palette='calc',
        title = paste("hBar - Parameter Mean by Species,", "(iris)"), 
        xlab = 'Parameter', ylab = 'Mean', legend_pos=c('right','center'))
```

<!--html_preserve--><div id="htmlwidget-2414" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-2414">{"x":{"title":{"text":"hBar - Parameter Mean by Species, (iris)","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"axis","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["line","bar","tiled","stack"]},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"setosa","type":"bar","data":[5.006,3.428,1.462,0.246],"stack":"Stack"},{"name":"versicolor","type":"bar","data":[5.936,2.77,4.26,1.326],"stack":"Stack"},{"name":"virginica","type":"bar","data":[6.588,2.974,5.552,2.026],"stack":"Stack"}],"color":["#004586","#FF420E","#FFD320","#579D1C","#7E0021","#83CAFF","#314004","#AECF00","#4B1F6F","#FF950E","#C5000B","#0084D1"],"legend":{"show":true,"data":["setosa","versicolor","virginica"],"x":"right","y":"center","orient":"vertical"},"xAxis":{"name":"Mean","type":"value","boundaryGap":[0,0],"scale":true,"axisLine":{"show":true,"onZero":true},"data":[]},"yAxis":{"name":"Parameter","type":"category","scale":true,"axisLine":{"show":true,"onZero":true},"data":["Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"]}},"evals":[]}</script><!--/html_preserve-->

## Pie 饼图

```r
dt <- mtcars
dt$car <- row.names(dt)
dt$transmission <- as.factor(dt$am)
levels(dt$transmission) <- c("Automatic","Manual")
dt$cylinder <- as.factor(dt$cyl)
```


```r
echartR(dt, x = ~transmission,  y = ~car, type='pie',
        palette='darikunica', title='Automatic/manual trasmitted cars')
```

<!--html_preserve--><div id="htmlwidget-5217" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-5217">{"x":{"title":{"text":"Automatic/manual trasmitted cars","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0,"formatter":"{a} <br/>{b} : {c} ({d}%)"},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["pie","funnel"],"option":{"funnel":{"x":"25%","width":"50%","funnelAlign":"center"}}},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"transmission","type":"pie","data":[{"value":19,"name":"Automatic"},{"value":13,"name":"Manual"}],"radius":"60%","center":["50%","50%"]}],"legend":{"show":true,"data":["Automatic","Manual"],"x":"center","y":"top"}},"evals":[]}</script><!--/html_preserve-->

## Ring 环图

环形图是饼图的变形，只需将`type`改为ring。


```r
echartR(dt, x = ~cylinder,  y = ~car, type='ring',
        palette='solarized_violet', title='Cylinders of cars')
```

<!--html_preserve--><div id="htmlwidget-3834" style="width:672px;height:480px;" class="echarts"></div>
<script type="application/json" data-for="htmlwidget-3834">{"x":{"title":{"text":"Cylinders of cars","subtext":"","x":"center","y":"bottom","padding":[50,5,5,5]},"tooltip":{"trigger":"item","axisPointer":{"show":true,"lineStyle":{"type":"dashed","width":1}},"showDelay":0,"formatter":"{a} <br/>{b} : {c} ({d}%)"},"toolbox":{"show":true,"feature":{"mark":{"show":true},"dataView":{"show":true,"readOnly":true},"magicType":{"show":true,"type":["pie","funnel"],"option":{"funnel":{"x":"25%","width":"50%","funnelAlign":"center"}}},"restore":{"show":true},"saveAsImage":{"show":true}}},"calculable":true,"series":[{"name":"cylinder","type":"pie","data":[{"value":11,"name":"4"},{"value":7,"name":"6"},{"value":14,"name":"8"}],"radius":["50%","70%"],"itemStyle":{"emphasis":{"label":{"show":true,"position":"center","textStyle":{"fontSize":"30","fontWeight":"bold"}}}}}],"color":["#6c71c4","#b58900","#cb4b16","#dc322f","#d33682","#268bd2","#2aa198","#859900"],"legend":{"show":true,"data":["4","6","8"],"x":"center","y":"top"}},"evals":[]}</script><!--/html_preserve-->

## Line 线图



## Map 地图

