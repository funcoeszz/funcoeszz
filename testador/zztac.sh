$ cat _numeros.txt
1
2
3
4
5
$ zztac _numeros.txt
5
4
3
2
1
$ zztac _numeros.txt _numeros.txt
5
4
3
2
1
5
4
3
2
1
$ cat _numeros.txt | zztac
5
4
3
2
1
$ cat _numeros.txt | zztac | zztac   #→ --file _numeros.txt
