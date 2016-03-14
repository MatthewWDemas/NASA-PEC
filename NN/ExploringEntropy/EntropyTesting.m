clear all 
close all 
clc 

t=0:.01:10;
X=sin(t*10*pi);

r=std(X)*.2;
SE=SampEn(3,r,X,1)