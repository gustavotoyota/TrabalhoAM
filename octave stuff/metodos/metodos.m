function metodos(X, y, X_teste, y_teste, basepreproc)
  % Carregar inputs
  if isempty(X) || isempty(y) || isempty(X_teste) || isempty(y_teste)
    load('preprocessamento/preprocessamento.mat', 'X', 'y', 'X_teste', 'y_teste', '-mat');
  end
  
  % Adiciona os caminhos dos arquivos
  addpath("metodos/ferramentas");
  addpath("metodos/k_vizinhos");
  addpath("metodos/regressao_logistica");
  addpath("metodos/rede_neural");
  addpath("metodos/svm");  
  addpath("metodos/scores");  
  
  % Criar pastas de output
  mkdir('metodos/outputs');  
  
  % Cria os folds para validacao cruzada
  k = 5;
  [train_split, test_split] = separar_k_fold(k, y);
  
  % Define os parametros do grid_search  
  % K-vizinhos
  params_k_vizinhos.k = [3 5 7 9];  
  params_k_vizinhos.dist = [1 2];
  
  % NW K-vizinhos
  params_nw_k_vizinhos.k = [3 5 7 9];
  params_nw_k_vizinhos.dist = [1 2];
  params_nw_k_vizinhos.expoente = [3 5 6 7];
  
  % Regressao logistica
  params_regressao_logistica.alpha = [0.01 0.1 1 10];
  params_regressao_logistica.lambda = [0.01 0.1 1];  
  params_regressao_logistica.num_iteracoes = [10];
  
  % Rede neural
  params_rede_neural2.tam_hidden_layers = [size(X,2) size(X,2)/1.5 size(X,2)*1.5];
  params_rede_neural2.max_iter = [10];
  params_rede_neural2.taxa_aprendizado = [0.01 0.1 1 10];
  params_rede_neural2.proporcao_influencias = [0.5 0.7 0.9];
  params_rede_neural2.taxa_regularizacao = [0.01 0.1 1];
  
  % SVM
  if length(y) > 10000
    params_occ_svm.kernel = [0];
  else
    params_occ_svm.kernel = [0 1 2];
  endif
  params_svm.c = [0.01 0.1 1 10 100]; 
  params_svm.gamma = [0.001 0.01 1 10];
  
  % OCC K-vizinhos
  params_occ_k_vizinhos.classe = [1];
  params_occ_k_vizinhos.delta = [0.5 0.7 1 1.25];
  params_occ_k_vizinhos.dist = [1 2];
  
  % OCC SVM
  params_occ_svm.classe = [1];
  if length(y) > 10000
    params_occ_svm.kernel = [0];
  else
    params_occ_svm.kernel = [0 1 2];
  endif
  params_occ_svm.nu = [0.25 0.5 0.75 1]; 
  params_occ_svm.gamma = [0.0001 0.001 0.01 1 10];
    
  % Define os nomes dos metodos
  metodos = {"k_vizinhos", "nw_k_vizinhos", "regressao_logistica", "rede_neural2", "svm", "occ_k_vizinhos", "occ_svm"};        
  
  % Chama o grid search para cada metodo
  %   armazenando o resultado em best_params_metodo e clf_metodo
  for i = 1:length(metodos)
    % Monta a funcao
    met = metodos{i};
    retorno = strcat("[best_params_", met, ", clf_", met, "]");
    chamada = strcat("grid_search(X, y, \"", met, "\", train_split, test_split, params_", met, ")");
    funcao = strcat(retorno, " = ", chamada, ";");
    
    % Chama a funcao
    eval(funcao, "NaN");
    
    % Exibe o resultado
    fprintf("Melhores parametros do %s:\n", met);
    eval(strcat("best_params_", met, ","), "NaN");    
    eval(strcat("save(\"metodos/outputs/", basepreproc, "_best_params_", met, ".mat\", \"best_params_", met, "\", \"-mat\")"), "NaN");
  endfor
  
  
  % Realiza a previsao do teste
  % Chama o prever teste para cada metodos
  %   armazenando o melhor resultado  
  melhor_pontuacao = Inf;
  melhor_metodo = "";  
  for i = 1:length(metodos)
    % Monta a funcao
    met = metodos{i};
    retorno = strcat("pontuacao_final");
    chamada = strcat("prever_teste(X, y, X_teste, y_teste, \"", met, "\", best_params_", met, ", \"", basepreproc, "\")");
    funcao = strcat(retorno, " = ", chamada, ";");
    
    % Chama a funcao
    eval(funcao, "NaN");
    
    % Armazena o melhor resultado
    if pontuacao_final < melhor_pontuacao
      melhor_pontuacao = pontuacao_final;
      melhor_metodo = met;
    endif
  endfor
  
  % Exibe o resultado final de todo o algoritmo
  fprintf("=== MELHOR METODO ===\n%s\n\n", melhor_metodo);  
endfunction