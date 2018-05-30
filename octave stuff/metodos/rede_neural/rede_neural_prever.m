function outputs_output_layer = rede_neural_prever(rede_neural, X)
  % Funcoes de ativacao
  leaky_relu = @(input) (input < 0) .* 0.01 .* input + (input >= 0) .* input;
  softmax = @(input) exp(input - max(input, [], 2)) ./ sum(exp(input - max(input, [], 2)), 2);
  
  % Adicionar bias ao X
  X(:, end + 1) = 1;
  
  % Feedforward
  % - Hidden layer
  inputs_hidden_layer = X * rede_neural.pesos1;
  outputs_hidden_layer = leaky_relu(inputs_hidden_layer);
  
  % - Output layer
  outputs_hidden_layer(:, end + 1) = 1;
  inputs_output_layer = outputs_hidden_layer * rede_neural.pesos2;
  outputs_output_layer = softmax(inputs_output_layer);
endfunction
