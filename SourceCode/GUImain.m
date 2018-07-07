% -----------------------------
%   This Program is written by

%            JingX

%   ----------------------------
%--- Initializing Parameter ---%
Channel = 4;
DataClipLeng = 2500;
fs = app.srv;
fl = fopen(app.showFilePath.Value, 'r');
try
    counter = 0;
    while(~feof(fl))
        DataTemp = fread(fl, [Channel, DataClipLeng], app.DataFormat)';
        DataTemp = DataTemp(:, 1);
        TimeTag = (1 : 2500) + counter * 2500;
        plot(app.TimePlot, TimeTag, DataTemp(: ,1));
        drawnow limitrate;
        
        DataClipStart = 1;
        DataClipEnd = length(DataTemp(: ,1));
        DataClipField = DataClipStart : DataClipEnd ;
        DataClipLength = DataClipEnd - DataClipStart ;
        f1 = fs * (0 : DataClipLength / 2) / length(DataClipField);
        FFTClipDataTemp = fft(DataTemp(DataClipField , 1) / DataClipLength);
        FFTClipData = FFTClipDataTemp(1 : ceil(DataClipLength / 2));
        FFTClipData(2 : end-1) = 2 * FFTClipData(2 : end-1);
        [FFTMax , FFTMaxloc] = max(abs(FFTClipData(10 : end)));
        plot(app.FrePlot, f1 , abs(FFTClipData));
        drawnow limitrate;
        if(app.breakFlag)
            app.breakFlag = 0;
            break;
        end
        counter = counter + 1;
        %%%|| - - -  User Functions  - - - ||%%%
        
    end
catch
    if fl == -1
    NoFileError;
    end
end
