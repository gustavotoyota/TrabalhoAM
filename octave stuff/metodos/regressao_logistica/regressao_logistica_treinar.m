% Método Regressao Logistica por gradiente descendente para aprender e otimizar theta

% ENTRADA
%          X = [MxN] amostras de treinamento
%          y = [Mx1] rotulos das amostras de treinamento
%     opcoes = estrutura contendo:
%            alpha = [1x1] taxa de aprendizado
%           lambda = [1x1] parametro de regularizacao
%         max_iter = [1x1] numero de iteracoes

% SAIDA
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo
%          thetas = [Nx1] thetas treinados

function clf = regressao_logistica_treinar(X, y, opcoes)	
  % Le a struct opcoes preenchedo com valores padrao caso esteja vazia
  alpha = eval("opcoes.alpha", "1");
  lambda = eval("opcoes.lambda", "1");
  max_iter = eval("opcoes.max_iter", "1000");
  p = eval("opcoes.p", "0.5");
  
  % Define funcao sigmoid
	sigmoid = @(z) 1 ./ (1 + exp(-z));

	% Inicializa o historico da funcao custo
	J_historico = zeros(max_iter,1);

	% Armazena o numero de amostras
	m = length(y);

  % Gera atributos polinomiais
  X = atributos_polinomiais(X, 2);
  
	% Adiciona coluna de vies  
	X = [ones(size(X)(1),1) X];

	% Inicializa theta randomicamente
	theta = rand(size(X)(2),1);

  % Faz o passo do gradiente descendente max_iter vezes 
	for iter = 1:max_iter      
    % Calcula o novo theta regularizado
	  theta = theta - alpha * ((sum((sigmoid(X * theta) - y) .* X) / m)' + (lambda / m) * theta);
	  theta(1) = theta(1) - alpha * (sum((sigmoid(X * theta) - y) .* X(:,1)) / m);
       	    
    % Armazena o custo regularizado
	  J_historico(iter) = sum(-y .* log(sigmoid(X * theta) + eps) - (1 - y) .* log(1 - sigmoid(X * theta) + eps)) / m + lambda / (2 * m) * sum(theta(2:end) .^ 2);        
        
    % Verifica se convergiu e encerra metodo caso afirmativo
	  if iter > 1 && J_historico(iter-1) == J_historico(iter)
	    J_historico = J_historico(1:end-iter,:);
	    break
	  end
	end
  
  % Monta retorno
  clf.historico = J_historico;
  clf.thetas = theta;
  clf.p = p;
end