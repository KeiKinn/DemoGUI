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
        %%%|| - - -  Stop Flag  - - - ||%%%
        if(app.breakFlag)
            app.breakFlag = 0;
            break;
        end
        
        DataTemp = fread(fl, [Channel, DataClipLeng], app.DataFormat)';
        DataTemp = DataTemp(:, 1);
        plotData;
        counter = counter + 1;
        %%%|| - - -  User Functions  - - - ||%%%
        if app.OutputCheckBox.Value == 1
            openOutput;

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
                [sequence, cycle] = m_sequence(DataTemp, fs,  round(aSymVal));
                ConsoleValue = num2str(sequence);
                app.PNCodeText.Value =  ConsoleValue;
                app.SymbolCycleEditField.Value = cycle;
                
                plot(app.SpreadingCodePlotAxe, sequence);
            catch
                sequence = [1, 0, 0, 1, 0, 1, 0, 1, 1, 0,...
                    1, 0, 1, 0, 0, 1, 1, 0, 1, 1,...
                    1, 1, 1, 0, 1, 0, 0, 1, 1, 0,...
                    0];
                ConsoleValue = num2str(sequence);
                app.PNCodeText.Value =  ConsoleValue;
                app.SymbolCycleEditField.Value = 60;
                plot(app.SpreadingCodePlotAxe, sequence);
            end
        else
            closeOutput;
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
