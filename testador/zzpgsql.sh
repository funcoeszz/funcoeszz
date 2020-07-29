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
NNN ALTER PUBLICATION — change the definition of a publication
NNN ALTER ROLE — change a database role
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
COMMIT
COMMIT — commit the current transaction
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
