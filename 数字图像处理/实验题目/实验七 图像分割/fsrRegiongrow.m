function fsrRegiongrow(x0,y0,mode)
%���ܣ�        ͨ�������ݹ鷽���Զ�ֵ��ͼ��ָ����ͨ����ʵ����������                                  
%���������    x0,y0��ʾ�������������꣬mode��ʾ�Զ���������������������ȡmode = 4��mode = 8��      
%���������    void                                                                 
global R BW counter row col
   
if 8 == mode
    for i = -1 : 1
        for j = -1 : 1
            x1 = x0 + i;
            y1 = y0 + j;
            %����׼���ж�������8���������صĸ��ԻҶ�ֵ�Ƿ����������������ػҶ�ֵ���
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