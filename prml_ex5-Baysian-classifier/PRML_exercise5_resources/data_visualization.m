clc; clear all; close all; 

Data=load ('t017.mat');  % struct double 512x512


Data

Data.mu

plotclass(Data.mu, Data.Sigma);

plot(Data.data(1, :), Data.data(2, :),  '.');