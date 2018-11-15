if app.outputflag == 0
    app.outputflag = 1;
    app.Modulation.FontColor = [0, 0, 0];
    app.ModulationText.FontColor = [0, 0, 0];
    
    app.SignalFre.FontColor = [0, 0, 0];
    app.SigFreUnit.FontColor = [0, 0, 0];
    app.SigFreField.Enable = 'on';
    app.SigFreField_2.Enable = 'on';
    app.SigFreField_3.Enable = 'on';
    app.SigFreField_4.Enable = 'on';
    
    app.SymbolRate.FontColor = [0, 0, 0];
    app.SymbolRateUnit.FontColor = [0, 0, 0];
    app.SymbolRateField.Enable = 'on';
    
    app.SpreadingCode.FontColor = [0, 0, 0];
    app.SymbolCycleLabel.FontColor = [0, 0, 0];
    app.SymbolCycleEditField.Enable = 'on';
    
    app.PNCodeText.Enable = 'on';
    
    app.SpreadingCodePlotAxe.Color = [1.0,1.0,1.0];
end