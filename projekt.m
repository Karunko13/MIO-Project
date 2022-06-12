clear;
clc;
close all;
warning off;

perc = 0.8;
myObj = currents;

%Inicjalizacja iris
[dataset, value] = iris_dataset;
dataset = dataset.';
value = vec2ind(value)';
dataset = [dataset, value];
[n, ~] = size(dataset);

%%Inicjalizacja seeds
% dataset = readmatrix('seeds.csv');
% [n, ~] = size(dataset);

%%Inicjalizacja wine
% [dataset, value] = wine_dataset;
% dataset = dataset.';
% value = vec2ind(value)';
% dataset = [dataset(:,1:7), value];
% [n, ~] = size(dataset);

%randomizacja zbioru
dataset = dataset(randperm(size(dataset, 1)), :);

%uczacy set
x_ucz = dataset(1:n*perc, 1:end-1);
y_ucz = dataset(1:n*perc, end);

myObj.setcurrent_x_ucz(x_ucz);
myObj.setcurrent_y_ucz(y_ucz);

%testujacy
x_test = dataset(n*perc+1:end, 1:end-1);
y_test = dataset(n*perc+1:end, end);

options = genfisOptions('SubtractiveClustering');

fis = genfis(myObj.getcurrent_x_ucz(), myObj.getcurrent_y_ucz(),options);
myObj.setcurrentfis(fis);
[in,out] = getTunableSettings(fis);

%sprawdzenie dla zbioru uczącego
check(myObj.getcurrentFis(), myObj.getcurrent_x_ucz(), myObj.getcurrent_y_ucz());

%sprawdzenie dla zbioru testującego
check(myObj.getcurrentFis(),x_test,y_test)

%wyciągniecie oryginalnych wartości z genfisu
[paramVals] = getTunableValues(fis, [in; out]);
myObj.setcurrentParams(paramVals);

%wywołanie algorytmu crow

g_best= crow_alg(myObj);

%walidajca CV5 - przed algorytmem
cv5_val_before(dataset,options)

%sprawdzenie poprawnosci klasyfikacji po algorytmie
fis_new = setTunableValues(myObj.getcurrentFis(),in,g_best);
check(fis_new,x_test,y_test);

%walidajca CV5 - po algorytmie
cv5_val_after(dataset);


