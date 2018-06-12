% Carrega o CSV com a base de dados

% ENTRADA
%   arquivo_csv = nome do arquivo da base de dados
%          tipo = indicador se base eh de Treino ou Teste

% SAIDA
%   colunas_texto = grade com a base de dados da maneira que esta no CSV

function [colunas_texto] = carregar_colunas(arquivo_csv, tipo)
  fprintf('Carregando colunas de %s da base de dados.\n', tipo);
  
  % Caracteristicas da base
  num_colunas = 171;
  
  % Le o arquivo
	colunas_texto = cell(1, num_colunas);
	[colunas_texto{:}] = textread(strcat('preprocessamento/', tipo, '/', arquivo_csv), repmat('%s', [1, num_colunas]), 'Delimiter', ',');
  
  % Salva outputs
  save(strcat('preprocessamento/', tipo, '/outputs/carregar_colunas.mat'), 'colunas_texto', '-mat');
endfunction