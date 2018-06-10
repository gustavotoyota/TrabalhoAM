% Método One Class Classification KNN para carregar os K vizinhos de uma unica classe

% ENTRADA
%   X = [MxN] amostras de treinamento
%   y = [Mx1] rotulos das amostras de treinamento
%   opcoes = estrutura contendo:
%      classe = [1x1] rotulo indicando a classe que sera utilizada
%       delta = [1x1] limite de distancia utilizado para a predicao
%        dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente

% SAIDA
%   clf = estrutura contendo:
%       mesmos dados de opcoes
%       vizinhos = [CxN] dados dos vizinhos de unica classe

function clf = occ_k_vizinhos_treinar(X, y, opcoes)
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  classe = eval("opcoes.classe", "1");
  delta = eval("opcoes.delta", "1");
  dist = eval("opcoes.dist", "2");
  
  % Captura os indices da classe desejada
  indices_classe = find(y == classe);
  
  % Prepara os dados pra previsao
  clf.vizinhos = X(indices_classe,:);
  clf.classe = classe;
  clf.delta = delta;
  clf.dist = dist;
end