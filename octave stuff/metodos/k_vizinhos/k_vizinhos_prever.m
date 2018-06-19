% Método KNN para encontrar os K vizinhos mais proximos de x
%    e dado um peso p predizer a classe de x

% ENTRADA
%   x = [AxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%     vizinhos = [MxN+1] rotulos e dados dos vizinhos
%     k = [1x1] qtde de vizinhos consultados
%     p = [1x1] real variando em [0,1] indicando a porcentagem P que a classe 
%             positiva precisa ocorrer para ser o resultado da classificacao.
%             P = 0.5 indica que a que ocorrer com mais freq sera o resultado
%    dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente

% SAIDA
%   pred = [Ax1] predicao 0 ou 1 do rotulo das amostras x

function pred = k_vizinhos_prever(x, clf)  
  % Le a base de vizinhos e os parametros do metodo
  vizinhos = eval("clf.vizinhos", "NaN");
  k = eval("clf.k", "NaN");
  p = eval("clf.p", "NaN");
  dist = eval("clf.dist", "NaN");

  % Separa X e y
  y = vizinhos(:,1);
  X = vizinhos(:,2:end);
  
	% Inicializa variaveis
	pred = zeros(size(x,1),1);

	% Percorre cada uma das amostras
	for amostra = 1:size(x,1)
	  % Calcula as distancias de x(a) para todas amostras de X de acordo com a medida adotada
    if (dist == 1)
      % Manhattan
      distancias = sum(abs(x(amostra,:) - X), 2);
    else
      % Euclidiana
	    distancias = sqrt(sum(x(amostra,:) - X, 2) .^ 2);
    end  

	  % Captura o rotulo dos K vizinhos mais proximos
	  [distancia_vizinhos, indice_vizinhos] = sort(distancias);
	  rotulos_vizinhos = y(indice_vizinhos(1:k));
	  
	  % Prediz o rotulo de x(a)
	  pred(amostra) = sum(rotulos_vizinhos)/length(rotulos_vizinhos) >= p;
	end
end