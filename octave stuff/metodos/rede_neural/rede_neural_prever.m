% Método Rede Neural Artificial com ReLu e Softmax para para predizer amostras

% ENTRADA
%     x = [MxN] amostras a serem rotuladas
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo 
%           peso1 = [N+1xtam_hidden_layer] pesos entre camada de entrada e intermediaria
%           peso2 = [tam_hidden_layer+1x1] pesos entra camada intermediaria e de saida

% SAIDA
%   pred = [Mx1] previsao das amostras

function pred = rede_neural_prever(x, clf)
  % Funcoes de ativacao
  relu = @(inputs) max(0, inputs);
  deriv_relu = @(inputs, outputs) double(inputs > 0);
  
  leaky_relu = @(inputs) (inputs < 0) .* 0.01 .* inputs + (inputs >= 0) .* inputs;
  deriv_leaky_relu = @(inputs, outputs) (inputs < 0) .* 0.01 + (inputs >= 0) .* 1;
  
  sigmoid = @(inputs) 1 ./ (1 + exp(-inputs));
  deriv_sigmoid = @(inputs, outputs) outputs .* (1 - outputs);
  
  % Auxiliares
  num_testes = size(x, 1);
    
  % Adicionar bias ao x
  x(:, end + 1) = 1;
  
  % Feedforward
  % - Hidden layer
  inputs_hidden_layer = x * clf.pesos1; % Multiplicar pelos pesos
  outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar sigmoid aos inputs

  % - Output layer
  outputs_hidden_layer_bias = [outputs_hidden_layer ones(num_testes, 1)]; % Outputs anteriores com bias
  inputs_output_layer = outputs_hidden_layer_bias * clf.pesos2; % Multiplicar pelos pesos
  outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar sigmoid aos inputs
  
  % Realiza a predicao
  pred = outputs_output_layer;
endfunction
