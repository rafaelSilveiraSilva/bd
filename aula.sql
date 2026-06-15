/* ==========================================================
   CRIAÇÃO DA TABELA PRODUTO
   ========================================================== */

CREATE TABLE produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo VARCHAR(50),
    desc_item VARCHAR(100),
    vl_preco DECIMAL(10, 2)
);

-- Cria a tabela de produtos
-- id_produto: identificador único gerado automaticamente
-- tipo: categoria do produto
-- desc_item: descrição do produto
-- vl_preco: preço do produto


/* ==========================================================
   CRIAÇÃO DA TABELA PEDIDO
   ========================================================== */

CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    dt_pedido DATE,
    fl_ketchup BOOLEAN,
    desc_uf CHAR(2),
    txt_recado TEXT
);

-- Cria a tabela de pedidos
-- id_pedido: identificador único do pedido
-- dt_pedido: data em que o pedido foi realizado
-- fl_ketchup: indica se o cliente pediu ketchup
-- desc_uf: estado do cliente
-- txt_recado: observações do pedido


/* ==========================================================
   CRIAÇÃO DA TABELA ITEM_PEDIDO
   ========================================================== */

CREATE TABLE item_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Tabela responsável por relacionar pedidos e produtos
-- Um pedido pode conter vários produtos
-- Um produto pode estar presente em vários pedidos
-- Chave primária composta por id_pedido e id_produto
-- Chaves estrangeiras garantem integridade dos dados


/* ==========================================================
   INSERÇÃO DE PRODUTOS
   ========================================================== */

INSERT INTO
produto (tipo, desc_item, vl_preco)
VALUES
('ingrediente', 'camarão', 6),
('massa', 'tradicional', 9.25),
('borda', 'tradicional', 0),
('queijo', 'muçarela', 4),
('bebida', 'refrigerante', 5);

-- Insere cinco produtos na tabela produto
-- Cada linha representa um item disponível para venda


/* ==========================================================
   INSERÇÃO DE PEDIDO
   ========================================================== */

INSERT INTO
pedido (dt_pedido, fl_ketchup, desc_uf, txt_recado)
VALUES
('2023-06-01', TRUE, 'MG', 'Capricha no queijo!');

-- Cria um pedido realizado em 01/06/2023
-- Cliente solicitou ketchup
-- Cliente é do estado de Minas Gerais
-- Recado: Capricha no queijo!


/* ==========================================================
   INSERÇÃO DOS ITENS DO PEDIDO
   ========================================================== */

INSERT INTO item_pedido (
    id_pedido,
    id_produto,
    quantidade
)
VALUES(
    :id_pedido,
    :id_produto,
    :qtd
);

-- Relaciona produtos a um pedido
-- Define a quantidade de cada produto comprado


/* ==========================================================
   CONSULTA DE TODOS OS PRODUTOS
   ========================================================== */

SELECT *
FROM produto;

-- Retorna todos os registros da tabela produto
-- Exibe todas as colunas cadastradas


/* ==========================================================
   LISTAR TABELAS EXISTENTES NO BANCO
   ========================================================== */

SELECT name
FROM sqlite_schema
WHERE type='table';

-- Consulta o catálogo interno do SQLite
-- Exibe todas as tabelas existentes no banco


/* ==========================================================
   CONSULTAR TODOS OS REGISTROS DE UMA TABELA
   ========================================================== */

SELECT *
FROM nome_da_tabela;

-- Recupera todos os registros de uma tabela específica


/* ==========================================================
   EXCLUSÃO DE DADOS
   ========================================================== */

DELETE FROM item_pedido;
DELETE FROM pedido;
DELETE FROM produto;

-- Remove todos os registros das tabelas
-- A estrutura das tabelas permanece intacta


/* ==========================================================
   CONSULTA COM FILTRO
   ========================================================== */

SELECT *
FROM pedido
WHERE id_pedido < 5;

-- Retorna apenas os pedidos cujo ID seja menor que 5


/* ==========================================================
   CONTAGEM DE PEDIDOS
   ========================================================== */

SELECT COUNT(id_pedido) AS count_id
FROM pedido;

-- Conta quantos pedidos existem na tabela pedido


/* ==========================================================
   EXIBIR ESTRUTURA DAS TABELAS
   ========================================================== */

SELECT sql
FROM sqlite_schema;

-- Exibe os comandos CREATE utilizados
-- para criar todas as tabelas do banco


/* ==========================================================
   CONSULTA SQLMODEL
   ========================================================== */

SELECT *
FROM pessoa
WHERE apelido = 'Tilipe';

-- Busca uma pessoa cujo apelido seja "Tilipe"


/* ==========================================================
   CONSULTA ANALÍTICA
   ========================================================== */

SELECT
    desc_uf,
    COUNT(*) AS count_pedidos
FROM pedido
GROUP BY desc_uf
ORDER BY count_pedidos DESC
LIMIT 5;

-- Agrupa os pedidos por estado (UF)
-- Conta quantos pedidos existem em cada estado
-- Ordena do maior para o menor número de pedidos
-- Exibe apenas os 5 estados com maior quantidade de pedidos
# ==========================================================
# FUNÇÃO PARA EXECUTAR COMANDOS SQL
# ==========================================================

from sqlite3 import Error

def execute_query(connection, query):
    cursor = connection.cursor()

    try:
        cursor.execute(query)

        # Salva alterações realizadas no banco
        connection.commit()

        print("Query executada.")

        # Exibe quantidade de linhas afetadas
        if cursor.rowcount != -1:
            print(f"{cursor.rowcount} linha(s) afetadas")

    except Error as e:
        print(f"Erro: '{e}'")


# ==========================================================
# EXECUÇÃO DE MÚLTIPLOS INSERTS
# ==========================================================

cursor.executemany(insert_item_pedido, itens)

# Executa o mesmo INSERT várias vezes
# Utiliza os dados armazenados na variável "itens"
# Muito útil para inserir vários registros de uma só vez


# ==========================================================
# FUNÇÃO PARA CONSULTAS SELECT
# ==========================================================

def execute_read_query(connection, query):
    cursor = connection.cursor()

    try:
        cursor.execute(query)

        result = cursor.fetchall()

        return result

    except Error as e:
        print(f"Erro: '{e}'")

# Executa consultas de leitura (SELECT)
# Retorna todos os registros encontrados
# Não altera os dados do banco