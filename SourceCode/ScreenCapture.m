aDUFPo = UILoc(app);
ScreenSize = get(0,'ScreenSize');
[filename, pathname] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Save Image');
try
if ~isequal(filename,0) || isequal(pathname,0)
    app.sF = fullfile(pathname,filename);
    outputFile = app.sF;
    robo = java.awt.Robot;
    x = aDUFPo(1) + app.TimePlot.Position(1);
    y = ScreenSize(4) - aDUFPo(2) - app.TimePlot.Position(2) - app.TimePlot.Position(4) - 5;
    w = app.TimePlot.Position(3) + 10;
    h = 2.22 * app.TimePlot.Position(4);
    rectangle = java.awt.Rectangle(x, y, w, h);
    image1 = robo.createScreenCapture(rectangle);
    filehandle = java.io.File(outputFile);
    javax.imageio.ImageIO.write(image1,'jpg',filehandle);
end
catch
    x;
end