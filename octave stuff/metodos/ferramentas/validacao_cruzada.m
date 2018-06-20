function [pontuacao, clf] = validacao_cruzada(X, y, metodo, train_split, test_split, opcoes)

  pontuacao = 0;  
  pontuacao_minima = NaN;

  % Itera cada fold
  for k = 1:size(train_split,1)
    %fprintf("k %d/%d\n", k, size(train_split)(1));
  
    % Monta as amostras de treino 
    indices_treino = train_split(k, :);
    indices_treino(find(indices_treino==-1)) = [];
    X_treino = X(indices_treino, :);
    y_treino = y(indices_treino, :);
    
    % Monta as amostras de teste
    indices_teste = test_split(k, :);
    indices_teste(find(indices_teste==-1)) = [];
    X_teste = X(indices_teste, :);    
    y_teste = y(indices_teste, :);
    
    % Chama a funcao de treino    
    clf_k = eval(strcat(metodo, "_treinar(X_treino, y_treino, opcoes)"), "NaN");
    
    % Chama a funcao de teste
    pred = eval(strcat(metodo, "_prever(X_teste, clf_k)"), "NaN");
    
    if isnan(pred)
      pontuacao = Inf;
      clf = NaN;
      return;
    endif
    
    % Verifica a pontuacao
    pontuacao_k = pontuacao_desafio(y_teste, pred);
    pontuacao += pontuacao_k;       
      
    % Armazena o theta e historico do melhor resultado
    if isnan(pontuacao_minima) || pontuacao_minima > pontuacao_k
      pontuacao_minima = pontuacao_k;
      clf = clf_k;
    endif   
  endfor
  
  % Retorna a pontuacao media
  pontuacao /= size(train_split, 1);
endfunction
