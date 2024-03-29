% Método Regressao Logistica por gradiente descendente para predizer amostras

% ENTRADA
%     x = [MxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo
%          thetas = [Nx1] thetas treinados         

% SAIDA
%   pred = [Mx1] previsao das amostras

function pred = regressao_logistica_prever(x, clf)	    
  % Define funcao sigmoid
	sigmoid = @(z) 1 ./ (1 + exp(-z));
  
  % Le os thetas
  theta = eval("clf.thetas", "NaN");   
  
  % Gera atributos polinomiais
  %x = atributos_polinomiais(x, 2);
    
  % Calcula as predicoes  
  pred = round(sigmoid([ones(size(x)(1),1) x] * theta));
end