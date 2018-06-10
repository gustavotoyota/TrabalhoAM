% Metodo Rede Neural Artificial com ReLu e Sigmoid para aprender os pesos da rede

% ENTRADA
%     X = [MxN] amostras de treinamento
%     y = [Mx1] rotulos das amostras de treinamento
%     opcoes = estrutura contendo:
%             tam_hidden_layer = [1x1] numero de neuronios da camada intermediaria
%                     max_iter = [1x1] numero de iteracoes do treinamento
%             taxa_aprendizado = [1x1] taxa de aprendizado
%        proporcao_influencias = [1x1] proporcao das influencias das classes nos gradientes
%           taxa_regularizacao = [1x1] taxa de regularizacao

% SAIDA
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo 
%           peso1 = [N+1xtam_hidden_layer] pesos entre camada de entrada e intermediaria
%           peso2 = [tam_hidden_layer+1x1] pesos entra camada intermediaria e de saida

function clf = rede_neural_treinar(X, y, opcoes)
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
  
  % Carregar opcoes
  tam_hidden_layer = eval('opcoes.tam_hidden_layer', '100');
  max_iter = eval('opcoes.max_iter', '1000');
  taxa_aprendizado = eval('opcoes.taxa_aprendizado', '1');
  proporcao_influencias = eval('opcoes.proporcao_influencias', '0.5');
  taxa_regularizacao = eval('opcoes.taxa_regularizacao', '0.01');
  
  % Auxiliares
  tam_input_layer = size(X, 2);
  tam_output_layer = size(y, 2);
  num_amostras = size(X, 1);
  
  % Inicializar pesos com inicializacao LeCun normal (Variancia = 1 / (tam. do layer anterior))
  % Tipo de inicializacao escolhida para manter os valores da rede proximos a distribuicao normal
  clf.pesos1 = randn(tam_input_layer + 1, tam_hidden_layer);
  clf.pesos2 = randn(tam_hidden_layer + 1, tam_output_layer);
  clf.pesos1 *= sqrt(1 / tam_input_layer);
  clf.pesos2 *= sqrt(1 / tam_hidden_layer);
    
  % Adicionar bias ao X
  X(:, end + 1) = 1;
  
  % Separacao de classes
  pos_y_neg = y == 0; % Posicoes das amostras de classe neg
  pos_y_pos = y == 1; % Posicoes das amostras de classe pos
  qtd_y_neg = sum(pos_y_neg); % Quantidade de amostras de classe neg
  qtd_y_pos = sum(pos_y_pos); % Quantidade de amostras de classe pos
  
  % Inicializar historico
  clf.historico = [];
  
  for iteracao = 1 : max_iter
    % Feedforward
    % - Hidden layer
    inputs_hidden_layer = X * clf.pesos1; % Multiplicar pelos pesos
    outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar sigmoid aos inputs

    % - Output layer
    outputs_hidden_layer_bias = [outputs_hidden_layer ones(num_amostras, 1)]; % Outputs anteriores com bias
    inputs_output_layer = outputs_hidden_layer_bias * clf.pesos2; % Multiplicar pelos pesos
    outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar sigmoid aos inputs
    
    % Calcular custo total
    custo_total = cross_entropy(outputs_output_layer, y)
    clf.historico(end + 1) = custo_total;
    
    % Backpropagation
    % - Output layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 2
    deriv_custos_outputs = deriv_cross_entropy(outputs_output_layer, y);
    deriv_outputs_inputs = deriv_sigmoid(inputs_output_layer, outputs_output_layer);
    deriv_custos_inputs = deriv_custos_outputs .* deriv_outputs_inputs;
    deriv_inputs_pesos = outputs_hidden_layer_bias;
    
    % --- Calcular gradiente dos pesos 2 com regularizacao
    grad_total_neg = deriv_inputs_pesos(pos_y_neg, :)' * deriv_custos_inputs(pos_y_neg, :);
    grad_total_pos = deriv_inputs_pesos(pos_y_pos, :)' * deriv_custos_inputs(pos_y_pos, :);
    grad_medio_neg = grad_total_neg ./ qtd_y_neg;
    grad_medio_pos = grad_total_pos ./ qtd_y_pos;
    grad_ponderado = (1 - proporcao_influencias) .* grad_medio_neg + proporcao_influencias .* grad_medio_pos;
    regularizacao = (clf.pesos2 .* taxa_regularizacao) ./ num_amostras;
    grad_pesos2 = grad_ponderado + regularizacao;
    
    % - Hidden layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 1
    deriv_custos_outputs = deriv_custos_inputs * clf.pesos2(1 : end - 1, :)';
    deriv_outputs_inputs = deriv_leaky_relu(inputs_hidden_layer, outputs_hidden_layer);
    deriv_custos_inputs = deriv_custos_outputs .* deriv_outputs_inputs;
    deriv_inputs_pesos = X;
    
    % --- Calcular gradiente dos pesos 1 com regularizacao
    grad_total_neg = deriv_inputs_pesos(pos_y_neg, :)' * deriv_custos_inputs(pos_y_neg, :);
    grad_total_pos = deriv_inputs_pesos(pos_y_pos, :)' * deriv_custos_inputs(pos_y_pos, :);
    grad_medio_neg = grad_total_neg ./ qtd_y_neg;
    grad_medio_pos = grad_total_pos ./ qtd_y_pos;
    grad_ponderado = (1 - proporcao_influencias) .* grad_medio_neg + proporcao_influencias .* grad_medio_pos;
    regularizacao = (clf.pesos1 .* taxa_regularizacao) ./ num_amostras;
    grad_pesos1 = grad_ponderado + regularizacao;
    
    % - Aplicar o negativo dos gradientes aos pesos, controlados pela taxa de aprendizado
    clf.pesos2 -= grad_pesos2 .* taxa_aprendizado;
    clf.pesos1 -= grad_pesos1 .* taxa_aprendizado;
  end
endfunction
