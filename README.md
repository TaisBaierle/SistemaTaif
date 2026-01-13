# Sistema Taif - Gestão de Sorteio e Vendas 

Este projeto foi desenvolvido para solucionar um desafio técnico da empresa **Taif**. O objetivo é gerenciar um banco de dados automotivo e implementar a lógica de um sorteio de crédito de R$ 50,00 para clientes afetados por problemas técnicos no modelo Marea.

## Contexto do Projeto

A Taif decidiu compensar os proprietários do modelo Marea através de um sorteio. O sistema deve ser capaz de filtrar os vencedores com base em critérios rigorosos de venda e perfil, além de realizar operações de CRUD e consultas estatísticas no banco de dados.

### Regras de Negócio do Sorteio
Para ser elegível ao prêmio, o cliente deve cumprir os seguintes requisitos:
1. **Limite de Ganhadores:** Apenas os 15 primeiros clientes (por ordem de data de venda).
2. **Filtro de Documento:** O CPF do cliente deve começar obrigatoriamente com o dígito **0**.
3. **Ano de Lançamento:** Apenas carros com data de lançamento em **2021**.
4. **Desqualificação:** Clientes que compraram dois ou mais carros do modelo Marea são automaticamente desclassificados.

## Requisitos Técnicos Implementados

### 1. Banco de Dados (SQL)
O projeto inclui scripts SQL para:
* Criação das tabelas base do sistema.
* Consulta da quantidade total de vendas do modelo **Marea**.
* Relatório de vendas do modelo **Uno** agrupado por cliente.
* Identificação de clientes que nunca realizaram uma compra.
* Query complexa para identificar os **Clientes Sorteados** seguindo todas as regras de negócio.
* Remoção de registros de vendas de clientes não contemplados (sem o uso do comando `IN`).

### 2. Programação Orientada a Objetos
A estrutura de código segue os seguintes requisitos:
* **Mapeamento de Classes:** Uma classe para cada tabela do banco de dados.
* **Persistência Fictícia:** Implementação dos métodos:
    * `InserirDadosBD()`: Para inserção de novos registros.
    * `ExecutarSql()`: Para carregamento e consulta de dados.
* **Funcionalidades de Cadastro:**
    * Inserção em lote de novos clientes.
    * Inserção em lote de 5 novos modelos de carros.
    * Registro de vendas vinculando os novos clientes aos novos modelos.

## Tecnologias Utilizadas

* **Linguagem:** Foi utilizado o Delphi 12, utilizado a IDE na sua versão Community;
* **Banco de Dados:** Foi utilizado o banco de dados relacional Firebird 5.0
* **Paradigma:** Orientação a Objetos (POO)

## Como Explorar o Repositório

1.  Localizados na pasta `/DAO`, temos as instruções de CRUD do programada, como SELECTs, INSERTs e DELETE.
2.  Localizadas na pasta `/Models`, temos as entidades de Clientes, Carros e Vendas.
3.  Localizados na pasta `/Infra`, temos o datamodule, com os componentes de conexão, e todas as units auxiliáres para conexão com o banco de dados.
4.  Localizados na pasta `/Service`, temos a implementação da "regra de negócio", portanto temos a chamada da criação de uma venda, do cadastro de um cliente ou de um carro.
5.  Temos dois forms, um deles é o form de conexão com o banco de dados, e o outro é o form principal, com os filtros e exibição dos dados;
6.  Ainda temos a UDFUtils e a UDFConstantes, como UDFs genéricas, com recursos e funcionalidades mais abrangentes;
7.  Existe, junto dos arquivos, um banco de dados SORTEIO.FDB. Banco sem tabelas criado em Firebird 5.0, com a o usuário SYSDBA e senha masterkey. Existem procedures no programa que criam as tabelas.

## Funcionamento do programa

1. Para o funcionamento do programa, é muito importante ter um banco de dados firebird 5.0 criado sem nenhuma tabela, somente o banco.
2. Também é necessário colocar junto a pasta do executável do programa, a dll de conexão com o firebird 5.0, a 'fbclient.dll', essa dll está junto com os fontes neste repositório. Lembrando que é a versão de firebird utilizada é a 5.0.3 x86;
3. Quando compilado e aberto pela primeira vez, o programa vai solicitar para que o banco de dados seja apontado, então o é necessário apontar o banco de dados vazio, e informar o usuário e senha do firebird atribuídos na instalação.
4. Após isso, o sistema se fecha e quando foi aberto de novo, vai abrir a tela do programa em si;
5. Dentro da pasta do executável, vai existir um arquivo chamado 'config.ini', onde guarda o caminho do banco de dado.
6. Na tela princípal do programa, é onde será possíve fazer os filtros.

<img width="825" height="659" alt="Sem título" src="https://github.com/user-attachments/assets/675384c9-8ac4-4d4a-90a2-851323f3051d" />

<img width="825" height="659" alt="Sem título" src="https://github.com/user-attachments/assets/9707b7cf-a924-44a6-bbec-3b8e0f142f87" />

<img width="825" height="659" alt="Sem título" src="https://github.com/user-attachments/assets/f5c2bc56-ce02-4bc2-a38e-475122d9c729" />

