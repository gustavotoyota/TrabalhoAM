function [X] = preencher_faltantes(X)
  fprintf('Preenchendo faltantes com a mediana.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/balancear_classes.mat', 'X', '-mat');
  end
  
  % Preencher faltantes
  num_colunas = size(X, 2);
  
  for indice_coluna = 1 : num_colunas
    coluna = X(:, indice_coluna);
    
    % Calcular mediana
    medianas(indice_coluna) = calcular_percentil(coluna(coluna >= 0), 50);
    
    % Preencher faltantes com a mediana
    indices_faltantes = find(coluna < 0);
    X(indices_faltantes, indice_coluna) = medianas(indice_coluna);
  end    
  
  % Salvar outputs
  save('preprocessamento/preencher_faltantes.mat', 'X', 'medianas', '-mat');
end  
