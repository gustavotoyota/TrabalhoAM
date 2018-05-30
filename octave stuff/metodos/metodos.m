function metodos(X, y)
  addpath("metodos/k_vizinhos");
  addpath("metodos/regressao_logistica");
  addpath("metodos/rede_neural");
  addpath("metodos/svm");
  
  rede_neural_metodo(X, y);
end
