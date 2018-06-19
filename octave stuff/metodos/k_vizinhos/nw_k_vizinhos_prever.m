% Método NWKNN para encontrar os K vizinhos mais proximos de x
%   e utilizando peso NW predizer a classe de x

% ENTRADA
%   x = [AxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%     vizinhos = [MxN+1] rotulos e dados dos vizinhos
%            k = [1x1] qtde de vizinhos consultados
%         dist = [1x1] 1 ou 2 indicando distancia de manhattan ou euclidiana respectivamente
%     expoente = [1x1] Expoente usado no calculo dos pesos NW

% SAIDA
%   pred = [Ax1] predicao 0 ou 1 do rotulo das amostras x

function pred = nw_k_vizinhos_prever(x, clf)  
  % Le a base de vizinhos e os parametros do metodo
  vizinhos = eval("clf.vizinhos", "NaN");
  k = eval("clf.k", "NaN");  
  dist = eval("clf.dist", "NaN");
  expoente = eval("clf.expoente", "NaN");

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
    
    % Corta nos primeiros k vizinhos
    distancia_vizinhos = distancia_vizinhos(1:k);
    indice_vizinhos = indice_vizinhos(1:k);
    
    % Captura os rotulos
	  rotulos_vizinhos = y(indice_vizinhos);
	  
    % Calcula a quantidade de cada rotulo
    qt_pos = sum(rotulos_vizinhos);
    qt_neg = length(rotulos_vizinhos) - qt_pos;
    
    % Calcula os pesos NW
    nw_neg = 1 / ((qt_neg/(min(qt_neg, qt_pos) + eps))^(1 / expoente) + eps);
    nw_pos = 1 / ((qt_pos/(min(qt_neg, qt_pos) + eps))^(1 / expoente) + eps);
    
    % Calcula as pontuacoes de cada classe
    pontuacao_neg = nw_neg * sum(distancia_vizinhos .* (rotulos_vizinhos == 0));
    pontuacao_pos = nw_pos * sum(distancia_vizinhos .* (rotulos_vizinhos == 1));
    
	  % Prediz o rotulo de x(a)
	  [~, pred(amostra)] = max([pontuacao_neg, pontuacao_pos]);
	end
  
  % Arruma os rotulos de x
  pred -= 1;
end