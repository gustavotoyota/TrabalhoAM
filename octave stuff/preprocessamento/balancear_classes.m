function [X, y] = balancear_classes(X, y)
  fprintf('Balanceando classes com undersampling.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/remover_dados.mat', 'X', 'y', '-mat');
  end
  
  % Captura a classe majoritaria
  majoritaria = (sum(y) >= length(y) / 2);
  
  % Captura a diferenca entre classes
  diferenca = abs(length(y) - sum(y) * 2);
  
  % Captura indices da classe majoritaria 
  indices_majoritaria = find(y==majoritaria);
  
  % Ordena os indices aleatoriamente e seleciona quais amostras serao removidas
  amostras_removidas = indices_majoritaria(randperm(length(indices_majoritaria))(1:diferenca));
  
  % Remove as amostras
  X(amostras_removidas,:) = [];
  y(amostras_removidas) = [];
  
  % Salvar outputs
  save('preprocessamento/balancear_classes.mat', 'X', 'y', '-mat');
end  
