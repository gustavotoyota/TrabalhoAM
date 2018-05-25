function rede_neural = rede_neural_treinar(X, y, opcoes = 0)
  tam_hidden_layer = eval('opcoes.tam_hidden_layer', '20');
  num_iteracoes = eval('opcoes.num_iteracoes', '100');
  taxa_aprendizado = eval('opcoes.taxa_aprendizado', '1');
  
  num_inputs = size(X, 2);
  num_outputs = 1;
  
  num_amostras = size(X, 1);
  
  rede_neural.pesos1 = rand(num_inputs + 1, tam_hidden_layer);
  rede_neural.pesos2 = rand(tam_hidden_layer + 1, num_outputs);
  
  X(:, end+1) = 1;
  
  relu = @(x) max(0, x);
  sigmoid = @(z) 1 ./ (1 + exp(-z));
  
  for i = 1 : num_iteracoes
    % Feedforward
    outputs_hidden = relu(X * rede_neural.pesos1);
    outputs_hidden(:, end+1) = 1;
    outputs_rede = sigmoid(outputs_hidden * rede_neural.pesos2);
    erros_outputs = outputs_rede - y;
    
    % Calcular erro total
    erro_total = sum(erros_outputs .^ 2) ./ num_amostras;
    fprintf("Erro: %f.\n", erro_total);
    
    % Backpropagation
    % - Output layer
    deriv_erro_output = erros_outputs;
    deriv_output_resultado = outputs_rede .* (1 - outputs_rede);
    deriv_erro_resultado = deriv_erro_output .* deriv_output_resultado;
    
    deriv_resultado_peso = outputs_hidden;
    influencias_totais = deriv_erro_resultado' * deriv_resultado_peso;
    influencias_pesos2 = influencias_totais ./ num_amostras;
    
    % - Hidden layer
    deriv_erro_output = deriv_erro_resultado .* rede_neural.pesos2';
    deriv_output_resultado = double(outputs_hidden > 0);
    deriv_erro_resultado = deriv_erro_output .* deriv_output_resultado;
    
    deriv_resultado_peso = X;
    influencias_totais = deriv_erro_resultado(:, 1:end-1)' * deriv_resultado_peso;
    influencias_pesos1 = influencias_totais ./ num_amostras;
    
    % - Aplicar influencias
    rede_neural.pesos2 -= influencias_pesos2' .* taxa_aprendizado;
    rede_neural.pesos1 -= influencias_pesos1' .* taxa_aprendizado;
  end
end