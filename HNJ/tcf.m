function [R1263]=tcf(fileName)
load(fileName);
fs63=126000;%%采样率
fd63=1000;%%码元速率
L63=fs63/fd63;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%分段采样，求相关矩阵
sample_signal63=zeros(126,126);
for i=1:126
   sample_signali63=signal_seq((i-1)*L63+1:1:i*L63);
   sample_signal63(i,:)=sample_signali63;
end
signal63=(sample_signal63'*sample_signal63)/126;
[V63,D63]=eig(signal63);

V163=V63(:,124);
V263=V63(:,125);
V363=V63(:,126);
V463=V363(63:125);
for n1=1:1:62
    for n2=1:1:62
        for n=1:length(V463); 
            if n+n1>length(V463);
                m1=mod(n+n1,length(V463));
            else
                m1=n+n1;
            end
            if n+n2>length(V463);
                m2=mod(n+n2,length(V463)); 
            else
                m2=n+n2;
            end
            if m1==0
                m1=m1+63;           
            end
            if m2==0
                m2=m2+63;           
            end
    zn163(n)=V463(m1);
    zn263(n)=V463(m2);
        end
    Zn1263 =zn163.* zn263;
    Zn63=V463'.*Zn1263;
    R1263(n1,n2)=mean(Zn63); 
    end
end

