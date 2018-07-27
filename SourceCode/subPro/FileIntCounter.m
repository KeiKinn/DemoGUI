function FileIntCounter = FileCounter(filepath, DataClipLen)
FileInfo = dir(filepath);
DataLen = FileInfo.bytes / 8;
FileIntCounter = floor(DataLen / DataClipLen);
end