% Método Once Class Classification KNN para predizer se x pertence a classe ou nao
%   utilizando Distancia Euclidiana

% ENTRADA
%   x = [AxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%     vizinhos = [CxN] dados dos vizinhos
%       classe = [1x1] rotulo indicando a classe que sera utilizada
%        delta = [1x1] limite de distancia utilizado para a predicao
%         dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente
% SAIDA
%   pred = [Ax1] predicao 0 ou 1 do rotulo das amostras x

function pred = occ_k_vizinhos_prever(x, clf)
  % Le a base de vizinhos e os parametros do metodo
  X = eval("clf.vizinhos", "NaN");
  classe = eval("clf.classe", "NaN");
  delta = eval("clf.delta", "NaN");
  dist = eval("clf.dist", "NaN");  
  
	% Inicializa variaveis
	pred = zeros(size(x,1),1);
  vizinhos_treino = -ones(size(X,1),1);

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

	  % Captura o vizinho mais proximo e a distancia
	  [proximos, indices] = sort(distancias);
    distancia_teste = proximos(1);
	  vizinho_teste = indices(1);
    
    % Verifica se o vizinho mais proximo ja foi calculado
    if vizinhos_treino(vizinho_teste) != -1
      distancia_treino = vizinhos_treino(vizinho_teste);
    else
      % Caso contrario
      % Calcula as distancias de vizinho_teste para todas amostras de X de acordo com a medida adotada      
      if (dist == 1)
        % Manhattan
        distancias = sum(abs(X(vizinho_teste,:) - X), 2);
      else
        % Euclidiana
	      distancias = sqrt(sum(X(vizinho_teste,:) - X, 2) .^ 2);
      end      
      
      % Captura o vizinho mais proximo e a distancia ignorando ele proprio
      [proximos, indices] = sort(distancias);
      distancia_treino = proximos(2);      
      
      % Armazena a distancia para futuras iteracoes
	    vizinhos_treino(vizinho_teste) = distancia_treino;
    end
	  
	  % Prediz o rotulo de x(a)    
	  pred(amostra) = (distancia_teste/distancia_treino) <= delta;
	end
end