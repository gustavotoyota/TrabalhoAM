function metodos(X, y, A, b)
  addpath("metodos/k_vizinhos");
  addpath("metodos/regressao_logistica");
  addpath("metodos/rede_neural");
  addpath("metodos/svm");
  
  % Cria os folds para validacao cruzada
  k = 5;
  [train_split, test_split] = separar_k_fold(k, y);
  
  % Define os parametros do grid_search  
  % K-vizinhos
  params_knn.k = [7];
  params_knn.p = [0.1];
  params_knn.dist = [1];
  
  % Regressao logistica
  params_reg.alpha = [10];
  params_reg.lambda = [0.1];
  params_reg.max_iter = [1]; 
  
  % Rede neural
  params_rna.tam_hidden_layer = [100];
  params_rna.max_iter = [1];
  params_rna.taxa_aprendizado = [0.1];
    
  % Chama o grid_search para cada metodo
  [best_params_knn, clf_knn] = grid_search(X, y, "k_vizinhos", train_split, test_split, params_knn);
  fprintf("Melhores parametros do K Vizinhos:\n")
  best_params_knn,  
  
  [best_params_reg, clf_reg] = grid_search(X, y, "regressao_logistica", train_split, test_split, params_reg);
  fprintf("Melhores parametros da regressao logistica:\n")
  best_params_reg,
  
  [best_params_rna, clf_rna] = grid_search(X, y, "rede_neural", train_split, test_split, params_rna);
  fprintf("Melhores parametros da rede neural:\n")
  best_params_rna,  
end
