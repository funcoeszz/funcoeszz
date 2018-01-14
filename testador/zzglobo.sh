$ zzglobo | sed '1{s/.*,/Sem,/;s/, .*/ DATA/;};s/[0-2][0-9]:[0-5][0-9]:/HORA:/;s/: .*/ - DESCRIÇÃO/' | head -n 10
Sem DATA

HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
HORA - DESCRIÇÃO
$
