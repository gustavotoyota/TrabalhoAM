% Método SVM para unica classe

% ENTRADA
%   X = [MxN] amostras de treinamento
%   y = [Mx1] rotulos das amostras de treinamento
%   opcoes = estrutura contendo:
%     classe = [1x1] rotulo indicando a classe que sera utilizada
%     kernel = [1x1] funcao de kernel
%         nu = [1x1] numero de vetores de suporte
%      gamma = [1x1] gamma na funcao de kernel

% SAIDA
%   clf = estrutura contendo:
%     modelo = modelo construido pelo LibSVM

function clf = occ_svm_treinar(X, y, opcoes)     
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  classe = eval("opcoes.classe", "1");
  kernel = eval("opcoes.kernel", "2");
  nu = eval("opcoes.nu", "0.5");
  gamma = eval("opcoes.gamma", "0.01");

  % Captura os indices da classe desejada
  indices_classe = find(y == classe);
  
  % Separa a classe desejada
  X = X(indices_classe, :);
  y = y(indices_classe, :);
  
  % Treina com os dados e gera um modelo
  clf.modelo = svmtrain(y, X, [sprintf("-s 2 -t %d -n %f -g %f -q", kernel, nu, gamma)]);

endfunction