function ft=fitness(xn,N,pd, myObj)
    ft = zeros(1,pd);
    for j=1:pd
        x=xn(:,j)';
        for i = 1:size(x, 2)
            if x(i) == 0
                x(i) = 0.001 + rand * (0.05 - 0.001);
            end
        end
        fis_test = myObj.getcurrentFis();
        in = getTunableSettings(fis_test);

        fis_test = setTunableValues(fis_test, in, x);

        y_pso = evalfis(fis_test, myObj.getcurrent_x_ucz());

        for i = 1:size(y_pso, 1)
            y_pso(i) = round(y_pso(i));
        end

        temp = y_pso - myObj.getcurrent_y_ucz();
        q = find(temp == 0);

        fit = (size(y_pso, 1) - size(q, 1)) / size(y_pso, 1);
        ft(1,j)=fit;
    end
    
end