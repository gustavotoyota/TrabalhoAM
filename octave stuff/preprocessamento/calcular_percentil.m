% Calcula o Percentil P entre todos valores da matriz

% ENTRADA
%    valores = [MxN] valores sobre os quais se pretende calcular o percentil
%          P = [1x1] percentil variando de em (0,100). 50 corresponde a mediana

% SAIDA
%  percentil = [1x1] percentis P

function percentil = calcular_percentil(valores, P, dimensao)    
  % Captura quantidade de valores
  qtd_valores = prod(size(valores));
  
  % Ordenar valores
  valores = sort(valores);
  
  % Calcular percentil
  indice_percentil = qtd_valores*(P/100);  
  if floor(indice_percentil)==indice_percentil    
    percentil = (valores(indice_percentil) + valores(indice_percentil + 1)) / 2;
  else
    percentil = valores(ceil(indice_percentil));
  end 
end  
