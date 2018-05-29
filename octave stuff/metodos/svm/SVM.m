%carrega os arquivos de teste e treino gerados pelo script tm python
[base_treino_label, base_treino_data] = libsvmread('base_treino.lbsvm');
[base_teste_label, base_teste_data] = libsvmread('base_teste.lbsvm');

%treina com os dados e gera um modelo
model = svmtrain(base_treino_label, base_treino_data, '-c 1 -g 0.07');

%testa o modelo com os dados de teste e retorna um vetor das predicoes, acuracia
[predicted_labels, accuracy, dec_values] = svmpredict(base_teste_label, base_teste_data, model);