% Remove outliers utilizando os limites superiores e inferiores

% ENTRADA
%                    X = [MxN] base de dados
%   limites_inferiores = [1xN] limites inferiores para considerar um outlier
%   limites_superiores = [1xN] limites superiores para considerar um outlier

% SAIDA
%   X = [MxN] base de dados com -1 no lugar de outliers

function X = remover_outliers_teste(X, limites_inferiores, limites_superiores)
  fprintf('Removendo outliers da base de teste.\n');
  
  % Carregar inputs
  if isempty(X) || isempty(limites_inferiores) || isempty(limites_superiores) 
    load('preprocessamento/teste/outputs/converter_colunas.mat', 'X', '-mat');
    load('preprocessamento/treino/outputs/remover_outliers.mat', 'limites_inferiores', 'limites_superiores', '-mat');
  endif
  
  % Captura numero de atributos
  num_colunas = size(X,2);
    
  % Calcular os limites de outliers e substituir por faltante
  for indice_coluna = 1:num_colunas
    coluna = X(:,indice_coluna);
        
    % Transformar outliers para dados faltantes
    indices_outliers = [find(coluna < limites_inferiores(indice_coluna)); find(coluna > limites_superiores(indice_coluna))];
    X(indices_outliers, indice_coluna) = -1;
  endfor
  
  % Salvar outputs
  save('preprocessamento/teste/outputs/remover_outliers.mat', 'X', '-mat');
endfunction