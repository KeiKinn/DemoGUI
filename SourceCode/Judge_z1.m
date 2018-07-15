function result=Judge_z1(Data, fs)

% fid = fopen('C:\Users\Lwy_j01\Desktop\子程序\fskpncode.bin','rb');

% [A] = fread(fid,19200,'double'); 
% s0 = [A]'
% fs = 100e3;
s0 = Data';
df= 1024;
M = 256;
dalpha = df/M;

Np = pow2(nextpow2(fs/df));            
L =Np/4;                            
P = pow2(nextpow2(fs/dalpha/L)); 
N = P*L;                         

%===================门限值=====================%

MH_e1 = 0.9;
MH_e2 = 2;

MS_e = 0.28;

s0=s0-mean(s0);
s0=hilbert(s0);

%%%%%%%%%%%%%计算高阶统计量%%%%%%%%%%%%%%
C20=mean(s0.^2);
C21=mean(abs(s0).^2);
C42=mean((s0.^2).*conj(s0).^2)-abs(C20)^2-2*C21.^2;

MH_eig = abs(C42);
%%%%%%%%%%%%%计算循环谱%%%%%%%%%%%%%%
alpha0 = -fs:fs/N:fs;
f0 = -fs/2:fs/Np:fs/2;
A = find(f0==0);
B = find(alpha0==0);

Sx=Cyclic_Spectrum(N,P,L,Np,s0);
Sx_f0 = Sx(A,:);               
Sx_alpha0 = Sx(:,B);          
Sx_G = Sx_f0/max(Sx_alpha0);
MS_eig = max(Sx_G);
%===================参数计算===================%
if (MS_eig > MS_e)                  %FSK
    if(MH_eig > MH_e1)              
        result = 4;                 %4FSK
    else
        result = 3;                 %2FSK
    end
else                                %PSK
    if(MH_eig > MH_e2)              
        result = 1;                 %BPSK
    else
        result = 2;                 %QPSK
    end
end

