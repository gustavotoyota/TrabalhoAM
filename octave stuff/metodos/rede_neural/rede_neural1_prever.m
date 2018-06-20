% Método Rede Neural Artificial com ReLu e Softmax para para predizer amostras

% ENTRADA
%      x = [MxN] amostras a serem rotuladas
%    clf = estrutura contendo:
%        historico = [max_iterx1] historico dos valores da funcao custo 
%           pesos1 = [N+1xtam_hidden_layers] pesos entre camada de entrada e intermediaria
%           pesos2 = [tam_hidden_layers+1x1] pesos entre camada intermediaria e de saida

% SAIDA
%    pred = [Mx1] previsao das amostras

function pred = rede_neural_prever1(x, clf)
  % Funcoes de ativacao
  leaky_relu = @(inputs) (inputs < 0) .* 0.01 .* inputs + (inputs >= 0) .* inputs;
  
  sigmoid = @(inputs) 1 ./ (1 + exp(-inputs));
  
  % Auxiliares
  num_amostras = size(x, 1);
  
  % Adicionar bias ao X
  x(:, end + 1) = 1;

  % Feed forward
  % - Hidden layer
  inputs_hidden_layer = x * clf.pesos1; % Multiplicar pelos pesos
  outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar ativacao aos inputs

  % - Output layer
  outputs_hidden_layer_bias = [outputs_hidden_layer ones(num_amostras, 1)]; % Outputs anteriores com bias
  inputs_output_layer = outputs_hidden_layer_bias * clf.pesos2; % Multiplicar pelos pesos
  outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar ativacao aos inputs
  
  % Realizar predicao
  pred = double(outputs_output_layer >= 0.5);
endfunction
