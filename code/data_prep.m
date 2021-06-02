%% data_prep.m
% 标题：本-(2020-2021-2)-MA1207-2-概率统计 课程大作业
% 功能：从数据集中提取本地气象要素数据子集，保存到 `meteo_data.mat` 文件中。
% 数据说明：
%   prec_mon    提取自数据集#1. 1976-2017 逐月降水量(monthly precipitation), 单位：0.1 mm.
%   temp_mon    提取自数据集#2. 1976-2017 逐月平均气温(monthly mean temperature), 单位：0.1 deg Celsius
%   prec_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均降水率(monthly mean precipitation rate), 单位：mm/hr
%   temp_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均近地面气温(Monthly mean near surface air temperature), 单位：K
% 数据源：
%   1. [中国1km分辨率逐月降水量数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/faae7605-a0f2-4d18-b28f-5cee413766a2/)
%   2. [中国1km分辨率逐月平均气温数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/71ab4677-b66c-4fd1-a004-b2a541c4d5bf/)
%   3. (基准-ref)[中国区域地面气象要素驱动数据集（1979-2018）](http://data.tpdc.ac.cn/zh-hans/data/8028b944-daaa-4511-8769-965612652c49/)
% 作者：危国锐(313017602@qq.com)
% 机构：上海交通大学电子信息与电气工程学院
% 创建日期：2021-05-28
% 最后修改：2021-05-29

%% 初始化

clc; clear; close all

% 常量定义
lon_local = 121.4328; % 本地（东）经度. 单位：deg
lat_local = 31.025; % 本地（北）纬度. 单位：deg

% 预分配内存
prec_mon = nan(504,1); % 提取自数据集#1. 1976-2017 逐月降水量(monthly precipitation), 单位：0.1 mm.
temp_mon = prec_mon; % 提取自数据集#2. 1976-2017 逐月平均气温(monthly mean temperature), 单位：0.1 deg Celsius
prec_mon_ref = nan(480,1); % 提取自基准数据集#3. 1979-2018 逐月平均降水率(monthly mean precipitation rate), 单位：mm/hr
temp_mon_ref = prec_mon_ref; % 提取自基准数据集#3. 1979-2018 逐月平均近地面气温(Monthly mean near surface air temperature), 单位：K

%% 提取 NetCDF 文件中的数据

%%  -1. 读取"中国1km分辨率逐月降水量数据集（1901-2017）"的数据
size_ = 0; % 已读取的数据量
for year_beg = 1976:3:2015
    % -读取数据
    nc_file_name = sprintf('D:\\数据\\中国1km分辨率逐月降水量数据集（1901-2017）\\pre_%d_%d.nc',year_beg,year_beg+2);
%     ncdisp(nc_file_name)
    lon_data = ncread(nc_file_name,'lon'); % 经度(longitude). 本地：121.4328 deg
    lat_data = ncread(nc_file_name,'lat'); % 纬度(latitude). 本地：31.025 deg
    time_data = ncread(nc_file_name,'time'); % 时间(time).

    % -选取最接近本地位置（北纬 31.025 deg，东经 121.4328 deg）的点（目标点）
    [~,lon_idx] = min(abs(lon_data - lon_local));
    lon_actual = lon_data(lon_idx);
    [~,lat_idx] = min(abs(lat_data - lat_local));
    lat_actual = lat_data(lat_idx);

    % -提取目标点上的气象要素（例如：降水率）的时间序列
    startLoc = [lon_idx,lat_idx,1]; % 起始位置. lon,lat,time
    count  = [1,1,Inf]; % 元素数量.
    prec_mon(size_+1:size_+36) = squeeze(ncread(nc_file_name,'pre',startLoc,count)); % 月降水量(monthly precipitation), 单位：0.1 mm.
    size_ = size_ + 36;
end

%% -2. 读取"中国1km分辨率逐月平均气温数据集（1901-2017）"的数据
size_ = 0; % 已读取的数据量
for year_beg = 1976:3:2015
    % -读取数据
    nc_file_name = sprintf('D:\\数据\\中国1km分辨率逐月平均气温数据集（1901-2017）\\tmp_%d_%d.nc',year_beg,year_beg+2);
%     ncdisp(nc_file_name)
    lon_data = ncread(nc_file_name,'lon'); % 经度(longitude). 本地：121.4328 deg
    lat_data = ncread(nc_file_name,'lat'); % 纬度(latitude). 本地：31.025 deg
    time_data = ncread(nc_file_name,'time'); % 时间(time).

    % -选取最接近本地位置（北纬 31.025 deg，东经 121.4328 deg）的点（目标点）
    [~,lon_idx] = min(abs(lon_data - lon_local));
    lon_actual = lon_data(lon_idx);
    [~,lat_idx] = min(abs(lat_data - lat_local));
    lat_actual = lat_data(lat_idx);

    % -提取目标点上的气象要素（例如：降水率）的时间序列
    startLoc = [lon_idx,lat_idx,1]; % 起始位置. lon,lat,time
    count  = [1,1,Inf]; % 元素数量.
    temp_mon(size_+1:size_+36) = squeeze(ncread(nc_file_name,'tmp',startLoc,count)); % 逐月平均气温(monthly mean temperature), 单位：0.1 deg Celsius
    size_ = size_ + 36;
end

%% 3. 读取"中国区域地面气象要素驱动数据集（1979-2018）"的降水率数据

nc_file_name = sprintf('D:\\数据\\中国区域地面气象要素驱动数据集（1979-2018）\\Data_forcing_01mo_010deg\\prec_CMFD_V0106_B-01_01mo_010deg_197901-201812.nc');
lon_data = ncread(nc_file_name,'lon'); % 经度(longitude). 本地：121.4328 deg
lat_data = ncread(nc_file_name,'lat'); % 纬度(latitude). 本地：31.025 deg
time_data = ncread(nc_file_name,'time'); % 时间(time).

% -选取最接近本地位置（北纬 31.025 deg，东经 121.4328 deg）的点（目标点）
[~,lon_idx] = min(abs(lon_data - lon_local));
lon_actual = lon_data(lon_idx);
[~,lat_idx] = min(abs(lat_data - lat_local));
lat_actual = lat_data(lat_idx);

% -提取目标点上的气象要素（例如：降水率）的时间序列
startLoc = [lon_idx,lat_idx,1]; % 起始位置. lat,lon,time
count  = [1,1,Inf]; % 元素数量.
scale_factor = double(ncreadatt(nc_file_name,'prec','scale_factor'));
add_offset = double(ncreadatt(nc_file_name,'prec','add_offset'));
prec_mon_ref = squeeze(ncread(nc_file_name,'prec',startLoc,count)); % 逐月平均降水率(monthly mean precipitation rate), 单位：mm/hr

%% 4. 读取"中国区域地面气象要素驱动数据集（1979-2018）"的气温数据

nc_file_name = sprintf('D:\\数据\\中国区域地面气象要素驱动数据集（1979-2018）\\Data_forcing_01mo_010deg\\temp_CMFD_V0106_B-01_01mo_010deg_197901-201812.nc');
lon_data = ncread(nc_file_name,'lon'); % 经度(longitude). 本地：121.4328 deg
lat_data = ncread(nc_file_name,'lat'); % 纬度(latitude). 本地：31.025 deg
time_data = ncread(nc_file_name,'time'); % 时间(time).

% -选取最接近本地位置（北纬 31.025 deg，东经 121.4328 deg）的点（目标点）
[~,lon_idx] = min(abs(lon_data - lon_local));
lon_actual = lon_data(lon_idx);
[~,lat_idx] = min(abs(lat_data - lat_local));
lat_actual = lat_data(lat_idx);

% -提取目标点上的气象要素（例如：降水率）的时间序列
startLoc = [lon_idx,lat_idx,1]; % 起始位置. lat,lon,time
count  = [1,1,Inf]; % 元素数量.
scale_factor = double(ncreadatt(nc_file_name,'temp','scale_factor'));
add_offset = double(ncreadatt(nc_file_name,'temp','add_offset'));
temp_mon_ref = squeeze(ncread(nc_file_name,'temp',startLoc,count)); % 逐月平均近地面气温(Monthly mean near surface air temperature), 单位：K

%% 保存数据
% 数据说明：
%   prec_mon    提取自数据集#1. 1976-2017 逐月降水量(monthly precipitation), 单位：0.1 mm.
%   temp_mon    提取自数据集#2. 1976-2017 逐月平均气温(monthly mean temperature), 单位：0.1 deg Celsius
%   prec_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均降水率(monthly mean precipitation rate), 单位：mm/hr
%   temp_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均近地面气温(Monthly mean near surface air temperature), 单位：K

save('meteo_data.mat','prec_mon','prec_mon_ref','temp_mon','temp_mon_ref')
