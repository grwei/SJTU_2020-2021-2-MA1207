# 1976-2018年上海气候年代际变率的统计学分析

论文PDF版：[1976-2018年上海气候年代际变率的统计学分析](doc/大作业_危国锐_516021910080.pdf)

## 文件说明

- `./code`文件夹
  - [`data_prep.m`](code/data_prep.m)  数据预处理。提取`.nc`文件中的数据，保存为[`meteo_data.mat`](code/meteo_data.mat)。
  - [`main.m`](code/main.m)  主程序。对数据作统计分析，绘图。
  - [`meteo_data.mat`](code/meteo_data.mat)  使用的数据。可在`MATLAB`中使用`load`函数将数据读入工作区。
- `./data`文件夹
  - [`meteo_data.mat`](code/meteo_data.mat)  使用的数据。可在`MATLAB`中使用`load`函数将数据读入工作区。

## 数据来源

1. [中国1km分辨率逐月降水量数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/faae7605-a0f2-4d18-b28f-5cee413766a2/)
2. [中国1km分辨率逐月平均气温数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/71ab4677-b66c-4fd1-a004-b2a541c4d5bf/)
3. [中国区域地面气象要素驱动数据集（1979-2018）](http://data.tpdc.ac.cn/zh-hans/data/8028b944-daaa-4511-8769-965612652c49/)
4. [中国地面累年值月值数据集（1981-2010年）](http://data.cma.cn/data/detail/dataCode/A.0029.0004.html)

## 联系方式

- E-mail: 313017602@qq.com
