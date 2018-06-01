function svmstats(base_teste_label, predicted_labels)

[m, n] = size(base_tese_label);

acertospos = 0;
errospos = 0;
acertosneg = 0;
errosneg = 0;
for i=1:m
  if base_teste_label(i) == 1
    if predicted_labels(i) == 1
      acertospos++;
    else
      errospos++;
    endif
  else
    if predicted_labels(i) == 0
      acertosneg++;
    else
      errosneg++;
    endif
  endif
endfor

printf("Acertos de positivos: %d\nErros de positivos: %d\nPorcentagem de acertos dos positivos: %f\n", acertospos, errospos, acertospos / (acertospos+errospos) * 100);
printf("Acertos de negativos: %d\nErros de negativos: %d\nPorcentagem de acertos dos negativos: %f\n", acertosneg, errosneg, acertosneg / (acertosneg+errosneg) * 100);

end