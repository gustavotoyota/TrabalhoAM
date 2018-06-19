% Método NWKNN para carregar os K vizinhos

% ENTRADA
%   X = [MxN] amostras de treinamento
%   y = [Mx1] rotulos das amostras de treinamento
%   opcoes = estrutura contendo:
%            k = [1x1] qtde de vizinhos consultados
%         dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente
%     expoente = [1x1] Expoente usado no calculo dos pesos NW

% SAIDA
%   clf = estrutura contendo:
%       mesmos dados de opcoes
%       vizinhos = [MxN+1] rotulos e dados dos vizinhos

function clf = nw_k_vizinhos_treinar(X, y, opcoes)    
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  k = eval("opcoes.k", "5");  
  dist = eval("opcoes.dist", "2");
  expoente = eval("opcoes.expoente", "2");
  
  % Prepara os dados pra previsao
  clf.vizinhos = [y X];
  clf.k = k;  
  clf.dist = dist;
  clf.expoente = expoente;
end