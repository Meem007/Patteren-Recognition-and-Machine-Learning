clc; clear all; close all; 
Data=load ('t104.mat'); % loading the dataset 
Data

X=Data.data(1,:)
y=Data.class
