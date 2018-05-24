function rede_neural(X, y)
  if isempty(X)
    load("-binary", "preprocessamento/normalizar_dados.mat", "X");
    load("-binary", "preprocessamento/remover_dados.mat", "y");
  end  
  
  num_atributos = size(X, 2);
  num_saidas = size(y, 2);

  pesos = gerar_pesos([num_atributos, 20, 20, num_saidas]);

  opcoes.num_iteracoes = 1;
  opcoes.tam_batch = 1000;
  opcoes.taxa_aprendizado = 1;

  treinar_rede(X, y, pesos, opcoes);
end