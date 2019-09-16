# TLB_variable_page_size_simulation

## create_pmaps_numbered.sh
Precisa ser executado no diretorio onde estaos os arquivos "pmap-\*.txt".
Concatena os pmaps e insere e numero dos segmentos de acordo com o arquivo em que foram encontrados.
```
./create_pmaps_numbered.sh
```

## transform_pmap.py
Transforma o pmaps.txt em um pmap 'tratado', ou seja, com os segmentos em bordas de 2^n e de tamnho 2^n
```
python transform_pmap.py pmaps.txt pmaps_tratados.txt
```
## transform_traces.py
Transforma os traces com base no pmap 'tratado'
```
python transform_traces.py pmaps_tratados.txt tracefile-trace-00000.txt.gz
```

## clean_pmap.py
Transforma o pmap 'tratado' em um PT, limpando informações desnecessárias. Essa PT será uma entrada para o simulador.
```
python clean_pmap.py pmaps_tratados.txt
```
## main.cr
Simula o comportamento da TLB com a PT contuda em pt.txt e uma lista de endereços acessados.
```
crystal run main.cr -- lista_enderecos.txt pt.txt tamanho_da_TLB
```
