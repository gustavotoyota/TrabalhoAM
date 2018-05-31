% Calcula a pontuacao da mesma maneira que no desafio
%   Industrial Challenge 2016 at The 15th International Symposium on Intelligent Data Analysis (IDA)
%   Erro1 = Falsos positivos --> peso 10
%   Erro2 = Falsos negativos --> peso 500

% ENTRADA
%      y = [Mx1] rotulos reais
%   pred = [Mx1] rotulos preditos pelo classificador

% SAIDA
%  score = [1x1] pontuacao final

function [score] = pontuacao_desafio(y, pred)

	% Ve o erro da predicao (-1 representa Erro1 e 1 representa Erro2) 
	erro = y-pred;
	% Calcula a pontuacao
	score = 10*sum(erro==-1) + 500*sum(erro==1);

end
