function result = cv5_val_before(dataset,options)

    indices = crossvalind('Kfold',dataset(:,1),5);
    result = 0;
    for i = 1:5
        
        test = (indices == i); 
        train = ~test;
    
        trainInput = dataset(train,1:4);
        trainOutput = dataset(train,5);
    
        testInput = dataset(test, 1:4);
        testOutput = dataset(test, 5);
    
        fis_gen = genfis(trainInput,trainOutput,options);
        diff = evalfis(fis_gen,testInput) - testOutput;
        result = result + mean(diff.*diff);
    end
    result = sqrt(result/5);
    fprintf('Błąd średniokwadratowy przed użyciem algorytmu: %.3f%\n', result);
end

