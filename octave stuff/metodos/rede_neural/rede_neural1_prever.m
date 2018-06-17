% Método Rede Neural Artificial com ReLu e Softmax para para predizer amostras

% ENTRADA
%      x = [MxN] amostras a serem rotuladas
%    clf = estrutura contendo:
%        historico = [max_iterx1] historico dos valores da funcao custo 
%           pesos1 = [N+1xtam_hidden_layer] pesos entre camada de entrada e intermediaria
%           pesos2 = [tam_hidden_layer+1x1] pesos entra camada intermediaria e de saida

% SAIDA
%    pred = [Mx1] previsao das amostras

function pred = rede_neural_prever1(clf, X)
  % Funcoes de ativacao
  relu = @(inputs) max(0, inputs);
  deriv_relu = @(inputs, outputs) double(inputs > 0);
  
  leaky_relu = @(inputs) (inputs < 0) .* 0.01 .* inputs + (inputs >= 0) .* inputs;
  deriv_leaky_relu = @(inputs, outputs) (inputs < 0) .* 0.01 + (inputs >= 0) .* 1;
  
  sigmoid = @(inputs) 1 ./ (1 + exp(-inputs));
  deriv_sigmoid = @(inputs, outputs) outputs .* (1 - outputs);
  
  % Funcoes de custo
  quadratico = @(atual, alvo) mean(mean((atual - alvo) .^ 2));
  deriv_quadratico = @(atual, alvo) atual - alvo;
  
  epsilon = 1e-15; % Usado para prevenir log de zero e divisao por zero
  cross_entropy = @(atual, alvo) mean(mean(-alvo .* log(atual + epsilon) - (1 - alvo) .* log(1 - atual + epsilon)));
  deriv_cross_entropy = @(atual, alvo) (atual - alvo) ./ (atual .* (1 - atual) + epsilon);
  
  % Auxiliares
  num_amostras = size(X, 1);
  
  % Adicionar bias ao X
  X(:, end + 1) = 1;

  % Feed forward
  % - Hidden layer
  inputs_hidden_layer = X * clf.pesos1; % Multiplicar pelos pesos
  outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar ativacao aos inputs

  % - Output layer
  outputs_hidden_layer_bias = [outputs_hidden_layer ones(num_amostras, 1)]; % Outputs anteriores com bias
  inputs_output_layer = outputs_hidden_layer_bias * clf.pesos2; % Multiplicar pelos pesos
  outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar ativacao aos inputs
  
  % Realizar predicao
  pred = double(outputs_output_layer >= clf.threshold_pred);
endfunction
