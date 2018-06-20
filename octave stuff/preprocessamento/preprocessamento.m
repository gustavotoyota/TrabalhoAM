% Realiza o preprocessamento da base de dados de treinamento
%    e prepara a base de dados de teste

% ENTRADA
%   arquivo_treino = nome do arquivo com a base de dados de treino
%    arquivo_teste = nome do arquivo com a base de dados de teste

% SAIDA
%         X = [MxN] base de dados preprocessada
%         y = [Mx1] rotulos da base preprocessada
%   X_teste = [AxN] testes preparados
%   y_teste = [Ax1] rotulos dos testes preparados

function [X, y, X_teste, y_teste] = preprocessamento(arquivo_treino, arquivo_teste)
  % Adiciona os caminhos dos arquivos
  addpath('preprocessamento/treino');
  addpath('preprocessamento/teste');
  
  % Criar pastas de output
  mkdir('preprocessamento/treino/outputs');
  mkdir('preprocessamento/teste/outputs');

  % Realiza o preprocessamento sobre a base de treino
  %colunas_texto = carregar_colunas(arquivo_treino, 'treino');
  %[X, y] = converter_colunas(eval('colunas_texto', '[]'), 'treino');  
  
  load('preprocessamento/treino/outputs/converter_colunas.mat', 'X', 'y', '-mat');
  
  %[X, limites_inferiores, limites_superiores] = remover_outliers_treino(eval('X', '[]'));
  [X, y, colunas_removidas] = remover_dados_treino(eval('X', '[]'), eval('y', '[]'), 100, 100);  
  %[X, y] = balancear_classes_treino(eval('X','[]'), eval('y','[]'));
  [X, medianas] = preencher_faltantes_treino(eval('X', '[]'));
  [X, medias, desvios_padroes] = normalizar_dados_treino(eval('X', '[]'));
  [X, U] = reduzir_dimensao_treino(eval('X', '[]'), eval('y', '[]'));
  
  X_treino = X;
  y_treino = y;
  
  % Prepara a base de testes
  %colunas_texto = carregar_colunas(arquivo_teste, 'teste');
  %[X_teste, y_teste] = converter_colunas(eval('colunas_texto', '[]'), 'teste');
  
  load('preprocessamento/teste/outputs/converter_colunas.mat', 'X', 'y', '-mat');
  X_teste = X;
  y_teste = y;
  
  %X_teste = remover_outliers_teste(eval('X_teste', '[]'), eval('limites_inferiores', '[]'), eval('limites_superiores', '[]'));
  X_teste = remover_dados_teste(eval('X_teste', '[]'), eval('colunas_removidas', '[]'));
  X_teste = preencher_faltantes_teste(eval('X_teste', '[]'), eval('medianas', '[]'));
  X_teste = normalizar_dados_teste(eval('X_teste', '[]'), eval('medias', '[]'), eval('desvios_padroes', '[]'));
  X_teste = reduzir_dimensao_teste(eval('X_teste', '[]'), eval('y_teste', '[]'), eval('U', '[]'));   
  
  % Salva as bases finais
  X = X_treino;
  y = y_treino;
  
  save('preprocessamento/preprocessamento.mat', 'X', 'y', 'X_teste', 'y_teste', '-mat');
end
