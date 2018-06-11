% Remove as colunas que foram removidas no preprocessamento

% ENTRADA
%                   X = [MxN] base de teste
%   colunas_removidas = [1xB] indices das colunas a serem removidas

% SAIDA
%         X = [MxN-B] base de teste com colunas removidas

function X = remover_dados_teste(X, colunas_removidas)
  fprintf('Removendo dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/teste/outputs/remover_outliers.mat', 'X', '-mat');
  endif
  if isempty(colunas_removidas)
    load('preprocessamento/treino/outputs/remover_dados.mat', 'colunas_removidas', '-mat');  
  endif
    
  % Remover colunas
  fprintf('- Removendo colunas da base de teste\n');
  
  % Remover colunas e limites de outliers
  X(:, colunas_removidas) = [];
  
  % Salvar outputs
  save('preprocessamento/teste/outputs/remover_dados.mat', 'X', '-mat');
endfunction
