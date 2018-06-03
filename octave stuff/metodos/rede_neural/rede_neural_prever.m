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
  leaky_relu = @(input) (input < 0) .* 0.01 .* input + (input >= 0) .* input;
  softmax = @(input) exp(input - max(input, [], 2)) ./ sum(exp(input - max(input, [], 2)), 2);
  
  % Adicionar bias ao X
  x(:, end + 1) = 1;
  
  % Feedforward
  % - Hidden layer
  inputs_hidden_layer = x * clf.pesos1;
  outputs_hidden_layer = leaky_relu(inputs_hidden_layer);
  
  % - Output layer
  outputs_hidden_layer(:, end + 1) = 1;
  inputs_output_layer = outputs_hidden_layer * clf.pesos2;
  outputs_output_layer = softmax(inputs_output_layer);
  
  % Realiza a predicao
  pred = round(outputs_output_layer(:,2));
endfunction
