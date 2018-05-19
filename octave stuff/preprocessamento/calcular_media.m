function media = calcular_media(valores)
  media = 0;
  
  total_valores = prod(size(valores));
  
  soma_acumulada = 0;
  
  indice_valor = 1;
  
  while indice_valor <= total_valores
    while soma_acumulada < total_valores && indice_valor <= total_valores
      soma_acumulada = soma_acumulada + valores(indice_valor);
      
      indice_valor = indice_valor + 1;
    end
    
    media = media + soma_acumulada / total_valores;
    soma_acumulada = 0;
  end
end