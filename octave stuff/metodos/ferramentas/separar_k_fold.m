% Separa a base de dados em K folds aleatorios

% ENTRADA
%   k = [1x1] numero de folds
%   y = [Mx1] rotulos das amostras

% SAIDA
%   train_split = [kx(M/k)*(k-1)] amostras a serem usadas no treinamento
%    test_split = [kx(M/k)]       amostras a serem usadas na validacao

function [train_split, test_split] = separar_k_fold(k, y)
  % Captura os indices dos rotulos
  index_pos = find(y==1);
  index_neg = find(y==0);

  % Ordena aleatoriamente
  index_pos = index_pos(randperm(length(index_pos)));
  index_neg = index_neg(randperm(length(index_neg)));

  % Verifica qual o maximo de cada amostra por fold separando pos e neg
  qt_pos = ceil(length(index_pos)/k);
  qt_neg = ceil(length(index_neg)/k);

  % Cria folds
  folds = zeros(k,qt_pos+qt_neg);
  
  % Preenche com amostras positivas
  for i=1:qt_pos
    fold_index = index_pos((i-1)*k+1:min(k*i,end));
    folds(:,i) = [fold_index; -ones(k-length(fold_index),1)];
  end
  
  % Preenche com amostras negativas
  for i=1:qt_neg
    fold_index = index_neg((i-1)*k+1:min(k*i,end));
    folds(:,i+qt_pos) = [-ones(k-length(fold_index),1); fold_index];
  end

  % Cria splits
  train_split = zeros(k,(qt_pos+qt_neg)*(k-1));
  test_split = folds;
  for i = 1:k
    train_split(i,:) = reshape(folds([1:i-1,i+1:end],:),1,[]);
  end
end