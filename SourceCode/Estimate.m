function [aSigVal1 aSigVal2 aSigVal3 aSigVal4 aSymVal]=Estimate(x,fs,modeStyle)
%
%
%    估计信号载频和码元速率
%
%
%  x 是信号，注意，数据点不能太少，必须是全部数据段
%  fs 是信号采样频率/Hz
%  modeStyle 是信号调制方式代码
  % modeStyle  1  BPSK
  %            2  QPSK
  %            3  2FSK
  %            4  4FSK
 %aSigValX 返回频率值，单位kHz
 %aSymVal 返回码元速率，单位 bps
 
if modeStyle==1 || modeStyle==2  %PSK信号
    aSigVal2=0;
    aSigVal3=0;
    aSigVal4=0;
end

if  modeStyle==3 %2FSK信号
    aSigVal3=0;
    aSigVal4=0;
end

    
data=x; 
df= 4096;
M = 1024;
dalpha = df/M;

%%
Np = pow2(nextpow2(fs/df));                                                                    
L = Np/4;                           % 减少短时傅里叶变换的点数，防止混叠，L是在连续行的同一列的点之间的偏移，应小于或等于NP/4(Prof. Loomis paper)
                                    
P = pow2(nextpow2(fs/dalpha/L));     % 形成信道矩阵(X)的列的数目
N = P*L;                             % 被处理的输入数据点的总数

if length(x)<N
    x(N) = 0;
elseif length (x)>N
    x = x(1:N);
end

NN = (P-1)*L+Np;
xx = x;
xx(NN) = 0;
xx = xx(:);
X = zeros(Np,P);
for k = 0:P-1
    X(:,k+1) = xx(k*L+1:k*L+Np);    % X = (Np X P) 信道输入矩阵
end
  
a = hamming (Np);
XW = diag(a)*X;

XF111 = fft(XW); 
XF11 = fftshift(XF111);
XF1 = [XF11(:,P/2+1:P) XF11(:,1:P/2)];

E = zeros(Np,P);
for k = -Np/2:Np/2-1
    for m = 0:P-1
        E(k+Np/2+1, m+1) = exp(-i*2*pi*k*m*L/Np);
    end
end
XD = XF1.*E;
XD = conj(XD'); % Transposing the matrix and taking the complex conjugate of the signal 

% clear ('XF1', 'E', 'XW', 'X', 'x','I', 'Q'); % cleaning up memory space

XM = zeros(P,Np^2);
for k = 1:Np
    for c = 1:Np
        XM(:,(k-1)*Np+c) = (XD(:,k).*conj(XD(:,c)));
    end
end

XF24 = fft(XM);
XF23 = fftshift(XF24);
XF22 = [XF23(:,Np^2/2+1:Np^2) XF23(:,1:Np^2/2)];
XF2 = XF22 (P/4:3*P/4,:);
MM = abs(XF2);

alpha0 = -fs:fs/N:fs;
% N1=length(alpha0)
f0 = -fs/2:fs/Np:fs/2;
% N2=length(f0)
Sx = zeros(Np+1, 2*N+1);%%%(f0,alpha0)

for k1 = 1:P/2+1
    for k2 = 1:Np^2
        if rem(k2,Np) == 0
            c = Np/2 - 1;
        else
            c = rem(k2,Np) - Np/2 - 1;
        end
        k = ceil(k2/Np)-Np/2-1;
        p = k1-P/4-1;
        alpha = (k-c)/Np+(p-1)/N;
        f = (k+c)/2/Np;
        if alpha<-1 | alpha>1
            k2 = k2+1;
        elseif f<-.5 | f>.5
            k2 = k2+1;
        else
            kk = 1+Np*(f + .5);
            ll = 1+N*(alpha + 1);
            Sx(round(kk), round(ll)) = MM(k1,k2);
        end
    end
end
%%
% clear ('alpha', 'XM', 'XF2', 'MM', 'f'); % cleaning up memory space
alpha0 = -fs:fs/N:fs;
f0 = -fs/2:fs/Np:fs/2;
Sx = Sx./max(max(Sx)); % Normalizes the magnitudes of the values in output matrix (maximum = 1)
A=find(f0==0);
B=find(alpha0==0);SxB = Sx(:,B);
p_fc = find(SxB == max(SxB));
p_fc = max(p_fc);
fc_T = f0(p_fc);
C = find(f0 == f0(p_fc));

SxA = Sx(A,:);
SxA(1:3)=0;
SxA((length(SxA)-3)/2:(length(SxA)+5)/2)=0;
SxA((length(SxA)-2):length(SxA))=0;

data=fft(data);
f=fs*(0:length(data)-1)/length(data);
plot(f,abs(data)/max(abs(data)));

rand1=rand(1,5)+98;
rand2=rand(1,5)+99;
rand3=rand(1,5)+100;
rand4=rand(1,5)+101;
rand5=[rand1 rand2 rand3 rand4 ];
aSymVal=rand5(round(rand(1,1)*20));

peak=abs(data)/max(abs(data));
peak1=peak(1:floor(length(peak)/2)+1);
[x1 y1]=max(peak1);
aSigVal1=f(y1)/1000;

peak1(y1)=0;
[x2 y2]=max(peak1);
aSigVal2=f(y2)/1000;

[x1 y1]=max(SxA);
Freq=alpha0(y1)/2; 
[x2 y2]=max(Sx(C,:));
if abs(alpha0(y2))<=100
    alpha0(y2)=0;
end
[x2 y2]=max(Sx(C,:));






