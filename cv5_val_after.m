function result = cv5_val_after(dataset)
    indices = crossvalind('Kfold',dataset(:,1),5);
    result = 0;
    for i = 1:5
        valid_obj = currents;
        test = (indices == i); 
        train = ~test;
    
        trainInput = dataset(train,1:4);
        trainOutput = dataset(train,5);
    
        testInput = dataset(test, 1:4);
        testOutput = dataset(test, 5);

        opt = genfisOptions('SubtractiveClustering');
        fis_gen = genfis(trainInput,trainOutput,opt);
        [in_new,out_new] = getTunableSettings(fis_gen);
        [new_vals] = getTunableValues(fis_gen, [in_new; out_new]);

        valid_obj.setcurrent_x_ucz(trainInput);
        valid_obj.setcurrent_y_ucz(trainOutput);
        valid_obj.setcurrentfis(fis_gen);
        valid_obj.setcurrentParams(new_vals)

        new_best = crow_alg(valid_obj);
        fis_new = setTunableValues(fis_gen,in_new,new_best);

        diff = evalfis(fis_new,testInput) - testOutput;
        result = result + mean(diff.*diff);
    
    end
    %błąd średniokwadratowy
    result = sqrt(result/5);
    fprintf('Błąd średniokwadratowy po przejściu algorytmu: %.3f\n', result);
end

