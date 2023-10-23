function fsrRegiongrow(x0,y0,mode)
%功能：        通过函数递归方法对二值化图像指定连通区域实现区域生长                                  
%输入参数：    x0,y0表示生长点像素坐标，mode表示以多大邻域进行区域生长，常取mode = 4；mode = 8；      
%输出参数：    void                                                                 
global R BW counter row col
   
if 8 == mode
    for i = -1 : 1
        for j = -1 : 1
            x1 = x0 + i;
            y1 = y0 + j;
            %生长准则：判断生长点8邻域内像素的各自灰度值是否与生长点所在像素灰度值相等
            if x1 > 0 && x1 <= row && y1 > 0 && y1 <= col && BW(x1,y1) == BW(x0,y0) && 0 == R(x1,y1)
                R(x1,y1) = 255;
                counter = counter + 1;
                fsrRegiongrow(x1,y1,mode);                    
            end
        end
    end
elseif 4 == mode
    for i = -1 : 1
        x1 = x0 + i;
        y1 = y0;
        if x1 > 0 && x1 <= row && y1 > 0 && y1 <= col && BW(x1,y1) == BW(x0,y0) && 0 == R(x1,y1)
            R(x1,y1) = 255;
            counter = counter + 1;
            fsrRegiongrow(x1,y1,mode);      
        end
    end
    x1 = x0;
    y1 = y0 - 1;
    if x1 > 0 && x1 <= row && y1 > 0 && y1 <= col && BW(x1,y1) == BW(x0,y0) && 0 == R(x1,y1)
        R(x1,y1) = 255;
        counter = counter + 1;
        fsrRegiongrow(x1,y1,mode);      
    end
    x1 = x0;
    y1 = y0 + 1;
    if x1 > 0 && x1 <= row && y1 > 0 && y1 <= col && BW(x1,y1) == BW(x0,y0) && 0 == R(x1,y1)
        R(x1,y1) = 255;
        counter = counter + 1;
        fsrRegiongrow(x1,y1,mode);      
    end
end
end