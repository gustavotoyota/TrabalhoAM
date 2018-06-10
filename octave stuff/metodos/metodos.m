function metodos(X, y)
  % Adiciona os caminhos dos arquivos
  addpath("metodos/ferramentas");
  addpath("metodos/k_vizinhos");
  addpath("metodos/regressao_logistica");
  addpath("metodos/rede_neural");
  addpath("metodos/svm");  
  addpath("metodos/scores");  
  
  % Cria os folds para validacao cruzada
  k = 2;
  [train_split, test_split] = separar_k_fold(k, y);
  
  % Define os parametros do grid_search  
  % K-vizinhos
  params_knn.k = [7];
  params_knn.p = [0.1];
  params_knn.dist = [1];
  
  % Regressao logistica
  params_reg.alpha = [10];
  params_reg.lambda = [0.1];
  params_reg.max_iter = [1000]; 
  params_reg.p = [0.1];
  
  % Rede neural
  params_rna.tam_hidden_layer = [100];
  params_rna.max_iter = [1];
  params_rna.taxa_aprendizado = [0.1];
  
  % SVM
  params_svm.kernel = [0];% 1 2 3];
  params_svm.c = [0.01];% 0.1 1 10 100]; 
  params_svm.gamma = [0.0001];% 0.001 0.01 1 10];
  
  % OCC K-vizinhos
  params_okn.classe = [1];
  params_okn.delta = [1];
  params_okn.dist = [2];
  
  % OCC SVM
  params_osv.classe = [1];
  params_osv.kernel = [0];% 1 2 3];
  params_osv.nu = [0.25];% 0.5 0.75 1]; 
  params_osv.gamma = [0.0001];% 0.001 0.01 1 10];
    
  % Chama o grid_search para cada metodo
  %[best_params_knn, clf_knn] = grid_search(X, y, "k_vizinhos", train_split, test_split, params_knn);
  %fprintf("Melhores parametros do K vizinhos:\n")
  %best_params_knn,  
  
  %[best_params_reg, clf_reg] = grid_search(X, y, "regressao_logistica", train_split, test_split, params_reg);
  %fprintf("Melhores parametros da regressao logistica:\n")
  %best_params_reg,
  
  %[best_params_rna, clf_rna] = grid_search(X, y, "rede_neural", train_split, test_split, params_rna);
  %fprintf("Melhores parametros da rede neural:\n")
  %best_params_rna,  
  
  [best_params_svm, clf_svm] = grid_search(X, y, "svm", train_split, test_split, params_svm);
  fprintf("Melhores parametros do SVM:\n")
  best_params_svm,  
 
  %[best_params_okn, clf_okn] = grid_search(X, y, "occ_k_vizinhos", train_split, test_split, params_okn);
  %fprintf("Melhores parametros do OCC K vizinhos:\n")
  %best_params_okn,  
  
  [best_params_osv, clf_osv] = grid_search(X, y, "occ_svm", train_split, test_split, params_osv);
  fprintf("Melhores parametros do OCC SVM:\n")
  best_params_osv,  
end