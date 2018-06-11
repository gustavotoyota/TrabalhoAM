% Deixa as classes em uma proporcao 1:1 atraves da remocao da classe majoritaria

% ENTRADA
%   X = [MxN] base de dados
%   y = [Mx1] rotulos das amostras

% SAIDA
%   X = [AxN] base de dados balanceada
%   y = [Ax1] rotulos das amostras balanceadas

function [X, y] = balancear_classes(X, y)
  fprintf('Balanceando classes com undersampling.\n');
  
  % Carregar inputs
  if isempty(X) || isempty(y)
    load('preprocessamento/treino/outputs/remover_dados.mat', 'X', 'y', '-mat');
  endif
  
  % Captura a classe majoritaria
  majoritaria = (sum(y) >= length(y) / 2);
  
  % Captura a diferenca entre classes
  diferenca = abs(length(y) - sum(y) * 2);
  
  % Captura indices da classe majoritaria 
  indices_majoritaria = find(y==majoritaria);
  
  % Ordena os indices aleatoriamente e seleciona quais amostras serao removidas
  amostras_removidas = indices_majoritaria(randperm(length(indices_majoritaria))(1:diferenca));
  
  % Remove as amostras
  X(amostras_removidas,:) = [];
  y(amostras_removidas) = [];
  
  % Salvar outputs
  save('preprocessamento/treino/outputs/balancear_classes.mat', 'X', 'y', '-mat');
endfunction