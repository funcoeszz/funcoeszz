$ zzpgsql alter
  2 ALTER AGGREGATE -- change the definition of an aggregate function
  3 ALTER COLLATION -- change the definition of a collation
  4 ALTER CONVERSION -- change the definition of a conversion
  5 ALTER DATABASE -- change a database
  6 ALTER DEFAULT PRIVILEGES -- define default access privileges
  7 ALTER DOMAIN -- change the definition of a domain
  8 ALTER EVENT TRIGGER -- change the definition of an event trigger
  9 ALTER EXTENSION -- change the definition of an extension
 10 ALTER FOREIGN DATA WRAPPER -- change the definition of a foreign-data wrapper
 11 ALTER FOREIGN TABLE -- change the definition of a foreign table
 12 ALTER FUNCTION -- change the definition of a function
 13 ALTER GROUP -- change role name or membership
 14 ALTER INDEX -- change the definition of an index
 15 ALTER LANGUAGE -- change the definition of a procedural language
 16 ALTER LARGE OBJECT -- change the definition of a large object
 17 ALTER MATERIALIZED VIEW -- change the definition of a materialized view
 18 ALTER OPERATOR -- change the definition of an operator
 19 ALTER OPERATOR CLASS -- change the definition of an operator class
 20 ALTER OPERATOR FAMILY -- change the definition of an operator family
 21 ALTER ROLE -- change a database role
 22 ALTER RULE -- change the definition of a rule
 23 ALTER SCHEMA -- change the definition of a schema
 24 ALTER SEQUENCE -- change the definition of a sequence generator
 25 ALTER SERVER -- change the definition of a foreign server
 26 ALTER SYSTEM -- change a server configuration parameter
 27 ALTER TABLE -- change the definition of a table
 28 ALTER TABLESPACE -- change the definition of a tablespace
 29 ALTER TEXT SEARCH CONFIGURATION -- change the definition of a text search configuration
 30 ALTER TEXT SEARCH DICTIONARY -- change the definition of a text search dictionary
 31 ALTER TEXT SEARCH PARSER -- change the definition of a text search parser
 32 ALTER TEXT SEARCH TEMPLATE -- change the definition of a text search template
 33 ALTER TRIGGER -- change the definition of a trigger
 34 ALTER TYPE -- change the definition of a type
 35 ALTER USER -- change a database role
 36 ALTER USER MAPPING -- change the definition of a user mapping
 37 ALTER VIEW -- change the definition of a view
$

$ zzpgsql commit
 44 COMMIT -- commit the current transaction
 45 COMMIT PREPARED -- commit a transaction that was earlier prepared for two-phase commit
122 END -- commit the current transaction
134 PREPARE TRANSACTION -- prepare the current transaction for two-phase commit
142 ROLLBACK PREPARED -- cancel a transaction that was earlier prepared for two-phase commit
$

$ zzpgsql 44

COMMIT

Name

   COMMIT -- commit the current transaction

Synopsis

COMMIT [ WORK | TRANSACTION ]

Description

   COMMIT commits the current transaction. All changes made by the transaction become visible to others and are guaranteed to be durable if a crash occurs.

Parameters

   WORK
          TRANSACTION
          Optional key words. They have no effect.

Notes

   Use ROLLBACK to abort a transaction.

   Issuing COMMIT when not inside a transaction does no harm, but it will provoke a warning message.

Examples

   To commit the current transaction and make all changes permanent:
COMMIT;

Compatibility

   The SQL standard only specifies the two forms COMMIT and COMMIT WORK. Otherwise, this command is fully conforming.

See Also

   BEGIN, ROLLBACK
$
