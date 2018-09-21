function[mseq,cycle_data]=m_sequence(signal_seq, fs63,fd63) 

fd63 = 10 * fd63;
cycle_data=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ͨ�˲�
[b,a]=ellip(4,0.1,40,[10000]*2/100000);%���IIR-LPF  
sf=filter(b,a,signal_seq); %�ź�ͨ�����˲���
% figure(8);
% backColor=[0.24 0.24 0.24];
% set(gcf,'color',backColor);
% set(gcf, 'InvertHardCopy', 'off');
% t2=1:107500;
% plot(t2,sf,'b'); %�����ź�ͨ����BPF�Ĳ���
% xlabel('t','Color','w'); ylabel('����','Color','w');title('ͨ��BPF��Ĳ���','Color','w'); 
% axis([0 107500 -20 20]);grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%�źŲ���
sf_power_spectrum=fft(sf);
signal_1=abs(sf_power_spectrum);
sf_2power_spectrum=fft(signal_1);
signal=abs(sf_2power_spectrum);

% cycle_data=mapminmax(signal);
cycle_data= signal;
% figure(9);
% % backColor=[0.24 0.24 0.24];
% % set(gcf,'color',backColor);
% % set(gcf, 'InvertHardCopy', 'off');
% plot(t2,cycle_data,'b');
% title('PN Cycle','FontSize',13');
% xlabel('chips','FontSize',13);ylabel('Amplitude','FontSize',13);
% axis([-inf inf -1 -0.9]);
% grid on;
fbconnection=[1 0 0 0 0 1];
n=length(fbconnection); 
N=2^n-1;
cycle_data = N;
register=[zeros(1,n-1) 1];  %��λ�Ĵ����ĳ�ʼ״̬ 
mseq(1)=register(n);        %m���еĵ�һ�������Ԫ 
for i=2:N      
newregister(1)=mod(sum(fbconnection.*register),2);     
for j=2:n          
newregister(j)=register(j-1);     
end;      
register=newregister;     
mseq(i)=register(n); 
end


% fs63=126000;%%������
% fd63=1000;%%��Ԫ����
L63= round(fs63/fd63);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ֶβ���������ؾ���
sample_signal63=zeros(L63,L63);
for i=1:L63
   sample_signali63=signal_seq((i-1)*L63+1:1:i*L63);
   sample_signal63(i,:)=sample_signali63;
end
signal63=(sample_signal63'*sample_signal63)/L63;
[V63,D63]=eig(signal63);


V363=V63(:,L63);
V463=V363(round(L63/2 + 1) : end);
for n1=1:1:L63/2 - 1
    for n2=1:1:L63/2 - 1
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
                m1=m1+L63/2;           
            end
            if m2==0
                m2=m2+L63/2 ;           
            end
    zn163(n)=V463(m1);
    zn263(n)=V463(m2);
        end
    Zn1263 =zn163.* zn263;
    Zn63=V463'.*Zn1263;
    R1263(n1,n2)=mean(Zn63); 
    end
end







