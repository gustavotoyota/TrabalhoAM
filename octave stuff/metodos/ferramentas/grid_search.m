function [melhores_params, classificador] = grid_search(X, y, metodo, train_split, test_split, params)
  
  % Inicializa resultado_minimo
  pontuacao_minima = NaN;

  % Captura o numero de parametros
  num_params = numel(fieldnames(params));
  
  % Monta a chamada da funcao ndgrid
  funcao = "ndgrid(";
  for indice_param = 1:num_params
    funcao = strcat(funcao, "params.", fieldnames(params){indice_param:indice_param}, ",");
  end
  funcao = strcat(funcao(1:end-1), ")");
    
  % Cria as matrizes para o grid search
  params_grid_search = cell(1, num_params);
  [params_grid_search{:}] = eval(funcao, "NaN");

  % Ve o numero de combinacoes possiveis de parametros
  dimensao_grid = prod(size(params_grid_search{1:1}));
  
  % Executa o grid_search
  for indice_grid = 1:dimensao_grid
    fprintf("Grid %d/%d\n", indice_grid, dimensao_grid);
  
    % Monta a struct de opcoes
    for indice_param = 1:num_params
      opcao = strcat("opcoes.", fieldnames(params){indice_param:indice_param}, " = ", num2str(params_grid_search{indice_param:indice_param}(indice_grid)), ";");
      eval(opcao, "NaN");
    end
    
    % Chama a validacao cruzada
    [pontuacao_temp, classificador_temp] = validacao_cruzada(X, y, metodo, train_split, test_split, opcoes);
    
    fprintf("Pontuacao: %d\n", pontuacao_temp);
    
    % Armazena o melhor resultado
    if isnan(pontuacao_minima) || (pontuacao_minima > pontuacao_temp)
      pontuacao_minima = pontuacao_temp;
      classificador = classificador_temp;
      melhores_params = opcoes;
    end
  end
end
