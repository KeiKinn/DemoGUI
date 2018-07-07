errorloc = length(app.ConsoleValue);
app.ConsoleValue(errorloc + 1) = {' ERROR: Target file is not exist '};
app.ConsoleValue(errorloc + 2) = {'>>>  '};
app.ConsoleEditField.Value = app.ConsoleValue;

%%- - - Button state change - - -%%
app.StopButton.Enable = 'off';
app.StopButton.Visible = 'off';
app.StartButton.Visible = 'on';
app.StartButton.Enable = 'on';
app.ZoomIn.Enable = 'off';
app.SaveButton.Enable = 'off';