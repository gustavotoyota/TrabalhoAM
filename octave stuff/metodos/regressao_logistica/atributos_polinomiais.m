function X_novo = atributos_polinomiais(X, grau)
  X_novo = X;
  
  num_atributos = size(X,2)
  
  for atributo1 = 1:num_atributos
    for atributo2 = atributo1+1:num_atributos
      for i = 2:grau+1
        for j = 1:i-1
          X_novo(:,end+1) = (X(:, atributo1) .^ (i - j)) .* (X(:, atributo2) .^ j);
        end
      end
    end
  end
  
endfunction