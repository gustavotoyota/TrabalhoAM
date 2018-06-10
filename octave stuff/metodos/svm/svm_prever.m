% Método SVM 

% ENTRADA
%     x = [MxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%     modelo = modelo construido pelo LibSVM

% SAIDA
%   pred = [Mx1] previsao das amostras

function pred = svm_prever(x, clf) 
  
  % Le o modelo
  modelo = eval("clf.modelo", "NaN");  

  % Realiza a predicao
  pred = svmpredict(zeros(size(x,1),1), x, modelo, ["-q"]);

endfunction