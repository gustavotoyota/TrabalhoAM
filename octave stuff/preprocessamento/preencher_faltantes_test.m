function [X] = preencher_faltantes_test(X)
  fprintf('Preenchendo faltantes com a mediana.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/balancear_classes_test.mat', 'X', '-mat');
  end
  load('preprocessamento/preencher_faltantes.mat', 'medianas');
  
  % Preencher faltantes
  num_colunas = size(X, 2);
  
  for indice_coluna = 1 : num_colunas
    coluna = X(:, indice_coluna);
    
    % Preencher faltantes com a mediana
    indices_faltantes = find(coluna < 0);
    X(indices_faltantes, indice_coluna) = medianas(indice_coluna);
  end    
  
  % Salvar outputs
  save('preprocessamento/preencher_faltantes_test.mat', 'X', '-mat');
end  
