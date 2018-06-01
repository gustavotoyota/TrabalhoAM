function X = remover_outliers(X)
  fprintf('Removendo outliers.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/converter_colunas.mat', 'X', '-mat');
  end
  
  % Captura numero de atributos
  num_colunas = size(X)(2);  
    
  % Cria os vetores para guardar os limites
  limites_inferiores = zeros(1, num_colunas);
  limites_superiores = zeros(1, num_colunas);
  
  % Calcular os limites de outliers e substituir por faltante
  for indice_coluna = 1:num_colunas
    coluna = X(:,indice_coluna);
    
    % Calcular quartis da coluna    
    q1 = calcular_percentil(coluna(coluna >= 0), 25);
    q3 = calcular_percentil(coluna(coluna >= 0), 75);
    
    % Calcular amplitude inter quartil
    aiq = q3-q1;
    
    % Definir os limites para considerar outliers
    limites_inferiores(indice_coluna) = q1 - 1.5 * aiq;
    limites_superiores(indice_coluna) = q3 + 1.5 * aiq;
    
    % Transformar outliers para dados faltantes
    indices_outliers = [find(coluna < limites_inferiores(indice_coluna)); find(coluna > limites_superiores(indice_coluna))];
    X(indices_outliers, indice_coluna) = -1;
  end
  
  % Salvar outputs
  save('preprocessamento/remover_outliers.mat', 'X', 'limites_inferiores', 'limites_superiores', '-mat');
end
