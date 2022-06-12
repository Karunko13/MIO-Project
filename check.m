function check(fis,x_ucz, y_ucz)
    
    y_out = evalfis(fis, x_ucz);
    y_temp = y_out;
    for i = 1:size(y_temp, 1)
        y_temp(i) = round(y_temp(i));
    end
    temp = y_temp - y_ucz;
    q = find(temp == 0);
    fprintf('Procent dobrze zakwalifikowanych przypadków: %.3f%%\n', round(size(q, 1) / size(y_out, 1), 5) * 100);
    
    figure
    g1 = y_ucz';
    g2 = y_temp';
    C = confusionmat(g1,g2);
    confusionchart(C)


end