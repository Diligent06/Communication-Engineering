function [xk] = Base_2DIF(xn, N)
%BASE_2DIF 此处显示有关此函数的摘要
%   此处显示详细说明
M=log2(N);
for m=0:M-1
    num_of_group = 2^m;
    interval_of_group = N/2^m;
    interval_of_unit = N/2^(m+1);
    cycle_count = N/2^(m+1)-1;
    wn = exp(-1i*2*pi/interval_of_group);
    for g=1:num_of_group
        interval_1=(g-1)*interval_of_group;
        interval_2=(g-1)*interval_of_group+interval_of_unit;
        for r=0:cycle_count
            k=r+1;
            xn(k+interval_1)=xn(k+interval_1)+xn(k+interval_2);
            xn(k+interval_2)=[xn(k+interval_1)-xn(k+interval_2)-xn(k+interval_2)]*wn^r;
        end
    end
end
n1=fliplr(dec2bin([0:N-1]));
n2=[bin2dec(n1)];
for i=1:N
    xk(i)=xn(n2(i)+1);
end
  
end

