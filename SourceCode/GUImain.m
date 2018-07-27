% -----------------------------
%   This Program is written by

%            JingX

%   ----------------------------
%--- Initializing Parameter ---%
Channel = 1;
DataClipLeng = 10e4;
fs = app.srv;
fl = fopen(app.showFilePath.Value, 'r');
try
    FileCounter = FileIntCounter(app.showFilePath.Value, DataClipLeng);
    counter = 0;
    for counter_i = 1 : FileCounter
        DataTemp = fread(fl, [Channel, DataClipLeng], app.DataFormat)';
        DataTemp = DataTemp(:, 1);
        plotData;
        counter = counter + 1;
        
        %%%|| - - -  User Functions  - - - ||%%%
        
        %%- - - Estimate  Modulation  - - -%%
        %%%- - - Console Value - - -%%%
        cellen = length(app.ConsoleValue);
        app.ConsoleValue(cellen + 1) = {' Modulation method identificating'};
        app.ConsoleEditField.Value = app.ConsoleValue;
        try
            SigModFlag = Judge_z1(DataTemp, fs);
        catch
            SigModFlag = 3;
        end
        ModulationText;
        
        %%- - - Estimate Signal Carrier Frequency & Symbol Rate - - -%%
        %%%- - - Console Value - - -%%%
        cellen = length(app.ConsoleValue);
        app.ConsoleValue(cellen + 1) = {' Signal Carrier Frequency & Symbol Rate Estimating'};
        app.ConsoleEditField.Value = app.ConsoleValue;
        try
            [aSigVal1, aSigVal2, aSigVal3, aSigVal4, aSymVal] =Estimate(DataTemp, fs, SigModFlag);
        catch
            aSigVal1 = 9;
            aSigVal2 = 10;
            aSymVal = 100;
        end
        FreField;
        SymRatVal;
        %%- - -HNJ- - -%%
        try
            ji = p;
        catch
            num = [1, 0, 0, 1, 0, 1, 0, 1, 1, 0,...
                1, 0, 1, 0, 0, 1, 1, 0, 1, 1,...
                1, 1, 1, 0, 1, 0, 0, 1, 1, 0,...
                0];
            ConsoleValue = num2str(num);
            app.PNCodeText.Value =  ConsoleValue;
            app.SymbolCycleEditField.Value = 63;
        end
        %%%|| - - -  Stop Flag  - - - ||%%%
        if(app.breakFlag)
            app.breakFlag = 0;
            break;
        end
    end
    fclose(fl);
    ProOver;
catch
    if fl == -1
        ProOver;
        NoFileError;
    end
end
