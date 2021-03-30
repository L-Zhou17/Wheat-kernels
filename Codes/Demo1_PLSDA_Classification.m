clear
clc
close all

data1=csvread('DT_train.csv');
data2=csvread('DT_val.csv');
data3=csvread('DT_test.csv');

Xc=data1(:,1:200);
Lc=data1(:,201)+1;
Xv=data2(:,1:200);
Lv=data2(:,201)+1;
Xp=data3(:,1:200);
Lp=data3(:,201)+1;
clear data1 data2 data3

maxcopm=200;
ca=[];
va=[];
for comp=1:maxcopm
    [~,cacc,~,vacc,~] = ZL_PLSDA(Xc,Lc,Xv,Lv,comp);
    ca=[ca;cacc];
    va=[va;vacc];
end
    figure
    plot(1:maxcopm,ca,'g.');
    hold on
    plot(1:maxcopm,va,'k.');
    [mv,ml]=max(va);
[yc,ACC_cal,yp,ACC_val,beta] = ZL_PLSDA(Xc,Lc,Xp,Lp,ml);
    
figure
subplot(121)
ZL_confusionmat(Lc,yc,'Train');
subplot(122)
ZL_confusionmat(Lp,yp,'Test');