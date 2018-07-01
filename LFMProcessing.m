% -----------------------------
%   This Program is written by

%            JingX

%   ----------------------------
%--- Initializing Parameter ---%
Channel = 4;
DataClipLeng = 2500;
fs = app.srv;
app.showFilePath.Value
try
    fl = fopen(app.showFilePath.Value, 'r');
    counter = 0;
    while(~feof(fl))
        try
            DataTemp = fread(fl, [Channel, DataClipLeng], app.DataFormat)';
            DataTemp = DataTemp(:, 1);
        catch
            fclose(fl);
        end
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
    fclose(fl);
catch ErrorInfo %捕获到的错误是一个MException对象
    ErrorLogName =[ErrorInfo.stack.name, '_ErrorLog.txt'];
    TimeStamp = datestr(now , 'yyyy/mm/dd HH:MM:SS');
    fileID = fopen(ErrorLogName, 'w+');
    fclose(fileID);
    diary(ErrorLogName);
    disp(ErrorInfo);
    disp(ErrorInfo.cause);
    disp(ErrorInfo.stack);
    diary off;
    ErrorContent = loadErrorContent(ErrorLogName);
    RegExpression = '<.*?>';    % Find every char between <>
    ReplaceContent = '';
    modifyErrorContent = regexprep(ErrorContent, RegExpression, ReplaceContent);
    modifyErrorContent = strrep(modifyErrorContent, '\', '\\');
    EC = cellstr(modifyErrorContent)
    ErrorCt = {};
    for col_i = 1 : length(modifyErrorContent)
        ErrorContentTemp =strcat(modifyErrorContent(col_i));
        ErrorContentTemp = cellstr(ErrorContentTemp)
    end
    app.TextArea.Value = EC;
end
