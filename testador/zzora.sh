$ zzora
Uso: zzora numero_erro
$ zzora 1234 | sed '/^[[:blank:]]*$/d'
ORA-01234 cannot end backup of file string - file is in use or recovery
  Cause: An attempt was made to end an online backup of file when the file is busy. Some operation such as recovery or rename may be active, or there may still be some instance that has the database open with this file online.
  Action: If there is an instance with the database open then the backup can be ended there by using the ALTER TABLESPACE command. Otherwise wait for the completion of the other operation.
$ zzora 600 | sed '/^[[:blank:]]*$/d;s/^\(  *\)[+*]/\1-/'
KUP-00600 internal error, arguments [string] [string] [string] [string] [string]
  Cause: An internal XAD error occurred.
  Action: Contact Oracle Support Services.
====================================================================================================
NNO-00600 warning: forwarder count number exceeds maximum of number, first number will be loaded
  Cause: The server's configuration contains too many default forwarders. The server loads a specified maximum number of forwarders, ignores the rest, and continues running. This is an internal error, not normally visible to the user.
  Action: Contact Oracle Support Services.
====================================================================================================
ORA-00600 internal error code, arguments: [string], [string], [string], [string], [string], [string], [string], [string]
  Cause: This is the generic internal error number for Oracle program exceptions. It indicates that a process has encountered a low-level, unexpected condition. Causes of this message include:
  - timeouts
  - file corruption
  - failed data checks in memory
  - hardware, memory, or I/O errors
  - incorrectly restored files
  The first argument is the internal message number. Other arguments are various numbers, names, and character strings. The numbers may change meanings between different versions of Oracle.
  Action: Report this error to Oracle Support Services after gathering the following information:
  - events that led up to the error
  - the operations that were attempted that led to the error
  - the conditions of the operating system and databases at the time of the error
====================================================================================================
PCB-00600 indicators are not allowed in EXEC IAF statements
  Cause: Indicator variables associated with host variables cannot be used in EXEC IAF statements such as GET and PUT in a user exit.
  Action: Eliminate the indicator variables. If feasible (for example with Forms V4), use EXEC TOOLS statements, which do allow indicator variables. See the Pro*COBOL Precompiler Programmer's Guide for more information about the EXEC IAF and EXEC TOOLS statements.
====================================================================================================
PLS-00600 SAMPLE cannot be applied to a remote object
  Cause: SAMPLE applying to a remote object is not supported.
  Action: Do not use SAMPLE with a remote object.
====================================================================================================
RMAN-00600 internal error, arguments [string] [string] [string] [string] [string]
  Cause: An internal error in Recovery Manager occurred.
  Action: Contact Oracle Support Services.
====================================================================================================
NMS-00600 to NMS-00799: Jobs and Events
  These messages can be sent back to the console when users run jobs or register events.
$
