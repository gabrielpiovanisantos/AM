function D = readData(file)
  fl = fopen(file);
  D = str2double(strsplit(fgetl(fl), ','));
  
  while((line = fgetl(fl)) ~= -1)
      D = [D; str2double(strsplit(line, ','))];
  end
end