% Método Regressao Logistica por gradiente descendente para aprender e otimizar theta

% ENTRADA
%          X = [MxN] amostras de treinamento
%          Y = [Mx1] rotulos das amostras de treinamento
%      alpha = [1x1] taxa de aprendizado
%     lambda = [1x1] parametro de regularizacao
%   max_iter = [1x1] numero de iteracoes

% SAIDA
%   theta = [Nx1] thetas treinados

function [J, theta] = regressao_logistica_treinar(X, y, alpha, lambda, max_iter)
	% Define funcao sigmoid
	sigmoid = @(z) 1 ./ (1 + exp(-z));

	% Inicializa o historico da funcao custo
	J = zeros(max_iter,1);

	% Armazena o numero de amostras
	m = length(y);

	% Adiciona coluna de vies
	X = [ones(size(X)(1),1) X];

	% Inicializa theta randomicamente
	theta = rand(size(X)(2),1);

	for iter = 1:max_iter  
	  theta = theta - alpha*((sum((sigmoid(X*theta)-y).*X)/m)' + (lambda/m)*theta);
	  theta(1) = theta(1) - alpha*(sum((sigmoid(X*theta)-y).*X(:,1))/m);
       	    
	  J(iter) = sum(-y.*log(sigmoid(X*theta)+1e-15)-(1-y).*log(1-sigmoid(X*theta)+1e-15))/m + lambda/(2*m) * sum(theta(2:end).^2);	     
    fprintf("%f\n", J(iter));
    
	  if iter > 1 && J(iter-1) == J(iter)
	    J = J(1:end-iter,:);
	    break
	  end
	end
end
