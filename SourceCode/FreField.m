if SigModFlag < 3
    app.SigFreField.Position = [1182,611,74,31];
    app.SigFreField.Value = aSigVal1;
    app.SigFreField_2.Visible = 'off';
    app.SigFreField_3.Visible = 'off';
    app.SigFreField_4.Visible = 'off';
end

if SigModFlag == 3
    app.SigFreField.Position =   [1182,632,74,31];
    app.SigFreField_2.Position = [1182,590,74,31];
    app.SigFreField.Value = aSigVal1;
    app.SigFreField_2.Value = aSigVal2;
    app.SigFreField_2.Visible = 'on';
    app.SigFreField_3.Visible = 'off';
    app.SigFreField_4.Visible = 'off';
end

if SigModFlag == 4
    app.SigFreField.Position   =   [1182,656,74,21];
    app.SigFreField_2.Position = [1182,630,74,21];
    app.SigFreField_3.Position = [1182,604,74,21];
    app.SigFreField_4.Position = [1182,578,74,21];
    
    app.SigFreField.Value = aSigVal1;
    app.SigFreField_2.Value = aSigVal2;
    app.SigFreField_3.Value = aSigVal3;
    app.SigFreField_4.Value = aSigVal4;
    app.SigFreField_2.Visible = 'on';
    app.SigFreField_3.Visible = 'on';
    app.SigFreField_4.Visible = 'on';
end