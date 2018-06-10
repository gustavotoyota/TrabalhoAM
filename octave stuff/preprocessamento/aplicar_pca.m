function X = aplicar_pca(X, y)
  fprintf('Aplicando PCA.\n');

  % Carregar inputs
  if isempty(X)
    load('preprocessamento/normalizar_dados.mat', 'X', '-mat');
  end  
  if isempty(y)
    load('preprocessamento/balancear_classes.mat', 'X', '-mat');
  end

  % Calcula a matriz de covariancia
  matriz_covariancia = (1 / length(y)) * X' * X;
  
  % Calcula as componentes principais e autovalores
  [U, S, ~] = svd(matriz_covariancia);
    
  % Captura apenas a diagonal da matriz S
  S = diag(S); 
  
  % Define o numero de componentes K que mantenha 90% de variancia
  K = 1;  
  while (sum(S(1:K))/sum(S)) < 0.9
    K += 1;
  end
  
  % Calcula a projecao em 1D, 2D e 3D apenas para exibicao
  proj_1D = X * U(:, 1:1);
  proj_2D = X * U(:, 1:2);
  proj_3D = X * U(:, 1:3);
  
  % Exibe os graficos de ponto
  subplot(3, 1, 1)
  scatter(proj_1D(:,1), zeros(size(proj_1D)(1),1), 5, y);
  subplot(3, 1, 2)
  scatter(proj_2D(:,1), proj_2D(:,2), 5, y);
  subplot(3, 1, 3)
  scatter3(proj_3D(:,1), proj_3D(:,2), proj_3D(:,3), 5, y);
  
  % Calcula a projecao final com componentes reduzidas
  X = X * U(:, 1:2);
  
  % Salvar outputs
  save('preprocessamento/aplicar_pca.mat', 'X', 'y', '-mat');

endfunction