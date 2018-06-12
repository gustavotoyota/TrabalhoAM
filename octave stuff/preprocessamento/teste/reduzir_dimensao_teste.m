% Reduzir dimensoes da base de teste na mesmas dimensoes de treinamento

% ENTRADA
%   X = [MxN] base de testes
%   y = [Mx1] rotulos da base de testes
%   U = [MxK] componentes principais para projecao

% SAIDA
%   X = [MxN] base de dados reduzidas

function X = reduzir_dimensao_teste(X, y, U)
  fprintf('Reduzindo dimensao atraves do PCA na base de teste.\n');

  % Carregar inputs
  if isempty(X) || isempty(y) || isempty(U)
    load('preprocessamento/teste/outputs/normalizar_dados.mat', 'X', '-mat');
    load('preprocessamento/teste/outputs/converter_colunas.mat', 'y', '-mat');
    load('preprocessamento/treino/outputs/reduzir_dimensao.mat', 'U', '-mat');
  endif
  
  % Calcula a projecao em 2D e 3D apenas para exibicao  
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
  print(fig, 'preprocessamento/teste/outputs/reduzir_dimensao.jpg', '-djpg');
 
  % Calcula a projecao final com componentes reduzidas
  X = X * U;
  
  % Salvar outputs
  save('preprocessamento/teste/outputs/aplicar_pca.mat', 'X', 'U', '-mat');
endfunction
