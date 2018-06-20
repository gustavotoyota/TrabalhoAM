% Método Rede Neural Artificial com ReLu e Softmax para para predizer amostras

% ENTRADA
%      x = [MxN] amostras a serem rotuladas
%    clf = estrutura contendo:
%        historico = [max_iterx1] historico dos valores da funcao custo 
%           pesos1 = [N+1xtam_hidden_layers] pesos entre camada de entrada e intermediaria 1
%           pesos2 = [tam_hidden_layers+1xtam_hidden_layers] pesos entre camada intermediaria 1 e 2
%           pesos3 = [tam_hidden_layers+1x1] pesos entre camada intermediaria 2 e de saida

% SAIDA
%    pred = [Mx1] previsao das amostras

function pred = rede_neural2_prever(x, clf)
  % Funcoes de ativacao
  leaky_relu = @(inputs) (inputs < 0) .* 0.01 .* inputs + (inputs >= 0) .* inputs;
  
  sigmoid = @(inputs) 1 ./ (1 + exp(-inputs));
  
  % Auxiliares
  num_amostras = size(x, 1);
  
  % Adicionar bias ao X
  x(:, end + 1) = 1;
  
  % Feed forward
  % - Hidden layer 1
  inputs_hidden_layer1 = x * clf.pesos1; % Multiplicar pelos pesos
  outputs_hidden_layer1 = leaky_relu(inputs_hidden_layer1); % Aplicar ativacao aos inputs

  % - Hidden layer 2
  outputs_hidden_layer1_bias = [outputs_hidden_layer1 ones(num_amostras, 1)]; % Outputs anteriores com bias
  inputs_hidden_layer2 = outputs_hidden_layer1_bias * clf.pesos2; % Multiplicar pelos pesos
  outputs_hidden_layer2 = leaky_relu(inputs_hidden_layer2); % Aplicar ativacao aos inputs

  % - Output layer
  outputs_hidden_layer2_bias = [outputs_hidden_layer2 ones(num_amostras, 1)]; % Outputs anteriores com bias
  inputs_output_layer = outputs_hidden_layer2_bias * clf.pesos3; % Multiplicar pelos pesos
  outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar ativacao aos inputs
  
  % Realizar predicao
  pred = double(outputs_output_layer >= 0.5);
endfunction
