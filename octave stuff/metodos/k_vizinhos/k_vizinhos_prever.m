% Método KNN para encontrar os K vizinhos mais proximos de x dado um peso P
%   utilizando Distancia Euclidiana

% ENTRADA
%   x = [AxN] amostras a serem classificadas
%   X = [MxN] amostras de treinamento
%   Y = [Mx1] rotulos das amostras de treinamento
%   K = [1x1] qtde de vizinhos consultados
%   P = [1x1] real variando em [0,1] indicando a porcentagem P que a classe 
%             positiva precisa ocorrer para ser o resultado da classificacao.
%             P = 0.5 indica que a que ocorrer com mais freq sera o resultado

% SAIDA
%   y = [Ax1] predicao 0 ou 1 do rotulo das amostras x

function [vizs, y] = knn_prever(x, X, Y, K, P)

vizs = zeros(length(X),K);

% Inicializa variaveis
y = zeros(size(x,1),1);

% Percorre cada uma das amostras
for a = 1:size(x,1)  
  % Calcula as distancias de x(a) para todas amostras de X
  dist = sqrt(sum(x(a,:)-X,2).^2);

  % Captura o rotulo dos K vizinhos mais proximos
  [proximos, indices] = sort(dist);
  vizinhos = Y(indices(1:K));  
  vizs(a,:) = vizinhos';
  
  % Prediz o rotulo de x(a)
  y(a) = sum(vizinhos)/length(vizinhos) >= P;
end
