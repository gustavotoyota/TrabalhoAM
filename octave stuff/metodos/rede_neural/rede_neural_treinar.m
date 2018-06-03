% Método Rede Neural Artificial com ReLu e Softmax para aprender os pesos da rede

% ENTRADA
%          X = [MxN] amostras de treinamento
%          y = [Mx1] rotulos das amostras de treinamento
%     opcoes = estrutura contendo:
%        tam_hidden_layer = [1x1] numero de neuronios da camada intermediaria
%                max_iter = [1x1] numero de iteracoes da rede
%        taxa_aprendizado = [1x1] taxa de aprendizado

% SAIDA
%   clf = estrutura contendo:
%       historico = [max_iterx1] historico dos valores da funcao custo 
%           peso1 = [N+1xtam_hidden_layer] pesos entre camada de entrada e intermediaria
%           peso2 = [tam_hidden_layer+1x1] pesos entra camada intermediaria e de saida


function clf = rede_neural_treinar(X, y, opcoes)
  % Funcoes de ativacao
  leaky_relu = @(input) (input < 0) .* 0.01 .* input + (input >= 0) .* input;
  deriv_leaky_relu = @(input) (input < 0) .* 0.01 + (input >= 0) .* 1;
  
  softmax = @(input) exp(input - max(input, [], 2)) ./ sum(exp(input - max(input, [], 2)), 2);
  deriv_softmax_crossentropy = @(atual, alvo) atual - alvo;
  
  % Funcao de custo
  epsilon = 1e-15; % Usado para prevenir log(0) = -Inf
  cross_entropy = @(atual, alvo) mean(mean(-alvo .* log(atual + epsilon) - (1 - alvo) .* log(1 - atual + epsilon)));
  
  % Carregar opcoes usando a funcao eval(try, catch)
  tam_hidden_layer = eval('opcoes.tam_hidden_layer', '10');
  max_iter = eval('opcoes.max_iter', '100');
  taxa_aprendizado = eval('opcoes.taxa_aprendizado', '0.01');
  
  % Modificar y para classificacao com softmax
  y(:, 2) = y;
  y(:, 1) = y(:, 2) == 0;
  
  % Auxiliares
  tam_input_layer = size(X, 2);
  tam_output_layer = size(y, 2);
  num_amostras = size(X, 1);
  
  % Adicionar bias ao X
  X(:, end + 1) = 1;
  
  % Separacao de classes
  pos_y_neg = y(:, 2) == 0; % Posicoes das amostras de classe neg
  pos_y_pos = y(:, 2) == 1; % Posicoes das amostras de classe pos
  qtd_y_neg = sum(pos_y_neg); % Quantidade de amostras de classe neg
  qtd_y_pos = sum(pos_y_pos); % Quantidade de amostras de classe pos
  
  % Inicializa historico de custos
  clf.historico = zeros(max_iter, 1);
  
  % Inicializar aleatoriamente entre -1 e 1
  clf.pesos1 = rand(tam_input_layer + 1, tam_hidden_layer) .* 2 - 1;
  clf.pesos2 = rand(tam_hidden_layer + 1, tam_output_layer) .* 2 - 1;
  
  % Aplicar redistribuicao dos pesos
  clf.pesos1 *= sqrt(2 / (tam_input_layer + tam_hidden_layer));
  clf.pesos2 *= sqrt(2 / (tam_hidden_layer + tam_output_layer));
  
  for i = 1 : max_iter
    % Feedforward
    % - Hidden layer
    inputs_hidden_layer = X * clf.pesos1; % Multiplicar pelos pesos
    outputs_hidden_layer = leaky_relu(inputs_hidden_layer); % Aplicar leaky relu aos inputs
    
    % - Output layer
    outputs_hidden_layer(:, end + 1) = 1; % Adicionar bias aos outputs do layer anterior
    inputs_output_layer = outputs_hidden_layer * clf.pesos2; % Multiplicar pelos pesos
    outputs_output_layer = softmax(inputs_output_layer); % Aplicar softmax aos inputs
    
    % Calcular custo total
    custo_total = cross_entropy(outputs_output_layer, y);
    clf.historico(i) = custo_total;
    %fprintf("Custo total: %f.\n", custo_total);
    
    % Backpropagation
    % - Output layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 2
    deriv_custos_inputs = deriv_softmax_crossentropy(outputs_output_layer, y);
    deriv_inputs_pesos = outputs_hidden_layer;
    
    % --- Obter a media da influencia dos pesos 2 sobre os custos das duas classes
    grad_total_pesos2_neg = (deriv_custos_inputs(pos_y_neg, :)' *deriv_inputs_pesos(pos_y_neg, :))';
    grad_total_pesos2_pos = (deriv_custos_inputs(pos_y_pos, :)' * deriv_inputs_pesos(pos_y_pos, :))';
    grad_medio_pesos2 = (grad_total_pesos2_neg ./ qtd_y_neg + grad_total_pesos2_pos ./ qtd_y_pos) ./ 2;
    
    % - Hidden layer
    % --- Calcular as derivadas parciais dos custos ate os pesos 1
    deriv_custos_outputs = deriv_custos_inputs * clf.pesos2(1 : end - 1, :)';
    deriv_outputs_inputs = deriv_leaky_relu(inputs_hidden_layer);
    deriv_custos_inputs = deriv_custos_outputs .* deriv_outputs_inputs;
    deriv_inputs_pesos = X;
    
    % --- Obter a media da influencia dos pesos 1 sobre os custos das duas classes
    grad_total_pesos1_neg = (deriv_custos_inputs(pos_y_neg, :)' * deriv_inputs_pesos(pos_y_neg, :))';
    grad_total_pesos1_pos = (deriv_custos_inputs(pos_y_pos, :)' * deriv_inputs_pesos(pos_y_pos, :))';
    grad_medio_pesos1 = (grad_total_pesos1_neg ./ qtd_y_neg + grad_total_pesos1_pos ./ qtd_y_pos) ./ 2;
      
    % - Aplicar o negativo do gradiente aos pesos, controlado pela taxa de aprendizado
    clf.pesos2 -= grad_medio_pesos2 .* taxa_aprendizado;
    clf.pesos1 -= grad_medio_pesos1 .* taxa_aprendizado;
  end
endfunction
