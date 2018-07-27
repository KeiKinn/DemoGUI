function Sx =Cyclic_Spectrum(N,P,L,Np,x)

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
      X(:,k+1) = xx(k*L+1:k*L+Np);    
    end

    a = hamming (Np);               
    XW = diag(a)*X;                

    XF111 = fft(XW);                 
    XF11 = fftshift(XF111);
    XF1 = [XF11(:,P/2+1:P) XF11(:,1:P/2)];
    E = zeros(Np,P);
    for k = -Np/2:Np/2-1
        for m = 0:P-1
            E(k+Np/2+1, m+1) = exp(-1j*2*pi*k*m*L/Np);
        end
    end
    XD = XF1.*E;   
    XD = conj(XD'); 

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

    Sx = zeros(Np+1, 2*N+1);
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
    Sx = Sx./max(max(Sx));
    
    
