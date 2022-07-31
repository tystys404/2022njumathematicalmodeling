function [score,index] = suafan(data,reference,quanzhong,index)
    N = length(index);
    score = zeros(N,1);
    for i = [1:N]
        temp = reference(index(i),:) == 1;
        num = sum(temp);
        score(i) = sum(temp .* data(index(i),:) .* quanzhong') / num;
    end
end

