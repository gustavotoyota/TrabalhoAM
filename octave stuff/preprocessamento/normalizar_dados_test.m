function X = normalizar_dados_test(X)
  fprintf('Normalizando dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/preencher_faltantes_test.mat', 'X', '-mat');
  end
  load('preprocessamento/normalizar_dados.mat', 'medias', 'desvios_padroes', '-mat');
  
  % Normalizar dados
  num_linhas = size(X, 1);

  X = (X - medias) ./ desvios_padroes;
  
  % Salvar outputs
  save('preprocessamento/normalizar_dados_test.mat', 'X', 'medias', 'desvios_padroes', '-mat');
end