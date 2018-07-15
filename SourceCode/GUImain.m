% -----------------------------
%   This Program is written by

%            JingX

%   ----------------------------
%--- Initializing Parameter ---%
Channel = 4;
DataClipLeng = 250000;
fs = app.srv;
fl = fopen(app.showFilePath.Value, 'r');
try
    counter = 0;
    while(~feof(fl))
        DataTemp = fread(fl, [Channel, DataClipLeng], app.DataFormat)';
        DataTemp = DataTemp(:, 1);
        plotData;
        counter = counter + 1;
        %%%|| - - -  User Functions  - - - ||%%%
        
        %%- - - Estimate  Modulation  - - -%%
        %%%- - - Console Value - - -%%%
        cellen = length(app.ConsoleValue);
        app.ConsoleValue(cellen + 1) = {'  Modulation method identificating ...'};
        app.ConsoleEditField.Value = app.ConsoleValue;
        try
            SigModFlag = rtJudge_z1(DataTemp, fs);
        catch
            SigModFlag = 3;
        end
        ModulationText;
        
        %%- - - Estimate Signal Carrier Frequency & Symbol Rate - - -%%
        %%%- - - Console Value - - -%%%
        cellen = length(app.ConsoleValue);
        app.ConsoleValue(cellen + 1) = {' Signal Carrier Frequency & Symbol Rate Estimating  ...'};
        app.ConsoleEditField.Value = app.ConsoleValue;
        try
            [aSigVal1, aSigVal2, aSigVal3, aSigVal4, aSymVal] =rtEstimate(DataTemp, fs, SigModFlag);
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
catch
    if fl == -1
        NoFileError;
    end
end
