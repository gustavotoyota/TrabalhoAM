function pesos = gerar_pesos(tam_layers)
  num_layers = size(tam_layers, 2);
  
  num_pesos = num_layers - 1;
  
  pesos = cell(num_pesos, 1);
  
  for id_pesos = 1 : num_pesos
    id_layer_atual = id_pesos;
    id_layer_prox = id_layer_atual + 1;
    
    pesos{id_pesos} = rand(tam_layers(id_layer_atual) + 1, tam_layers(id_layer_prox)) .* 2 - 1;
  end
end