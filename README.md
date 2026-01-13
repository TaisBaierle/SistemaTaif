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

1.  **SQL Scripts:** Localizados na pasta `/sql`, contêm a criação das tabelas e as consultas de sorteio.
2.  **Classes de Modelo:** Localizadas em `/Models`, representam as entidades de Clientes, Carros e Vendas.
3.  **Lógica de Inserção:** Verifique o arquivo principal para ver a execução dos métodos fictícios de banco de dados.
