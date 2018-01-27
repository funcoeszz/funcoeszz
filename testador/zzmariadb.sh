$ zzmariadb
1 ALTER DATABASE
2 ALTER EVENT
3 ALTER FUNCTION
4 ALTER LOGFILE GROUP
5 ALTER PROCEDURE
6 ALTER SERVER
7 ALTER TABLE
8 ALTER TABLESPACE
9 ALTER VIEW
10 CONSTRAINT
11 CREATE DATABASE
12 CREATE EVENT
13 CREATE FUNCTION
14 CREATE INDEX
15 CREATE SERVER
16 CREATE USER
17 DEALLOCATE / DROP prepared statement
18 DROP USER
19 EXECUTE statement
20 GRANT
21 HELP command
22 ISOLAMENTO
23 LOCK
24 MERGE
25 RENAME USER
26 REVOKE
27 SAVEPOINT
28 START TRANSACTION
$

$ zzmariadb create
11 CREATE DATABASE
12 CREATE EVENT
13 CREATE FUNCTION
14 CREATE INDEX
15 CREATE SERVER
16 CREATE USER
$

$ zzmariadb 27 | sed 's/^ *//'
Sintaxe:

SAVEPOINT identificador
ROLLBACK [WORK] TO [SAVEPOINT] identificador
RELEASE SAVEPOINT identificador

Descrição:

InnoDB suporta as instruções SQL SAVEPOINT, ROLLBACK TO SAVEPOINT, RELEASE SAVEPOINT e a palavra-chave opcional WORK para o ROLLBACK.
$

$ zzmariadb 18 | sed -n '1,/^Exemplo/{/Exemplo/d;p;}'
Sintaxe

DROP USER [IF EXISTS] user [, user] ...

Descrição

   A instrução DROP USER remove uma ou varias contas MariaDB. Remove filas privilegiadas da conta desde todas as tabelas de permissão. Para usar esta instrução, você deve ter o privilégio global CREATE USER ou o privilégio DELETE para o banco de dados mysql. Cada conta é nomeada usando o mesmo
   formato que na instrução CREATE USER; por exemplo, 'jeffrey'@'localhost'. Se você somente especificar a parte do nome de usuário no nome de conta, uma parte do hostname de '%' será usada. Para informações adicionais sobre especificação de nomes de conta, veja CREATE USER.

   Se alguma das contas de usuário especificadas não existe, aparecerá ERROR 1396 (HY000). Se um erro ocorrer, DROP USER ainda irá suprimir as contas que não resultam em erro.

$
