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

$ zzmariadb 28


Sintaxe:

START TRANSACTION [WITH CONSISTENT SNAPSHOT] | BEGIN [WORK]
COMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
ROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
SET autocommit = {0 | 1}

Descrição:

   A instrução START TRANSACTION ou a instrução BEGIN, começam uma nova transação. COMMIT finaliza a transação atual fazendo permanentes as alterações. ROLLBACK faz uma reversão da transação atual, cancelando as alterações. A instrução de autocommit SET desativa ou habilita o modo padrão de
   autocommit para a sessão atual.

   A palavra-chave opcional WORK é suportada por COMMIT e ROLLBACK, assim como pelas cláusulas CHAIN e RELEASE. CHAIN e RELEASE podem ser usadas para controle adicional sobre a conclusão da transação. O valor da variável de sistema completion_type determina o comportamento padrão da conclusão.
   Veja server system variables.

   A cláusula AND CHAIN faz com que uma nova transação comece assim que a transação atual terminar, e a nova transação tem o mesmo nível de isolamento da transação que acabou de terminar. A cláusula RELEASE faz com que o servidor desligue a sessão cliente atual após ter terminado a transação
   atual. Incluir a palavra-chave NO suprime o término de CHAIN ou RELEASE, o que pode ser útil se a variável de sistema completion_type for definida para obter encadeamento ou liberar o encerramento por padrão.

   Por padrão, MySQL se executa com o modo autocommit habilitado. Isto significa que assim que você executar uma instrução que atualize (altere) uma tabela, MariaDB armazena a atualização em disco para fazê-la permanente. Para desativar o modo autocommit, use a seguinte instrução:
SET autocommit=0;

   Após ter desativado o modo autocommit, definindo a variável autocommit para zero, as alterações nas tabelas transaction-safe (tais como aquelas para InnoDB ou NDBCLUSTER) não são feitas permanentes imediatamente. Você deve usar COMMIT para armazenar suas alterações em disco, ou ROLLBACK
   para ignorá-las.

   Para desativar o modo autocommit para uma única série de instruções, use a instrução START TRANSACTION:

Exemplos:

START TRANSACTION;
SELECT @A:=SUM(salary) FROM table1 WHERE type=1;
UPDATE table2 SET summary=@A WHERE type=1;
COMMIT;

     * ← Sobre o Mariadb
     * ↑ MariaDB - Brazilian Portuguese ↑

$

$ zzmariadb 18


Sintaxe:

DROP USER user [, user] ...

Descrição:

   A instrução DROP USER remove uma ou varias contas MariaDB. Remove filas privilegiadas da conta desde todas as tabelas de permissão. Para usar esta instrução, você deve ter o privilégio global CREATE USER ou o privilégio DELETE para o banco de dados mysql. Cada conta é nomeada usando o mesmo
   formato que na instrução CREATE USER; por exemplo, 'jeffrey'@'localhost'. Se você somente especificar a parte do nome de usuário no nome de conta, uma parte do hostname de '%' será usada. Para informações adicionais sobre especificação de nomes de conta, veja CREATE USER.

   Se alguma das contas de usuário especificadas não existe, aparecerá ERROR 1396 (HY000). Se um erro ocorrer, DROP USER ainda irá suprimir as contas que não resultam em erro.
     * ← DEALLOCATE / DROP prepared statement
     * ↑ MariaDB - Brazilian Portuguese ↑
     * Executando o MariaDB a partir do diretório fonte →

$
