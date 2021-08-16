Explorando Marte - [desafio técnico Xerpay](https://docs.google.com/document/d/1vJsir72GlnCbilZ-qYV2pm11MbzHohIMtjas1SiZB2w/edit#).

## Índice

- [Explorando marte](#explorando_marte)
- [Execução](#execução)
- [Testes](#testes)
- [Referências](#referências)

## Explorando Marte

Um conjunto de sondas foi enviado pela NASA à Marte e irá pousar num planalto. Esse planalto, que curiosamente é retangular, deve ser explorado pelas sondas para que suas câmeras embutidas consigam ter uma visão completa da área e enviar as imagens de volta para a Terra.

## Execução

No diretório do projeto abra o terminal, execute comando `mix start` e selecione o modo de lançamento:

```shell
Enter launch mode:
1 - Read file
2 - Enter cordinates
3 - Abort mission
Which mode? [1,2,3]
```

> `1 - Read file` - Executa instruções do arquivo `cordinates.txt` e exibe o resultado.

```shell
Confirm: Read file [Yn]
1 3 N
5 1 E
"Launch successful."
```

> `2 - Enter cordinates` - Informa manualmente coordenadas para o lançamento da sonda.

```shell
Confirm: Enter cordinates [Yn]
Surface: 5 5
Initial Position: 1 2 N
Cordinates: LMLMLMLMM
1 3 N
```

> `3 - Abort mission` - Para execução.

## Testes

### Entradas

```shell
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

### Saídas

```shell
1 3 N
5 1 E
```

Comando para execução dos testes:

```sh
mix test
```

## Referências

### Livros

- [Learn Functional Programming With Elixir](https://pragprog.com/titles/cdc-elixir/learn-functional-programming-with-elixir/)
- [Programming Elixir 1.6](https://pragprog.com/titles/elixir16/programming-elixir-1-6/)

### Sites

- [Elixir School](https://elixirschool.com/pt/)
- [Elixir lang](https://elixir-lang.org/getting-started/introduction.html)
