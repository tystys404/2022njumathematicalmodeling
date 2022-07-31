function quan = quanhzong(data,reference)
    quan = ones(10,1);
    mean_data = zeros(200,1);
    mean_caipan = zeros(10,1);
    std_caipan = zeros(10,1);
    for i = [1:200]
        data_i = data(i,:);
        temp = reference(i,:)==1;
        data_i = data_i(temp);
        mean_data(i) = mean(data_i);
    end
    for i =[1:10]
        caipan_i = data(:,i);
        temp = reference(:,i)==1;
        caipan_i = caipan_i(temp);
        mean_caipan(i) = mean(caipan_i);
        std_caipan(i) = std(caipan_i);
    end

    % 变异系数
    bianyi = std_caipan ./ mean_caipan;

    % 均值差绝对值的均值
    mean_abs_mean = zeros(10,1);
    for i =[1:10]
        mean_abs_mean(i) = mean(abs(mean_data-mean_caipan(i)));
    end
    % 均值差的均值
    mean_mean = zeros(10,1);
    for i =[1:10]
        mean_mean(i) = mean(-mean_data+mean_caipan(i));
    end
    % 均值差的标准差
    mean_std = zeros(10,1);
    for i =[1:10]
        mean_std(i) = std(-mean_data+mean_caipan(i));
    end

    % 均值差变异系数
    mean_bianyi = mean_std ./ mean_mean;



    for i = [1:10]
        if mean_abs_mean(i) <= 8
            if abs(mean_mean(i)) <= 4
                quan(i) = 1;
            else
                temp = mean_data;
                xuhao = temp(reference(:,i) == 1);
                quan(i) = mean(xuhao) / mean_caipan(i);
            end
        else
            if abs(mean_bianyi(i)) < 0.6
                temp = mean_data;
                xuhao = temp(reference(:,i) == 1);
                quan(i) = mean(xuhao) / mean_caipan(i);
            else
                temp = mean_data;
                xuhao = temp(reference(:,i) == 1);
                quan(i) = mean(xuhao) / mean_caipan(i);
            end
        end
end

