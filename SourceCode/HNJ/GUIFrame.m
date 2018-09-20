clear;
Channel = 1;	% 通道数
DataClipLeng = 10e4;	%  每次读取的数据长度
%fs = app.srv;	%  采样率
fs = 100e3;
%fl = fopen(app.showFilePath.Value, 'r');
FilePath = 'G:\MatTemp\DemoGUI\fskpncode.bin';
fl = fopen(FilePath, 'r');  %  读取文件 仿真用
    counter = 0;
    while(counter < 3)
        try
            DataTemp = fread(fl, [Channel, DataClipLeng], 'double')';  %  注意向量方向
            %DataTemp = DataTemp(:, 1);
        catch
            fclose(fl);
        end
        % --- Users' Function ---% 
      counter = counter + 1;
      [num, cd] = m_sequence(DataTemp, fs,  99);
    end
    
      fclose(fl);