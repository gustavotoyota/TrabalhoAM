% Executa os metodos sobre a base

% ENTRADA
%               X = [MxN] amostras de treino
%               y = [Mx1] rotulos das amostras de treino
%         X_teste = [AxN] amostras de teste
%         y_teste = [Ax1] rotulos das amostras de teste
%  metodos_treino = metodos para serem treinados
%   metodos_teste = metodos para serem teste

function metodos(X, y, X_teste, y_teste, metodos_treino, metodos_teste)
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
  params_k_vizinhos.k = [3];  
  params_k_vizinhos.dist = [1];
  
  % NW K-vizinhos
  params_nw_k_vizinhos.k = [11];
  params_nw_k_vizinhos.dist = [1];
  params_nw_k_vizinhos.expoente = [7];
  
  % OCC K-vizinhos
  params_occ_k_vizinhos.classe = [1];
  params_occ_k_vizinhos.delta = [1.25];
  params_occ_k_vizinhos.dist = [2];
  
  % Regressao logistica
  params_regressao_logistica.alpha = [10];
  params_regressao_logistica.lambda = [0.1];  
  params_regressao_logistica.num_iteracoes = [1000];
  
  % Rede neural
  params_rede_neural2.tam_hidden_layers = [size(X,2)/1.5];
  params_rede_neural2.max_iter = [1000];
  params_rede_neural2.taxa_aprendizado = [0.01];
  params_rede_neural2.proporcao_influencias = [0.9];
  params_rede_neural2.taxa_regularizacao = [0.1];
  
  % SVM  
  params_svm.kernel = [2];  
  params_svm.c = [0.01]; 
  params_svm.gamma = [1];
   
  % OCC SVM
  params_occ_svm.classe = [1];  
  params_occ_svm.kernel = [2];  
  params_occ_svm.nu = [0.25]; 
  params_occ_svm.gamma = [0.0001];
            
  
  % Chama o grid search para cada metodo
  %   armazenando o resultado em best_params_metodo e clf_metodo
  for i = 1:length(metodos_treino)
    % Monta a funcao
    met = metodos_treino{i};
    retorno = strcat("[best_params_", met, ", clf_", met, "]");
    chamada = strcat("grid_search(X, y, \"", met, "\", train_split, test_split, params_", met, ")");
    funcao = strcat(retorno, " = ", chamada, ";");
    
    % Chama a funcao
    eval(funcao, "NaN");
    
    % Exibe o resultado
    fprintf("Melhores parametros do %s:\n", met);
    eval(strcat("best_params_", met, ","), "NaN");    
    
    % Armazena o resultado em memoria
    eval(strcat("save(\"metodos/outputs/best_params_", met, ".mat\", \"best_params_", met, "\", \"-mat\")"), "NaN");
  endfor    
  
  % Realiza a previsao do teste
  % Chama o prever teste para cada metodos
  %   armazenando o melhor resultado  
  melhor_pontuacao = Inf;
  melhor_metodo = "";  
  for i = 1:length(metodos_teste)
    % Le os melhores parametros
    met = metodos_teste{i};
    best_params = load(strcat("metodos/outputs/best_params_", met, ".mat"), strcat("best_params_", met), "-mat");
  
    % Monta a funcao
    met = metodos_teste{i};
    retorno = strcat("pontuacao_final");
    chamada = strcat("prever_teste(X, y, X_teste, y_teste, \"", met, "\", best_params)");
    funcao = strcat(retorno, " = ", chamada, ";");
    
    % Chama a funcao
    eval(funcao, "NaN");
    
    % Armazena o melhor resultado
    if pontuacao_final < melhor_pontuacao
      melhor_pontuacao = pontuacao_final;
      melhor_metodo = met;
    endif
  endfor  
endfunction
