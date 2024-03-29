function pontuacao_final = prever_teste(X, y, X_teste, y_teste, metodo, params, basepreproc)
  fprintf("Gerando curvas de aprendizado para metodo %s.\n", metodo);
  
  % ========= Curvas de aprendizado =========      
  % Separa amostras positivas de negativas    
  X_pos = X(find(y == 1), :);
  qt_pos = size(X_pos, 1);
  y_pos = ones(qt_pos, 1);
  
  X_neg = X(find(y == 0), :);
  qt_neg = size(X_neg, 1);
  y_neg = zeros(qt_neg, 1);
  
  % Calcula proporcao entre classes
  ratio = ceil(qt_neg/qt_pos);
  
  % Gera indices aleatorios para selecionar amostras
  randind_pos = randperm(qt_pos);
  randind_neg = randperm(qt_neg);
  
  % Inicializa variaveis
  passo = qt_pos;
  pontuacoes_treino = zeros(1, ceil(qt_pos/passo));
  pontuacoes_teste = zeros(size(pontuacoes_treino));
  qt_amostras = zeros(size(pontuacoes_treino));
  i = 1;
  
  % Realiza a predicao aumentando o treinamento em 10 amostras positivas por iteracao  
  total_pos = 0;
  total_neg = 0;
  while total_pos < qt_pos      
    total_pos = min(qt_pos, total_pos + passo);
    total_neg = min(qt_neg, total_neg + ratio * passo);
    
    X_reduzido = [X_pos(randind_pos(1:total_pos),:); X_neg(randind_neg(1:total_neg),:)];
    y_reduzido = [y_pos(randind_pos(1:total_pos),:); y_neg(randind_neg(1:total_neg),:)];
    
    % Treina
    clf = eval(strcat(metodo, "_treinar(X_reduzido, y_reduzido, params)"), "NaN");
    % Preve
    pred_treino = eval(strcat(metodo, "_prever(X_reduzido, clf)"), "NaN");
    pred_teste = eval(strcat(metodo, "_prever(X_teste, clf)"), "NaN");
    
    % Calcula o score e armazena
    pontuacoes_treino(i) = pontuacao_desafio(y_reduzido, pred_treino);
    pontuacoes_teste(i) = pontuacao_desafio(y_teste, pred_teste);
    qt_amostras(i) = total_pos + total_neg;
    i += 1;
  endwhile
  
  % Gera as curvas de aprendizado
  %fig = figure();
  %set(fig, "visible", "off");
  %subplot(1, 2, 1)
  %plot(qt_amostras, pontuacoes_treino);
  %title("Treinamento");  
  %xlabel("Qt. amostras");
  %ylabel("Erro");
  %subplot(1, 2, 2)
  %plot(qt_amostras, pontuacoes_teste);
  %title("Teste");
  %xlabel("Qt. amostras");
  %ylabel("Erro");  
  %print(fig, strcat("metodos/outputs/curva_aprendizado_", metodo, ".jpg"), "-djpg");
  
  % ========= Medidas de desempenho da base completa =========         
  % Calcula medidas de desempenho
  [acc, prec, rec, f1] = pontuacao_medidas_avaliacao(y_teste, pred_teste);
  pontuacao_final = pontuacoes_teste(end);
  
  fprintf("Para o metodo %s foram obtidos os seguintes resultados:\n", metodo);
  fprintf("\tDesafio: %d\n", pontuacao_final);
  fprintf("\tAcuracia: %.2f\n", acc);
  fprintf("\tPrecisao: %.4f\n", prec);
  fprintf("\tRevocacao: %.4f\n", rec);
  fprintf("\tF-Medida: %.4f\n\n", f1);  
  
  save(strcat("metodos/outputs/", basepreproc, "_resultados_", metodo, ".mat"), "pontuacao_final", "acc", "prec", "rec", "f1", "-mat");
endfunction