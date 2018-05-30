function rede_neural_metodo(X, y)
  % Treinar rede neural
  opcoes.tam_hidden_layer = 100;
  opcoes.num_iteracoes = 1000;
  opcoes.taxa_aprendizado = 0.1;
  
  rede_neural = rede_neural_treinar(X, y, opcoes);
  rede_neural_prever(rede_neural, X(1:50, :))
end