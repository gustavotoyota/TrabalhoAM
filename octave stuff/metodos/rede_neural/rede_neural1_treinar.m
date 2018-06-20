% Metodo Rede Neural Artificial com ReLu e Sigmoid para aprender os pesos da rede

% ENTRADA
%    X = [MxN] amostras de treinamento
%    y = [Mx1] rotulos das amostras de treinamento
%    opcoes = estrutura contendo:
%            tam_hidden_layers = [1x1] numero de neuronios das camadas intermediarias
%                     max_iter = [1x1] numero de iteracoes do treinamento
%             taxa_aprendizado = [1x1] taxa de aprendizado
%        proporcao_influencias = [1x1] proporcao das influencias das classes nos gradientes
%           taxa_regularizacao = [1x1] taxa de regularizacao

% SAIDA
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo 
%           pesos1 = [N+1xtam_hidden_layers] pesos entre camada de entrada e intermediaria
%           pesos2 = [tam_hidden_layers+1x1] pesos entra camada intermediaria e de saida

function clf = rede_neural1_treinar(X, y, opcoes)
  % Inicializacao de pesos
  lecun_normal = @(tam_anterior, tam_prox) randn(tam_anterior + 1, tam_prox) .* sqrt(1 / tam_anterior);
  
  % Funcoes de ativacao
  leaky_relu = @(inputs) (inputs < 0) .* 0.01 .* inputs + (inputs >= 0) .* inputs;
  deriv_leaky_relu = @(inputs, outputs) (inputs < 0) .* 0.01 + (inputs >= 0) .* 1;
  
  sigmoid = @(inputs) 1 ./ (1 + exp(-inputs));
  
  % Funcao de custo
  epsilon = 1e-15; % Usado para prevenir log de zero e divisao por zero
  cross_entropy = @(atual, alvo) mean(mean(-alvo .* log(atual + epsilon) - (1 - alvo) .* log(1 - atual + epsilon)));
  
  deriv_sigmoid_cross_entropy = @(atual, alvo) atual - alvo;
  
  % Carregar opcoes
  tam_hidden_layers = eval('opcoes.tam_hidden_layers', '100');
  max_iter = eval('opcoes.max_iter', '1000');
  taxa_aprendizado = eval('opcoes.taxa_aprendizado', '1');
  proporcao_influencias = eval('opcoes.proporcao_influencias', '0.5');
  taxa_regularizacao = eval('opcoes.taxa_regularizacao', '0.01');
  
  % Auxiliares
  tam_input_layer = size(X, 2);
  tam_output_layer = size(y, 2);
  num_amostras = size(X, 1);
  
  % Inicializar pesos com inicializacao LeCun normal (Variancia = 1 / (tam. do layer anterior))
  clf.pesos1 = lecun_normal(tam_input_layer, tam_hidden_layers);
  clf.pesos2 = lecun_normal(tam_hidden_layers, tam_output_layer);
    
  % Adicionar bias ao X
  X(:, end + 1) = 1;
  
  % Inicializacao do otimizador Nesterov
  coeficiente_atrito = 0.9;
  
  update_pesos1 = zeros(size(clf.pesos1));
  update_pesos2 = zeros(size(clf.pesos2));
  
  % Separacao de classes
  pos_y_neg = y == 0; % Posicoes das amostras de classe neg
  pos_y_pos = y == 1; % Posicoes das amostras de classe pos
  qtd_y_neg = sum(pos_y_neg); % Quantidade de amostras de classe neg
  qtd_y_pos = sum(pos_y_pos); % Quantidade de amostras de classe pos
  
  % Inicializar historico
  clf.historico = [];
  
  for iteracao = 1 : max_iter
    % Calcular lookaheads dos pesos para o otimizador Nesterov
    lookahead_pesos1 = clf.pesos1 - update_pesos1 .* coeficiente_atrito;
    lookahead_pesos2 = clf.pesos2 - update_pesos2 .* coeficiente_atrito;
    
    % Feed forward
    % - Hidden layer
    inputs_hidden_layer = X * lookahead_pesos1; % Multiplicar pelos pesos
    outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar ativacao aos inputs

    % - Output layer
    outputs_hidden_layer_bias = [outputs_hidden_layer ones(num_amostras, 1)]; % Outputs anteriores com bias
    inputs_output_layer = outputs_hidden_layer_bias * lookahead_pesos2; % Multiplicar pelos pesos
    outputs_output_layer = sigmoid(inputs_output_layer); % Aplicar ativacao aos inputs
    
    % Calcular custo total
    custo_total = cross_entropy(outputs_output_layer, y);
    clf.historico(end + 1) = custo_total;
    
    % Backpropagation
    % - Output layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 2
    grad_custos_inputs = deriv_sigmoid_cross_entropy(outputs_output_layer, y);
    grad_inputs_pesos = outputs_hidden_layer_bias;
    
    % --- Calcular gradiente dos pesos 2 com regularizacao
    grad_total_neg = grad_inputs_pesos(pos_y_neg, :)' * grad_custos_inputs(pos_y_neg, :);
    grad_total_pos = grad_inputs_pesos(pos_y_pos, :)' * grad_custos_inputs(pos_y_pos, :);
    grad_medio_neg = grad_total_neg ./ qtd_y_neg;
    grad_medio_pos = grad_total_pos ./ qtd_y_pos;
    grad_ponderado = (1 - proporcao_influencias) .* grad_medio_neg + proporcao_influencias .* grad_medio_pos;
    regularizacao_total = lookahead_pesos2(1:end-1, :) .* taxa_regularizacao;
    regularizacao_final = resize(regularizacao_total ./ num_amostras, size(clf.pesos2));
    grad_pesos2 = grad_ponderado + regularizacao_final;
    
    % --- Propagar o gradiente sobre os pesos 2 com otimizador Nesterov
    update_pesos2 = update_pesos2 .* coeficiente_atrito + grad_pesos2 .* taxa_aprendizado;
    clf.pesos2 -= update_pesos2;
    
    % - Hidden layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 1
    grad_custos_outputs = grad_custos_inputs * clf.pesos2(1 : end - 1, :)';
    grad_outputs_inputs = deriv_leaky_relu(inputs_hidden_layer, outputs_hidden_layer);
    grad_custos_inputs = grad_custos_outputs .* grad_outputs_inputs;
    grad_inputs_pesos = X;
    
    % --- Calcular gradiente dos pesos 1 com regularizacao
    grad_total_neg = grad_inputs_pesos(pos_y_neg, :)' * grad_custos_inputs(pos_y_neg, :);
    grad_total_pos = grad_inputs_pesos(pos_y_pos, :)' * grad_custos_inputs(pos_y_pos, :);
    grad_medio_neg = grad_total_neg ./ qtd_y_neg;
    grad_medio_pos = grad_total_pos ./ qtd_y_pos;
    grad_ponderado = (1 - proporcao_influencias) .* grad_medio_neg + proporcao_influencias .* grad_medio_pos;
    regularizacao_total = lookahead_pesos1(1:end-1, :) .* taxa_regularizacao;
    regularizacao_final = resize(regularizacao_total ./ num_amostras, size(clf.pesos1));
    grad_pesos1 = grad_ponderado + regularizacao_final;
    
    % --- Propagar o gradiente sobre os pesos 1 com otimizador Nesterov
    update_pesos1 = update_pesos1 .* coeficiente_atrito + grad_pesos1 .* taxa_aprendizado;
    clf.pesos1 -= update_pesos1;
  end
endfunction
