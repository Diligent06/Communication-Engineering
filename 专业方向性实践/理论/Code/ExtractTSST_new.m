function Ex = ExtractTSST_new( Tx, IdealGD, fs,singleside,direction)
    [L,N] = size(Tx)
    Temp = zeros(L,N);
    dt = 1/fs;
    if direction==1 %1����ʱ�为����
      for ptr = 1:L
        upboard = min( round(IdealGD(ptr)/dt) + singleside+1,N);
        downboard = 1;
        Temp(ptr,downboard:upboard) = 1;
      end
 
    elseif direction==2 %2����ʱ��������
      for ptr = 1:L
        upboard = N;
        downboard = max( round(IdealGD(ptr)/dt) - singleside+1,1);
        Temp(ptr,downboard:upboard) = 1;
     end
    else %3 Ϊ��ͨ  
        %for ptr = 1:L
        %upboard = min(IdealGD(ptr) + singleside+1,N);
        %downboard = max(IdealGD(ptr) - singleside+1,1);
        %Temp(ptr,downboard:upboard) = 1;
        for ptr = 1:N
            upboard = min(IdealGD(ptr)+singleside+1, L);
            downboard = max(IdealGD(ptr)-singleside+1,1);
            Temp(downboard:upboard,ptr) = 1;
        end
    end
      Ex = Tx .* Temp;  
end