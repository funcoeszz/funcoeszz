$ zzora
Uso: zzora numero_erro
$ zzora 1234
cannot end backup of file string - file is in use or recovery

Cause: Attempted to end an online backup of file when the file is busy. Some operation such as recovery or rename may be active, or there may still be some instance that has the database open with this file online.

Action: If there is an instance with the database open then the backup can be ended there by using the ALTER TABLESPACE command. Otherwise wait for the completion of the other operation.
$
