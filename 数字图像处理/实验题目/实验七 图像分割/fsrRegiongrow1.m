function fsrRegiongrow1(x0,y0,mode)
%���ܣ�        ģ��ջ���Ƚ����˼·�Զ�ֵ��ͼ��ָ����ͨ����ʵ����������                        
%���������    x0,y0��ʾ�������������꣬mode��ʾ�Զ���������������������ȡmode = 4��mode = 8��
%���������    void                                                                              
%����&ʱ�䣺   ��������ߡ�����2016��5��6��                                                    
global R BW counter row col
  
zhan = zeros(row*col,2);%����ջ����
pzhan = 1;              %ջ����
zhan(pzhan,1) = x0;
zhan(pzhan,2) = y0;
R(x0,y0) = 255;
counter = 1;
  
if 8 == mode
    while pzhan > 0
        x1 = zhan(pzhan,1);%��ջ
        y1 = zhan(pzhan,2);
        pzhan = pzhan - 1; %ջ������һ
        for i = -1 : 1
            for j = -1 : 1
                %����׼���ж�������8���������صĸ��ԻҶ�ֵ�Ƿ����������������ػҶ�ֵ���
                if x1+i > 0 && x1+i <= row && y1+j > 0 && y1+j <= col && BW(x1+i,y1+j) == BW(x1,y1) && R(x1+i,y1+j) ~= R(x1,y1)
                    R(x1+i,y1+j) = R(x1,y1);
                    counter = counter + 1;
                    pzhan = pzhan + 1;     %ջ������һ
                    zhan(pzhan,1) = x1 + i;%��ջ
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