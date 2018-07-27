TimeTag = (1 : DataClipLeng) + counter * DataClipLeng;
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