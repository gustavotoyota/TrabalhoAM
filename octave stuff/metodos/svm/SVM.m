% Método SVM

% ENTRADA
%   X = [MxN] amostras de treinamento
%   Y = [Mx1] rotulos das amostras de treinamento
%   A = [PXN] amostras de teste
%   B = [PX1] rotulos das amostras de teste

% SAIDA
%   predicted_labels = os rotulos dados para os modelos de teste
%   accuracy = acuracia do modelo aplicado nos dados de teste

function [predicted_labels, accuracy] = svm(X, Y, A, B) 
%carrega os arquivos de teste e treino (se necessario? nao sei como vai rodar tudo no fim)
%[Y, X] = libsvmread('base_treino.lbsvm');
%[B, A] = libsvmread('base_teste.lbsvm');

%treina com os dados e gera um modelo
model = svmtrain(Y, X);

%testa o modelo com os dados de teste e retorna um vetor das predicoes e acuracia
[predicted_labels, accuracy, dec_values] = svmpredict(B, A, model);

%para escrever os dados em formato libsvm:
%libsvmwrite('base_treino.lbsvm', Y, X);
%libsvmwrite('base_teste.lbsvm', B, A);

end