function pesos = treinar_rede(X, y, pesos, opcoes = 0)
  # Determinar opcoes
  num_iteracoes = eval("opcoes.num_iteracoes", "1");
  tam_batch = eval("opcoes.tam_batch", "10");
  taxa_aprendizado = eval("opcoes.taxa_aprendizado", "1");
  
  # Determinar auxiliares
  num_pesos = size(pesos, 1);
  
  num_layers = num_pesos + 1;
  
  tam_layers = zeros(num_layers, 1);
  for id_layer = 2 : num_layers
    tam_layers(id_layer) = size(pesos{id_layer - 1}, 2);
  end
  
  num_exemplos = size(X, 1);
  
  sigmoid = @(z) 1 ./ (1 + exp(-z));
  
  # Executar iteracoes
  for id_iteracao = 1 : num_iteracoes
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
      printf("Executando batch %d.", (id_exemplo_inicial - 1) / tam_batch + 1);
      
      tam_batch_atual = min(tam_batch, num_exemplos - id_exemplo_inicial + 1);
      id_exemplo_final = id_exemplo_inicial + tam_batch_atual - 1;
      
      # Inicializar influencias
      influencias = cell(num_pesos, 1);
      for i = 1 : num_pesos
        influencias{i} = zeros(size(pesos{i}));
      end
      
      # Executar batch
      for id_exemplo_atual = id_exemplo_inicial : id_exemplo_final
        input_exemplo = X(ordem(id_exemplo_atual), :);
        output_exemplo = y(ordem(id_exemplo_atual), :);
      
        # Feedforward
        outputs_layers = cell(num_layers, 1);
        output_layer = outputs_layers{1} = [input_exemplo, 1];
        for id_layer = 2 : num_layers
          output_layer = [sigmoid(output_layer * pesos{id_layer - 1}), 1];
          outputs_layers{id_layer} = output_layer;
        end
        output_rede = output_layer(1 : end - 1);
        
        # Acumular erro
        erro = erro + sum((output_rede - output_exemplo) .^ 2) / size(output_rede, 2);
        
        # Backpropagation
        for id_layer_atual = num_layers : -1 : 2
          id_layer_anterior = id_layer_atual - 1;
          id_layer_prox = id_layer_atual + 1;
          id_pesos_atuais = id_layer_anterior;
          id_pesos_prox = id_layer_atual;
          
          aux_prox = eval("aux_atuais", "[]");
          aux_atuais = zeros(tam_layers(id_layer_atual), 1);
          
          num_pesos_atuais = size(pesos{id_pesos_atuais}, 1);
          
          output_layer_atual = outputs_layers{id_layer_atual};
          output_layer_anterior = outputs_layers{id_layer_anterior};
          
          for id_neurorio_atual = 1 : tam_layers(id_layer_atual)
            if id_layer_atual == num_layers
              derivErroOutput = output_rede(id_neurorio_atual) - output_exemplo(id_neurorio_atual);
            else
              derivErroOutput = 0;
              for id_neuronio_prox = 1 : tam_layers(id_layer_prox)
                derivErroOutput += aux_prox(id_neuronio_prox) * pesos{id_pesos_prox}(id_neurorio_atual, id_neuronio_prox);
              end
            end
            derivOuputResultado = output_layer_atual(id_neurorio_atual) * (1 - output_layer_atual(id_neurorio_atual));
            derivErroResultado = derivErroOutput * derivOuputResultado;
            
            aux_atuais(id_neurorio_atual) = derivErroResultado;
            
            for id_peso_atual = 1 : num_pesos_atuais
              derivResultadoPeso = output_layer_anterior(id_peso_atual);
              derivErroPeso = derivErroResultado * derivResultadoPeso;
              
              influencias{id_pesos_atuais}(id_peso_atual, id_neurorio_atual) -= derivErroPeso * taxa_aprendizado;
            end
          end
        end
      end
      
      # Aplicar influencias
      for id_pesos_atuais = 1 : num_pesos
        pesos{id_pesos_atuais} += influencias{id_pesos_atuais} ./ tam_batch_atual;
      end
      
      printf(" Batch %d finalizado.\n", (id_exemplo_inicial - 1) / tam_batch + 1);
    end
    
    printf("Erro: %.5f.\n", erro / num_exemplos);
  end
end