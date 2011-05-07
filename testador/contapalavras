#!/usr/bin/env bash
debug=0
values=4

echo "um! dois, dois? três; quatro: três.TrÊs quatro - quatro QUATRO." > _tmp1

# normal:
# 3	quatro
# 2	três
# 2	dois
# 1	um
# 1	TrÊs
# 1	QUATRO

# -i:
# 4	quatro
# 3	três
# 2	dois
# 1	um

tests=(

# normal
_tmp1	''	''	''	t	'3\tquatro\n2\ttrês\n2\tdois\n1\tum\n1\tTrÊs\n1\tQUATRO'
-n	3	_tmp1	''	t	'3\tquatro\n2\ttrês\n2\tdois'

# -i
-i	_tmp1	''	''	t	'4\tquatro\n3\ttrês\n2\tdois\n1\tum'
-i	-n	2	_tmp1	t	'4\tquatro\n3\ttrês'

)
. _lib
