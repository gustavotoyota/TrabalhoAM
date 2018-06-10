% Método SVM 

% ENTRADA
%   X = [MxN] amostras de treinamento
%   y = [Mx1] rotulos das amostras de treinamento
%   opcoes = estrutura contendo:
%     kernel = [1x1] funcao de kernel
%          c = [1x1] custo
%      gamma = [1x1] gamma na funcao de kernel

% SAIDA
%   clf = estrutura contendo:
%     modelo = modelo construido pelo LibSVM

function clf = svm_treinar(X, y, opcoes) 
  
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  kernel = eval("opcoes.kernel", "2");
  c = eval("opcoes.c", "1");
  gamma = eval("opcoes.gamma", "0.01");

  % Treina com os dados e gera um modelo
  clf.modelo = svmtrain(y, X, [sprintf("-t %d -c %f -g %f -q", kernel, c, gamma)]);  
  c,
  
endfunction