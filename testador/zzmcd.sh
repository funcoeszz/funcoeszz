$ zzmcd -s aa									#→ mkdir -p aa
$ zzmcd -s tmp1/{d1,d2,d3}						#→ mkdir -p tmp1/d1 tmp1/d2 tmp1/d3
$ zzmcd -s d1/d1/{s1,s2/{x0,x1},s3}/{z1,z2}		#→ mkdir -p d1/d1/s1/z1 d1/d1/s1/z2 d1/d1/s2/x0/z1 d1/d1/s2/x0/z2 d1/d1/s2/x1/z1 d1/d1/s2/x1/z2 d1/d1/s3/z1 d1/d1/s3/z2
$ zzmcd /dev/zz									#→ '/dev/zz' não criado.
$ zzmcd -z bb
Uso: zzmcd [-n|-s] <dir[/subdir]> [dir[/subdir]]
$
