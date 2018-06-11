% Reduzir dimensoes da base de dados utilizando PCA

% ENTRADA
%   X = [MxN] base de dados
%   y = [Mx1] rotulo das amostras

% SAIDA
%   X = [MxN] base de dados reduzidas
%   U = [MxK] componentes principais para projecao

function [X, U] = reduzir_dimensao(X, y)
  fprintf('Reduzindo dimensao atraves do PCA.\n');

  % Carregar inputs
  if isempty(X)
    load('preprocessamento/treino/outputs/normalizar_dados.mat', 'X', '-mat');
  endif
  if isempty(y)
    load('preprocessamento/treino/outputs/balancear_classes.mat', 'y', '-mat');
  endif

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
  endwhile
  
  % Calcula a projecao em 1D, 2D e 3D apenas para exibicao  
  proj_2D = X * U(:, 1:2);
  proj_3D = X * U(:, 1:3);
  
  % Gera e salva os graficos de ponto  
  fig = figure();
  set(fig, 'visible', 'off');
  subplot(2, 1, 1)  
  scatter(proj_2D(:,1), proj_2D(:,2), 5, y);
  title('Base com 2D');
  subplot(2, 1, 2)
  scatter3(proj_3D(:,1), proj_3D(:,2), proj_3D(:,3), 5, y);
  title('Base com 3D');
  print(fig, 'preprocessamento/treino/outputs/reduzir_dimensao.jpg', '-djpg');
  
  % Corta apenas as componentes finais
  U = U(:, 1:K);
  
  % Calcula a projecao final com componentes reduzidas
  X = X * U;
  
  % Salvar outputs
  save('preprocessamento/treino/outputs/reduzir_dimensao.mat', 'X', 'U', '-mat');
endfunction