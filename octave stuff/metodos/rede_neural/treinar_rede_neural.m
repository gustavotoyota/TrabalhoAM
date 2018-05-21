function pesos = treinar_rede_neural(X, y, pesos, taxa_aprendizado, tam_batch)
  tam_layer = @(id_layer) size(pesos, 2);
  
  num_pesos = size(pesos, 1);
  
  id_ultimo_layer = size(pesos, 1);
  num_layers = id_ultimo_layer + 1;
  
  num_exemplos = size(X, 1);
  
  num_batches = ceil(num_exemplos / tam_batch);
  
  # Embaralhar exemplos
  ordem = 1 : num_exemplos;
  for i = 1 : num_exemplos
  id_troca = 1 + floor(rand * (num_exemplos - i + 1));
  ordem([i id_troca]) = ordem([id_troca i]);
  end
  
  # Inicializar erro
  erro = 0;
  
  # Executar batches
  for id_exemplo_inicial = 1 : tam_batch : num_exemplos
    tam_batch_atual = min(tam_batch, num_exemplos - id_exemplo_inicial);
    id_exemplo_final = id_exemplo_inicial + tam_batch_atual;
    
    # Inicializar influencias
    influencias = cell(num_pesos, 1);
    for i = 1 : num_pesos
      influencias{i} = zeros(size(pesos{i}));
    end
    
    # Executar batch
    for id_exemplo_atual = id_exemplo_inicial : id_exemplo_final
      input_exemplo = X(ordem(id_exemplo_atual));
      output_exemplo = y(ordem(id_exemplo_atual));
    
      # Feedforward
      outputs_layers = cell(num_layers, 1);
      output_layer = outputs_layers{1} = input_exemplo;
      for id_layer = 2 : num_layers
        output_layer = [output_layer 1];
        output_layer = sigmoid(output_layer * pesos{id_layer - 1});
        outputs_layers{id_layer} = output_layer;
      end
      output_rede = output_layer;
      
      # Acumular erro
      erro = erro + sum((output_rede - output_exemplo) .^ 2);
      
      # Backpropagation
      for id_layer_atual = id_ultimo_layer : -1 : 2
        id_layer_anterior = id_layer_atual - 1;
        id_layer_prox = id_layer_atual + 1;
        id_pesos_atuais = id_layer_atual - 1;
        id_pesos_prox = id_pesos_atuais + 1;
        
        tam_layer_atual = tam_layer(id_layer_atual);
        if id_layer_atual != id_ultimo_layer
          tam_layer_prox = tam_layer(id_layer_prox);
        end
        
        aux_prox = eval("aux_atuais", []);
        aux_atuais = zeros(tam_layer_atual);
        
        pesos_atuais = pesos{id_pesos_atuais};
        if id_layer_atual != id_ultimo_layer
          pesos_prox = pesos{id_pesos_prox};
        end
        
        output_layer_atual = outputs_layers{id_layer_atual};
        output_layer_anterior = outputs_layers{id_layer_anterior};
        
        influencias_atuais = influencias{id_pesos_atuais};
        
        for id_neurorio_atual = 1 : tam_layer_atual
          if id_layer_atual == id_ultimo_layer
            derivErroOutput = output_rede(id_neurorio_atual) - output_exemplo(id_neurorio_atual);
          else
            derivErroOutput = 0;
            for id_neuronio_prox = 1 : tam_layer_prox
              derivErroOutput += aux_prox(id_neuronio_prox) * pesos_prox(id_neurorio_atual)(id_neuronio_prox)
            end
          end
          derivOuputResultado = output_layer_atual(id_neurorio_atual) * (1 - output_layer_atual(id_neurorio_atual));
          derivErroResultado = derivErroOutput * derivOuputResultado;
          
          aux_atuais(id_neurorio_atual) = derivErroResultado;
          
          for id_peso_atual = 1 : size(pesos_atuais, 1)
            derivResultadoPeso = output_layer_anterior(id_peso_atual);
            derivErroPeso = derivErroResultado * derivResultadoPeso;
            
            influencias_atuais(id_peso_atual)(id_neurorio) -= derivErroPeso * taxa_aprendizado;
          end
        end
      end
    end
    
    // Aplicar influencias
    for id_pesos_atuais = 1 : num_pesos
      pesos{id_pesos_atuais} += influences{id_pesos_atuais} / tam_batch_atual;
    end
  end
  
  printf("Erro: %.2f.\n", erro / num_exemplos);
end