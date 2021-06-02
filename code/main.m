%% main.m
% 本-(2020-2021-2)-MA1207-2-概率统计 课程大作业
% 功能：
% 数据源：
%   1. [中国1km分辨率逐月降水量数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/faae7605-a0f2-4d18-b28f-5cee413766a2/)
%   2. [中国1km分辨率逐月平均气温数据集（1901-2017）](http://data.tpdc.ac.cn/zh-hans/data/71ab4677-b66c-4fd1-a004-b2a541c4d5bf/)
%   3. (基准-ref)[中国区域地面气象要素驱动数据集（1979-2018）](http://data.tpdc.ac.cn/zh-hans/data/8028b944-daaa-4511-8769-965612652c49/)
% 作者：危国锐(313017602@qq.com)
% 机构：上海交通大学电子信息与电气工程学院
% 创建日期：2021-05-28
% 最后修改：2021-05-30

%% 初始化

clc; clear; close all

%% 数据预处理
% 提取了原始数据集中最接近本地位置（北纬 31.0250 deg，东经 121.4328 deg）的坐标上的气象要素
% 数据说明：
%   prec_mon    提取自数据集#1. 1976-2017 逐月降水量(monthly precipitation), 单位：0.1 mm.
%   temp_mon    提取自数据集#2. 1976-2017 逐月平均气温(monthly mean temperature), 单位：0.1 deg Celsius
%   prec_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均降水率(monthly mean precipitation rate), 单位：mm/hr
%   temp_mon_ref	提取自基准数据集#3. 1979-2018 逐月平均近地面气温(Monthly mean near surface air temperature), 单位：K
load meteo_data

% 取得三个数据集的的1月、7月数据
Jan_prec = prec_mon(1:12:length(prec_mon)) / 10; % (来自#1) 1976-2017 一月降水量(mm)
Jul_prec = prec_mon(7:12:length(prec_mon)) / 10; % (来自#1) 1976-2017 七月降水量(mm)
Jan_temp = temp_mon(1:12:length(temp_mon)) / 10; % (来自#2) 1976-2017 一月均温(deg C)
Jul_temp = temp_mon(7:12:length(temp_mon)) / 10; % (来自#2) 1976-2017 七月均温(deg C)

Jan_prec_ref = prec_mon_ref(1:12:length(prec_mon_ref)) * 31 * 24; % (来自#3) 1979-2018 一月降水量(mm)
Jul_prec_ref = prec_mon_ref(7:12:length(prec_mon_ref)) * 31 * 24; % (来自#3) 1979-2018 七月降水量(mm)
Jan_temp_ref = temp_mon_ref(1:12:length(temp_mon_ref)) - 273.15; % (来自#3) 1979-2018 一月均温(deg C)
Jul_temp_ref = temp_mon_ref(7:12:length(temp_mon_ref)) - 273.15; % (来自#3) 1979-2018 七月均温(deg C)

%% 0. 作原始数据示意图
figure('Name','原始数据-一月降水量')
plot(1976:2017,Jan_prec,'-.o')
hold on
plot(1979:2018,Jan_prec_ref,'-.+')
hold off
xlabel('年份')
ylabel('月降水量/mm')
legend({'来源[1]','来源[3]'},'location','best')
title('一月降水量')

figure('Name','原始数据-七月降水量')
plot(1976:2017,Jul_prec,'-.o')
hold on
plot(1979:2018,Jul_prec_ref,'-.+')
hold off
xlabel('年份')
ylabel('月降水量/mm')
legend({'来源[1]','来源[3]'},'location','best')
title('七月降水量')

figure('Name','原始数据-一月均温')
plot(1976:2017,Jan_temp,'-.o')
hold on
plot(1979:2018,Jan_temp_ref,'-.+')
hold off
xlabel('年份')
ylabel('月均温/℃')
legend({'来源[2]','来源[3]'},'location','best')
title('一月均温')

figure('Name','原始数据-七月均温')
plot(1976:2017,Jul_temp,'-.o')
hold on
plot(1979:2018,Jul_temp_ref,'-.+')
hold off
xlabel('年份')
ylabel('月均温/℃')
legend({'来源[2]','来源[3]'},'location','best')
title('七月均温')

%% 1. 检验1976-2017逐月降水量，逐月均温是否接近正态分布。数据集：#1,#2

% distributionFitter

%% 绘频率分布直方图
figure('Name','一月降水量#1')
histfit(Jan_prec)
pd = fitdist(Jan_prec,'Normal');
title('一月降水量频数直方图')
ylabel('频数')
xlabel('降水量/mm')
legend({'频数','正态拟合'})
% 创建 textbox
annotation('textbox',[0.15 0.8 0.15 0.1],...
    'String',{sprintf('\\mu = %.1f',pd.mean),sprintf('\\sigma = %.1f',pd.sigma)},...
    'FitBoxToText','on','LineStyle','None');

figure('Name','七月降水量#1')
histfit(Jul_prec)
pd = fitdist(Jul_prec,'Normal');
title('七月降水量频数直方图')
ylabel('频数')
xlabel('降水量/mm')
legend({'频数','正态拟合'})
% 创建 textbox
annotation('textbox',[0.15 0.8 0.15 0.1],...
    'String',{sprintf('\\mu = %.1f',pd.mean),sprintf('\\sigma = %.1f',pd.sigma),},...
    'FitBoxToText','on','LineStyle','None');

figure('Name','一月均温#2')
histfit(Jan_temp)
pd = fitdist(Jan_temp,'Normal');
title('一月均温频数直方图')
ylabel('频数')
xlabel('月均温/℃')
legend({'频数','正态拟合'})
% 创建 textbox
annotation('textbox',[0.15 0.8 0.15 0.1],...
    'String',{sprintf('\\mu = %.1f',pd.mean),sprintf('\\sigma = %.1f',pd.sigma)},...
    'FitBoxToText','on','LineStyle','None');

figure('Name','七月均温#2')
histfit(Jul_temp)
pd = fitdist(Jul_temp,'Normal');
title('七月均温频数直方图')
ylabel('频数')
xlabel('月均温/℃')
legend({'频数','正态拟合'})
% 创建 textbox
annotation('textbox',[0.15 0.8 0.15 0.1],...
    'String',{sprintf('\\mu = %.1f',pd.mean),sprintf('\\sigma = %.1f',pd.sigma)},...
    'FitBoxToText','on','LineStyle','None');

%% 绘制经验分布图
figure('Name','一月降水量-normplot')
normplot(Jan_prec)
title('一月降水量-正态概率图')
legend({'正态分布','Q1-Q3连线','经验分布'},'location','best')

figure('Name','七月降水量-normplot')
normplot(Jul_prec)
title('七月降水量-正态概率图')
legend({'正态分布','Q1-Q3连线','经验分布'},'location','best')

figure('Name','一月均温-normplot')
normplot(Jan_temp)
title('一月均温-正态概率图')
legend({'正态分布','Q1-Q3连线','经验分布'},'location','best')

figure('Name','七月均温-normplot')
normplot(Jul_temp)
title('七月均温-正态概率图')
legend({'正态分布','Q1-Q3连线','经验分布'},'location','best')

% 
% h = lillietest(x) returns a test decision for the null hypothesis that the data in vector x comes from a distribution in the normal family, against the alternative that it does not come from such a distribution, using a Lilliefors test. The result h is 1 if the test rejects the null hypothesis at the 5% significance level, and 0 otherwise.
[h_Jan_prec,p_Jan_prec,kstat_Jan_prec,critval_Jan_prec] = lillietest(Jan_prec);
[h_Jul_prec,p_Jul_prec,kstat_Jul_prec,critval_Jul_prec] = lillietest(Jul_prec);
[h_Jan_temp,p_Jan_temp,kstat_Jan_temp,critval_Jan_temp] = lillietest(Jan_temp);
[h_Jul_temp,p_Jul_temp,kstat_Jul_temp,critval_Jul_temp] = lillietest(Jul_temp);

% 发现一月均温偏离正态分布，可能是数据集问题，或气候变化。

%% 2. 比较 1979-1998, 1999-2018 这两个二十年间的气温和降水量变化

%% 非参数检验
[li_h_Jan_prec_ref_H1,li_p_Jan_prec_ref_H1,li_kstat_Jan_prec_ref_H1,li_critval_Jan_prec_ref_H1] = lillietest(Jan_prec_ref(1:length(Jan_prec_ref)/2));
[li_h_Jan_prec_ref_H2,li_p_Jan_prec_ref_H2,li_kstat_Jan_prec_ref_H2,li_critval_Jan_prec_ref_H2] = lillietest(Jan_prec_ref(length(Jan_prec_ref)/2 +1:end));
[li_h_Jul_prec_ref_H1,li_p_Jul_prec_ref_H1,li_kstat_Jul_prec_ref_H1,li_critval_Jul_prec_ref_H1] = lillietest(Jul_prec_ref(1:length(Jul_prec_ref)/2));
[li_h_Jul_prec_ref_H2,li_p_Jul_prec_ref_H2,li_kstat_Jul_prec_ref_H2,li_critval_Jul_prec_ref_H2] = lillietest(Jul_prec_ref(length(Jul_prec_ref)/2 +1:end));
[li_h_Jan_temp_ref_H1,li_p_Jan_temp_ref_H1,li_kstat_Jan_temp_ref_H1,li_critval_Jan_temp_ref_H1] = lillietest(Jan_temp_ref(1:length(Jan_temp_ref)/2));
[li_h_Jan_temp_ref_H2,li_p_Jan_temp_ref_H2,li_kstat_Jan_temp_ref_H2,li_critval_Jan_temp_ref_H2] = lillietest(Jan_temp_ref(length(Jan_temp_ref)/2 +1:end));
[li_h_Jul_temp_ref_H1,li_p_Jul_temp_ref_H1,li_kstat_Jul_temp_ref_H1,li_critval_Jul_temp_ref_H1] = lillietest(Jul_temp_ref(1:length(Jul_temp_ref)/2));
[li_h_Jul_temp_ref_H2,li_p_Jul_temp_ref_H2,li_kstat_Jul_temp_ref_H2,li_critval_Jul_temp_ref_H2] = lillietest(Jul_temp_ref(length(Jul_temp_ref)/2 +1:end));

%% 分布拟合（包括单个正态总体参数的区间估计）
pd_Jan_prec_ref_H1 = fitdist(Jan_prec_ref(1:length(Jan_prec_ref)/2),'Normal');
pd_Jan_prec_ref_H2 = fitdist(Jan_prec_ref(length(Jan_prec_ref)/2 +1:end),'Normal');
pd_Jul_prec_ref_H1 = fitdist(Jul_prec_ref(1:length(Jul_prec_ref)/2),'Normal');
pd_Jul_prec_ref_H2 = fitdist(Jul_prec_ref(length(Jul_prec_ref)/2 +1:end),'Normal');
pd_Jan_temp_ref_H1 = fitdist(Jan_temp_ref(1:length(Jan_temp_ref)/2),'Normal');
pd_Jan_temp_ref_H2 = fitdist(Jan_temp_ref(length(Jan_temp_ref)/2 +1:end),'Normal');
pd_Jul_temp_ref_H1 = fitdist(Jul_temp_ref(1:length(Jul_temp_ref)/2),'Normal');
pd_Jul_temp_ref_H2 = fitdist(Jul_temp_ref(length(Jul_temp_ref)/2 +1:end),'Normal');

%% 单个正态总体参数的假设检验
% \sigma未知，对\mu的检验（包括参数的区间估计，结果同fitdist的）
[mu_h_Jan_prec_ref_H1,mu_p_Jan_prec_ref_H1,mu_ci_Jan_prec_ref_H1,mu_stats_Jan_prec_ref_H1] = ttest(Jan_prec_ref(1:length(Jan_prec_ref)/2),pd_Jan_prec_ref_H1.mu,'Tail','both');
[mu_h_Jan_prec_ref_H2,mu_p_Jan_prec_ref_H2,mu_ci_Jan_prec_ref_H2,mu_stats_Jan_prec_ref_H2] = ttest(Jan_prec_ref(length(Jan_prec_ref)/2 +1:end),pd_Jan_prec_ref_H2.mu,'Tail','both');
[mu_h_Jul_prec_ref_H1,mu_p_Jul_prec_ref_H1,mu_ci_Jul_prec_ref_H1,mu_stats_Jul_prec_ref_H1] = ttest(Jul_prec_ref(1:length(Jul_prec_ref)/2),pd_Jul_prec_ref_H1.mu,'Tail','both');
[mu_h_Jul_prec_ref_H2,mu_p_Jul_prec_ref_H2,mu_ci_Jul_prec_ref_H2,mu_stats_Jul_prec_ref_H2] = ttest(Jul_prec_ref(length(Jul_prec_ref)/2 +1:end),pd_Jul_prec_ref_H2.mu,'Tail','both');
[mu_h_Jan_temp_ref_H1,mu_p_Jan_temp_ref_H1,mu_ci_Jan_temp_ref_H1,mu_stats_Jan_temp_ref_H1] = ttest(Jan_temp_ref(1:length(Jan_temp_ref)/2),pd_Jan_temp_ref_H1.mu,'Tail','both');
[mu_h_Jan_temp_ref_H2,mu_p_Jan_temp_ref_H2,mu_ci_Jan_temp_ref_H2,mu_stats_Jan_temp_ref_H2] = ttest(Jan_temp_ref(length(Jan_temp_ref)/2 +1:end),pd_Jan_temp_ref_H2.mu,'Tail','both');
[mu_h_Jul_temp_ref_H1,mu_p_Jul_temp_ref_H1,mu_ci_Jul_temp_ref_H1,mu_stats_Jul_temp_ref_H1] = ttest(Jul_temp_ref(1:length(Jul_temp_ref)/2),pd_Jul_temp_ref_H1.mu,'Tail','both');
[mu_h_Jul_temp_ref_H2,mu_p_Jul_temp_ref_H2,mu_ci_Jul_temp_ref_H2,mu_stats_Jul_temp_ref_H2] = ttest(Jul_temp_ref(length(Jul_temp_ref)/2 +1:end),pd_Jul_temp_ref_H2.mu,'Tail','both');

% \mu未知，对\sigma的检验（包括参数的区间估计，结果同fitdist的）
[var_h_Jan_prec_ref_H1,var_p_Jan_prec_ref_H1,var_ci_Jan_prec_ref_H1,var_stats_Jan_prec_ref_H1] = vartest(Jan_prec_ref(1:length(Jan_prec_ref)/2),pd_Jan_prec_ref_H1.sigma^2,'Tail','both');
[var_h_Jan_prec_ref_H2,var_p_Jan_prec_ref_H2,var_ci_Jan_prec_ref_H2,var_stats_Jan_prec_ref_H2] = vartest(Jan_prec_ref(length(Jan_prec_ref)/2 +1:end),pd_Jan_prec_ref_H2.sigma^2,'Tail','both');
[var_h_Jul_prec_ref_H1,var_p_Jul_prec_ref_H1,var_ci_Jul_prec_ref_H1,var_stats_Jul_prec_ref_H1] = vartest(Jul_prec_ref(1:length(Jul_prec_ref)/2),pd_Jul_prec_ref_H1.sigma^2,'Tail','both');
[var_h_Jul_prec_ref_H2,var_p_Jul_prec_ref_H2,var_ci_Jul_prec_ref_H2,var_stats_Jul_prec_ref_H2] = vartest(Jul_prec_ref(length(Jul_prec_ref)/2 +1:end),pd_Jul_prec_ref_H2.sigma^2,'Tail','both');
[var_h_Jan_temp_ref_H1,var_p_Jan_temp_ref_H1,var_ci_Jan_temp_ref_H1,var_stats_Jan_temp_ref_H1] = vartest(Jan_temp_ref(1:length(Jan_temp_ref)/2),pd_Jan_temp_ref_H1.sigma^2,'Tail','both');
[var_h_Jan_temp_ref_H2,var_p_Jan_temp_ref_H2,var_ci_Jan_temp_ref_H2,var_stats_Jan_temp_ref_H2] = vartest(Jan_temp_ref(length(Jan_temp_ref)/2 +1:end),pd_Jan_temp_ref_H2.sigma^2,'Tail','both');
[var_h_Jul_temp_ref_H1,var_p_Jul_temp_ref_H1,var_ci_Jul_temp_ref_H1,var_stats_Jul_temp_ref_H1] = vartest(Jul_temp_ref(1:length(Jul_temp_ref)/2),pd_Jul_temp_ref_H1.sigma^2,'Tail','both');
[var_h_Jul_temp_ref_H2,var_p_Jul_temp_ref_H2,var_ci_Jul_temp_ref_H2,var_stats_Jul_temp_ref_H2] = vartest(Jul_temp_ref(length(Jul_temp_ref)/2 +1:end),pd_Jul_temp_ref_H2.sigma^2,'Tail','both');

%% 两个正态总体参数的假设检验（包括区间估计）

% \sigma_1,\sigma_2 均未知，但 n_1 = n_2；检验\mu_1 - \mu_2
[mu21_h_Jan_prec_ref,mu21_p_Jan_prec_ref,mu21_ci_Jan_prec_ref,mu21_stats_Jan_prec_ref] = ttest(Jan_prec_ref(1:length(Jan_prec_ref)/2),Jan_prec_ref(length(Jan_prec_ref)/2 +1:end),'Tail','both');
[mu21_h_Jul_prec_ref,mu21_p_Jul_prec_ref,mu21_ci_Jul_prec_ref,mu21_stats_Jul_prec_ref] = ttest(Jul_prec_ref(1:length(Jul_prec_ref)/2),Jul_prec_ref(length(Jul_prec_ref)/2 +1:end),'Tail','both');
[mu21_h_Jan_temp_ref,mu21_p_Jan_temp_ref,mu21_ci_Jan_temp_ref,mu21_stats_Jan_temp_ref] = ttest(Jan_temp_ref(1:length(Jan_temp_ref)/2),Jan_temp_ref(length(Jan_temp_ref)/2 +1:end),'Tail','both');
[mu21_h_Jul_temp_ref,mu21_p_Jul_temp_ref,mu21_ci_Jul_temp_ref,mu21_stats_Jul_temp_ref] = ttest(Jul_temp_ref(1:length(Jul_temp_ref)/2),Jul_temp_ref(length(Jul_temp_ref)/2 +1:end),'Tail','both');

% \mu_1,\mu_2 均未知，但 n_1 = n_2；检验var_1/var_2
[var21_h_Jan_prec_ref,var21_p_Jan_prec_ref,var21_ci_Jan_prec_ref,var21_stats_Jan_prec_ref] = vartest2(Jan_prec_ref(1:length(Jan_prec_ref)/2),Jan_prec_ref(length(Jan_prec_ref)/2 +1:end),'Tail','both');
[var21_h_Jul_prec_ref,var21_p_Jul_prec_ref,var21_ci_Jul_prec_ref,var21_stats_Jul_prec_ref] = vartest2(Jul_prec_ref(1:length(Jul_prec_ref)/2),Jul_prec_ref(length(Jul_prec_ref)/2 +1:end),'Tail','both');
[var21_h_Jan_temp_ref,var21_p_Jan_temp_ref,var21_ci_Jan_temp_ref,var21_stats_Jan_temp_ref] = vartest2(Jan_temp_ref(1:length(Jan_temp_ref)/2),Jan_temp_ref(length(Jan_temp_ref)/2 +1:end),'Tail','both');
[var21_h_Jul_temp_ref,var21_p_Jul_temp_ref,var21_ci_Jul_temp_ref,var21_stats_Jul_temp_ref] = vartest2(Jul_temp_ref(1:length(Jul_temp_ref)/2),Jul_temp_ref(length(Jul_temp_ref)/2 +1:end),'Tail','both');

%% 两个正态总体中位数的假设检验（缺口箱线图notched box plot法）
figure('Name','缺口箱线图-一月降水量')
boxplot([Jan_prec_ref(1:length(Jan_prec_ref)/2),Jan_prec_ref(length(Jan_prec_ref)/2 +1 :end)],'Notch','on','Labels',{'1978-1997','1998-2017'})
title('缺口箱线图-一月降水量')
xlabel('年份')
ylabel('降水量/mm')

figure('Name','缺口箱线图-七月降水量')
boxplot([Jul_prec_ref(1:length(Jul_prec_ref)/2),Jul_prec_ref(length(Jul_prec_ref)/2 +1 :end)],'Notch','on','Labels',{'1978-1997','1998-2017'})
title('缺口箱线图-七月降水量')
xlabel('年份')
ylabel('降水量/mm')

figure('Name','缺口箱线图-一月均温')
boxplot([Jan_temp_ref(1:length(Jan_temp_ref)/2),Jan_temp_ref(length(Jan_temp_ref)/2 +1 :end)],'Notch','on','Labels',{'1978-1997','1998-2017'})
title('缺口箱线图-一月均温')
xlabel('年份')
ylabel('均温/℃')

figure('Name','缺口箱线图-七月均温')
boxplot([Jul_temp_ref(1:length(Jul_temp_ref)/2),Jul_temp_ref(length(Jul_temp_ref)/2 +1 :end)],'Notch','on','Labels',{'1978-1997','1998-2017'})
title('缺口箱线图-七月均温')
xlabel('年份')
ylabel('均温/℃')
