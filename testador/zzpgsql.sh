$ zzpgsql alter | sed 's/.../NNN/'
NNN ALTER AGGREGATE — change the definition of an aggregate function
NNN ALTER COLLATION — change the definition of a collation
NNN ALTER CONVERSION — change the definition of a conversion
NNN ALTER DATABASE — change a database
NNN ALTER DEFAULT PRIVILEGES — define default access privileges
NNN ALTER DOMAIN — change the definition of a domain
NNN ALTER EVENT TRIGGER — change the definition of an event trigger
NNN ALTER EXTENSION — change the definition of an extension
NNN ALTER FOREIGN DATA WRAPPER — change the definition of a foreign-data wrapper
NNN ALTER FOREIGN TABLE — change the definition of a foreign table
NNN ALTER FUNCTION — change the definition of a function
NNN ALTER GROUP — change role name or membership
NNN ALTER INDEX — change the definition of an index
NNN ALTER LANGUAGE — change the definition of a procedural language
NNN ALTER LARGE OBJECT — change the definition of a large object
NNN ALTER MATERIALIZED VIEW — change the definition of a materialized view
NNN ALTER OPERATOR — change the definition of an operator
NNN ALTER OPERATOR CLASS — change the definition of an operator class
NNN ALTER OPERATOR FAMILY — change the definition of an operator family
NNN ALTER POLICY — change the definition of a row level security policy
NNN ALTER PROCEDURE — change the definition of a procedure
NNN ALTER PUBLICATION — change the definition of a publication
NNN ALTER ROLE — change a database role
NNN ALTER ROUTINE — change the definition of a routine
NNN ALTER RULE — change the definition of a rule
NNN ALTER SCHEMA — change the definition of a schema
NNN ALTER SEQUENCE — change the definition of a sequence generator
NNN ALTER SERVER — change the definition of a foreign server
NNN ALTER STATISTICS — change the definition of an extended statistics object
NNN ALTER SUBSCRIPTION — change the definition of a subscription
NNN ALTER SYSTEM — change a server configuration parameter
NNN ALTER TABLE — change the definition of a table
NNN ALTER TABLESPACE — change the definition of a tablespace
NNN ALTER TEXT SEARCH CONFIGURATION — change the definition of a text search configuration
NNN ALTER TEXT SEARCH DICTIONARY — change the definition of a text search dictionary
NNN ALTER TEXT SEARCH PARSER — change the definition of a text search parser
NNN ALTER TEXT SEARCH TEMPLATE — change the definition of a text search template
NNN ALTER TRIGGER — change the definition of a trigger
NNN ALTER TYPE — change the definition of a type
NNN ALTER USER — change a database role
NNN ALTER USER MAPPING — change the definition of a user mapping
NNN ALTER VIEW — change the definition of a view
$

$ zzpgsql commit | sed 's/.../NNN/'
NNN COMMIT — commit the current transaction
NNN COMMIT PREPARED — commit a transaction that was earlier prepared for two-phase commit
NNN END — commit the current transaction
NNN PREPARE TRANSACTION — prepare the current transaction for two-phase commit
NNN ROLLBACK PREPARED — cancel a transaction that was earlier prepared for two-phase commit
$

$ zzpgsql 48 | sed '/^ *$/d; s/^ *//'
CLOSE
CLOSE — close a cursor
Synopsis
CLOSE { name | ALL }
Description
CLOSE frees the resources associated with an open cursor. After the cursor is closed, no subsequent operations are allowed on it. A cursor should be closed when it is no longer needed.
Every non-holdable open cursor is implicitly closed when a transaction is terminated by COMMIT or ROLLBACK. A holdable cursor is implicitly closed if the transaction that created it aborts via ROLLBACK. If the creating transaction successfully commits, the holdable cursor remains open until
an explicit CLOSE is executed, or the client disconnects.
Parameters
name
The name of an open cursor to close.
ALL
Close all open cursors.
Notes
PostgreSQL does not have an explicit OPEN cursor statement; a cursor is considered open when it is declared. Use the DECLARE statement to declare a cursor.
You can see all available cursors by querying the pg_cursors system view.
If a cursor is closed after a savepoint which is later rolled back, the CLOSE is not rolled back; that is, the cursor remains closed.
Examples
Close the cursor liahona:
CLOSE liahona;
Compatibility
CLOSE is fully conforming with the SQL standard. CLOSE ALL is a PostgreSQL extension.
See Also
DECLARE, FETCH, MOVE
$
