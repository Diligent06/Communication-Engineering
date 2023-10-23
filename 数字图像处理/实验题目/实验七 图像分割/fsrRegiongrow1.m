function fsrRegiongrow1(x0,y0,mode)
%功能：        模拟栈的先进后出思路对二值化图像指定连通区域实现区域生长                        
%输入参数：    x0,y0表示生长点像素坐标，mode表示以多大邻域进行区域生长，常取mode = 4；mode = 8；
%输出参数：    void                                                                              
%作者&时间：   奔跑在湘边———2016年5月6日                                                    
global R BW counter row col
  
zhan = zeros(row*col,2);%创建栈数组
pzhan = 1;              %栈计数
zhan(pzhan,1) = x0;
zhan(pzhan,2) = y0;
R(x0,y0) = 255;
counter = 1;
  
if 8 == mode
    while pzhan > 0
        x1 = zhan(pzhan,1);%出栈
        y1 = zhan(pzhan,2);
        pzhan = pzhan - 1; %栈计数减一
        for i = -1 : 1
            for j = -1 : 1
                %生长准则：判断生长点8邻域内像素的各自灰度值是否与生长点所在像素灰度值相等
                if x1+i > 0 && x1+i <= row && y1+j > 0 && y1+j <= col && BW(x1+i,y1+j) == BW(x1,y1) && R(x1+i,y1+j) ~= R(x1,y1)
                    R(x1+i,y1+j) = R(x1,y1);
                    counter = counter + 1;
                    pzhan = pzhan + 1;     %栈计数增一
                    zhan(pzhan,1) = x1 + i;%入栈
                    zhan(pzhan,2) = y1 + j;
                end
            end
        end
    end
elseif 4 == mode
    while pzhan > 0
        x1 = zhan(pzhan,1);
        y1 = zhan(pzhan,2);
        pzhan = pzhan - 1;
        for i = -1 : 2 : 1   
            j = 0;
            if x1+i > 0 && x1+i <= row && y1+j > 0 && y1+j <= col && BW(x1+i,y1+j) == BW(x1,y1) && R(x1+i,y1+j) ~= R(x1,y1)
                R(x1+i,y1+j) = R(x1,y1);
                counter = counter + 1;
                pzhan = pzhan + 1;
                zhan(pzhan,1) = x1 + i;
                zhan(pzhan,2) = y1 + j;          
            end        
        end
        for j = -1 : 2 : 1   
            i = 0;
            if x1+i > 0 && x1+i <= row && y1+j > 0 && y1+j <= col && BW(x1+i,y1+j) == BW(x1,y1) && R(x1+i,y1+j) ~= R(x1,y1)
                R(x1+i,y1+j) = R(x1,y1);
                counter = counter + 1;
                pzhan = pzhan + 1;
                zhan(pzhan,1) = x1 + i;
                zhan(pzhan,2) = y1 + j;          
            end        
        end
    end
end
end