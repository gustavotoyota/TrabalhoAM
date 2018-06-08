% Método KNN para carregar os K vizinhos

% ENTRADA
%   X = [MxN] amostras de treinamento
%   y = [Mx1] rotulos das amostras de treinamento
%   opcoes = estrutura contendo:
%       k = [1x1] qtde de vizinhos consultados
%       p = [1x1] real variando em [0,1] indicando a porcentagem P que a classe 
%             positiva precisa ocorrer para ser o resultado da classificacao.
%             P = 0.5 indica que a que ocorrer com mais freq sera o resultado
%    dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente

% SAIDA
%   clf = estrutura contendo:
%       mesmos dados de opcoes
%       vizinhos = [MxN+1] rotulos e dados dos vizinhos

function clf = k_vizinhos_treinar(X, y, opcoes)
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  k = eval("opcoes.k", "5");
  p = eval("opcoes.p", "0.5");
  dist = eval("opcoes.dist", "2");
  
  % Prepara os dados pra previsao
  clf.vizinhos = [y X];
  clf.k = k;
  clf.p = p;
  clf.dist = dist;
end