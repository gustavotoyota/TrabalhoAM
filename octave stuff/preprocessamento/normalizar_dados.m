function X = normalizar_dados(X)
  fprintf('Normalizando dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/preencher_faltantes.mat', 'X', '-mat');
  end
  
  % Normalizar dados
  num_linhas = size(X, 1);
  
  medias = sum(X ./ num_linhas, 1);
  desvios_padroes = sqrt(sum(((X - medias) .^ 2) ./ num_linhas));
  X = (X - medias) ./ desvios_padroes;
  
  % Salvar outputs
  save('preprocessamento/normalizar_dados.mat', 'X', 'medias', 'desvios_padroes', '-mat');
end