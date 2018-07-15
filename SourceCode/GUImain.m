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
        
        SigModFlag = Judge_z1(DataTemp, fs);
        ModulationText;
        %        SigModFlag = 3;
        
        %%- - - Estimate Signal Carrier Frequency & Symbol Rate - - -%%
        %%%- - - Console Value - - -%%%
        cellen = length(app.ConsoleValue);
        app.ConsoleValue(cellen + 1) = {' Signal Carrier Frequency & Symbol Rate Estimating  ...'};
        app.ConsoleEditField.Value = app.ConsoleValue;
        
        [aSigVal1, aSigVal2, aSigVal3, aSigVal4, aSymVal] = Estimate(DataTemp, fs, SigModFlag);
        FreField;
        SymRatVal;
        %%- - -HNJ- - -%%
        
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
