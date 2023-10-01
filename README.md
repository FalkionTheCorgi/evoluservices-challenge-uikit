# Desafio Evoluservices UIkit

## Sobre

- [Breve Descrição](#breve-descrição)
- [Tecnologias](#tecnologias)
- [Como Utilizo o Projeto?](#como-utilizo-o-projeto)
- [Obrigatórios](#obrigatórios)
- [Observações](#observações)
- [Créditos](#créditos)

## [Breve Descrição](#sobre)

Esse desafio tem como objetivo criar uma lista de tarefas pelo usuário e armazena-las na aplicação para consulta.

## [Tecnologias](#sobre)

Esse aplicativo utilizou as seguintes tecnologias:

- Swift
- UIkit
- [Combine](https://developer.apple.com/documentation/combine)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [CoreData](https://developer.apple.com/documentation/coredata/)

## [Como Utilizo o Projeto?](#sobre)

- Para utilizar o projeto será necessário baixar o projeto ou fazer o git clone do repositório.
- Após isso abrir o projeto pelo arquivo "ProjetoTeste.xcworkspace" e a partir disso compilar no seu simulador do Iphone de sua preferência. 

## [Obrigatórios](#sobre)

- [x] Visualizar tarefa: ao tocar em uma tarefa na lista, o usuário pode visualizar o título, a descrição e a data de criação da tarefa.
- [x] Adicionar tarefa: o usuário pode adicionar uma nova tarefa, fornecendo um título e uma descrição. 
- [x] Editar tarefa: o usuário pode editar o título e a descrição de uma tarefa existente.
- [x] Excluir tarefa: o usuário pode excluir uma tarefa existente.
- [x] Persistência de dados: carregar a lista de tarefas previamente salvas no app.

## [Observações](#sobre)

- A Modal responsável por adicionar e editar os itens responde a abertura e fechamento do teclado, se tentar usar os campos sem o teclado habilitado no simulador a view pode acabar sumindo, então se for usar a tela de adicionar e editar o item, lembrar de habilitar o teclado.
- Foi utilizado o emulador do "Iphone 15 Pro" para o desenvolvimento  da solução.

## [Créditos](#sobre)

Esse desafio foi disponibilizado pela [Evoluservices](https://br.evoluservices.com).
