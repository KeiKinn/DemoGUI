%% --- Console Update --- %%
cellen = length(app.ConsoleValue);
app.ConsoleValue(cellen + 1) = {' DONE  '};
app.ConsoleValue(cellen + 2) = {'>>>  '};
app.ConsoleEditField.Value = app.ConsoleValue;
%% --- Button State Changes --- %%
app.StartButton.Enable = 'on';
app.StartButton.Visible = 'on';
app.StopButton.Enable = 'off';
app.StopButton.Visible = 'off';
app.ZoomIn.Enable = 'on';
app.SaveButton.Enable = 'on';