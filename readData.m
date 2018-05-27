function D = readData(file)
  fl = fopen(file);
  line = fgetl(fl);
  while(line ~= "@data")
    line = fgetl(fl);
  end
  line = fgetl(fl);
  D = str2double(strsplit(line, ','));
  line = fgetl(fl);
  while(line ~= -1)
      D = [D; str2double(strsplit(line, ','))];
      line = fgetl(fl);
  end
end