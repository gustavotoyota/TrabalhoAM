% Calcula diversas medidas de avaliacao sobre a predicao

% ENTRADA
%      y = [Mx1] rotulos reais
%   pred = [Mx1] rotulos preditos pelo classificador

% SAIDA
%   acc = [1x1] acuracia
%  prec = [1x1] precisao media
%   rec = [1x1] revocacao media
%    f1 = [1x1] f-medida

function [acc, prec, rec, f1] = pontuacao_medidas_avaliacao(y, pred)

	% Calcula a matriz de confusao
	tn = sum((pred==0)&(y==0));
	fn = sum((pred==0)&(y==1));
	fp = sum((pred==1)&(y==0));
	tp = sum((pred==1)&(y==1));

	% Calcula as medidas de avaliacao
	acc = ((tp + tn)/(tp + tn + fp + fn))*100;
	prec = tp/(tp+fp);
	rec = tp/(tp+fn);
	f1 = 2*((prec*rec)/(prec+rec));

end