function [X] = preencher_faltantes(X)
  fprintf('Preenchendo faltantes com a mediana.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/remover_dados.mat', 'X', '-mat');
  end
  
  % Preencher faltantes
  num_colunas = size(X, 2);
  
  for indice_coluna = 1 : num_colunas
    coluna = X(:, indice_coluna);
    
    % Calcular mediana
    mediana = calcular_mediana(coluna(coluna >= 0));
    
    % Preencher faltantes com a mediana
    indices_faltantes = find(coluna < 0);
    X(indices_faltantes, indice_coluna) = mediana;
  end    
  
  % Salvar outputs
  save('preprocessamento/preencher_faltantes.mat', 'X', '-mat');
end  