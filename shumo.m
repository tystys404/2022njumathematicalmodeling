clear all;

data = xlsread("C:\Users\GSY\Desktop\data.xlsx");
data = data(:,2:end);
caipan = xlsread("C:\Users\GSY\Desktop\caipan.xlsx");
caipan(isnan(caipan))=0;
caipan = caipan(:,2:end);
caipan = suiji(caipan);
reference = zeros(200,10);

% 第一次的权重
for i =[1:20]
    temp = [1:10];
    step1 = temp(caipan(i,:)==1);
    reference(i*10-9:i*10,step1) = 1;
end
quan_1 = quanhzong(data,reference);

num_list_after_1 = zeros(20,6);
score_list_after_1 = zeros(200,1);
for i = [1:20]
    zhishi = caipan(i,:)==1;
    index = 0;
    score_list_1 = zeros(10,1);
    for j = zhishi
        index = index+1;
        if j == 1
            score_list_1 = score_list_1 + data(1+(i-1)*10:i*10,index);
        end
    end
    [~,IX] = sort(score_list_1,'descend');
    num_list_after_1(i,:) = IX(1:6)' + (i-1)*10;
    score_list_after_1(1+(i-1)*10:i*10) = score_list_1;
end
num_list_after_1 = reshape(num_list_after_1,120,1);


% 第二次的权重
for i =[1:120]
    temp = [1:10];
    hang = num_list_after_1(i);
    zubie = ceil(hang / 10);
    step2 = temp(caipan(zubie,:)==2);
    reference(hang,step2) = 1;
end
quan_2 = quanhzong(data,reference);

% 第二次打分
[score_list_after_2,num_list_after_2] = suafan(data,reference,quan_2,num_list_after_1);
[~,IX] = sort(score_list_after_2,'descend');

%第三次打分
num_100 = IX(1:100);
num_100 = num_list_after_2(num_100);
sec1 = num_100(31:40);
score_sec1 = score_list_after_2(IX(31:40));
third1 = num_100(61:100);
score_third1 = score_list_after_2(IX(61:100));

num_30 = num_100(1:30);
% score_list_before_3_30 = score_list_after_1(num_30);
num_20 = num_100(41:60);
% score_list_before_3_20 = score_list_after_1(num_20);

%第三次权重
num_3 = [num_30;num_20];
for i = [1:50]
    temp = [1:10];
    hang = num_3(i);
    zubie = ceil(hang / 10);
    step3 = temp(caipan(zubie,:)==3);
    reference(hang,step3) = 1;
end
quan_3 = quanhzong(data,reference);

[score_list_after_3_30,num_30] = suafan(data,reference,quan_3,num_30);
[score_list_after_3_20,num_20] = suafan(data,reference,quan_3,num_20);


[~,IX1] = sort(score_list_after_3_30,'descend');
fir1 = num_30(IX1(1:15));
score_fir1 = score_list_after_3_30(IX1(1:15));
sec2 = num_30(IX1(26:30));
score_sec2 = score_list_after_3_30(IX1(26:30));
[~,IX2] = sort(score_list_after_3_20,'descend');
sec3 = num_20(IX2(1:10));
score_sec3 = score_list_after_3_20(IX2(1:10));
third2 = num_20(IX2(11:20));
score_third2 = score_list_after_3_20(IX2(11:20));



% 第四次打分
num_list_before_4 = num_30(IX1(16:25));
% 第四次权重
for i = [1:10]
    temp = [1:10];
    step4 = temp(caipan(i,:)==4);
    hang = num_list_before_4(i);
    zubie = ceil(hang / 10);
    reference(hang,step4) = 1;
end
quan_4 = quanhzong(data,reference);

score_list_after_4 = sum(quan_4.*data(num_list_before_4,:),2) / 10;
[~,IX] = sort(score_list_after_4,'descend');
fir2 = num_list_before_4(IX(1:5));
score_fir2 = score_list_after_4(IX(1:5));
sec4 = num_list_before_4(IX(6:10));
score_sec4 = score_list_after_4(IX(6:10));

fir = [fir1;fir2];
score_fir = [score_fir1;score_fir2];
third = [third2;third1];
score_third = [score_third2;score_third1];
sec = [sec4;sec3;sec1;sec2];
score_sec = [score_sec4;score_sec3;score_sec1;score_sec2];
