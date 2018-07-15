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
        TimeTag = (1 : DataClipLeng) + counter * DataClipLeng;
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
        counter = counter + 1;
        %%%|| - - -  User Functions  - - - ||%%%
        SigModFlag = 3;
        
        
        %%- - - Estimate Signal Carrier Frequency & Symbol Rate - - -%%
        [aSigVal1, aSigVal2, aSigVal3, aSigVal4, aSymVal] = Estimate(DataTemp, fs, SigModFlag);
        FreField;
        %%%|| - - -  Stop Flag  - - - ||%%%
        if(app.breakFlag)
            app.breakFlag = 0;
            break;
        end
    end
catch
    if fl == -1
        NoFileError;
    end
end
