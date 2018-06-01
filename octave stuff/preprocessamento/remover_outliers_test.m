function X = remover_outliers_test(X)
  fprintf('Removendo outliers.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/converter_colunas_test.mat', 'X', '-mat');
  end
  
  load('preprocessamento/remover_outliers.mat', 'limites_inferiores', 'limites_superiores', '-mat');
  
  % Captura numero de atributos
  num_colunas = size(X)(2);  
    
  % Calcular os limites de outliers e substituir por faltante
  for indice_coluna = 1:num_colunas
    coluna = X(:,indice_coluna);
        
    % Transformar outliers para dados faltantes
    indices_outliers = [find(coluna < limites_inferiores(indice_coluna)); find(coluna > limites_superiores(indice_coluna))];
    X(indices_outliers, indice_coluna) = -1;
  end
  
  % Salvar outputs
  save('preprocessamento/remover_outliers_test.mat', 'X', 'limites_inferiores', 'limites_superiores', '-mat');
end