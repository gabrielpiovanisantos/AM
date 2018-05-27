% Le um arquivo do formato .arff e armazena em D.
% O formato .arff possui um identificador @data, que identifica onde
% comeca os dados, sendo que cada linha apos esse identificador equivale a
% uma amostra e cada coluna eh um atributo separado por uma virgula.
function D = readData(file)
  fl = fopen(file);
  line = fgetl(fl);
  % Leio ate encontrar a linha do @data
  while(line ~= "@data")
    line = fgetl(fl);
  end
  % Leio a proxima linha
  line = fgetl(fl);
  % Realizo a atribuicao inicial de D.
  D = str2double(strsplit(line, ','));
  line = fgetl(fl);
  % Leio ate o final do arquivo, separando cada atributo e convertendo para
  % double, onde os atributos faltantes serao convertidos para 'NaN'.
  while(line ~= -1)
      D = [D; str2double(strsplit(line, ','))];
      line = fgetl(fl);
  end
end
