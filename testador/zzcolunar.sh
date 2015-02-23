$ cat _numeros.txt _dados.txt | zzcolunar 3
1             5             4:quatro:four
2             1:um:one      5:cinco:five 
3             2:dois:two    
4             3:tres:three  
$

$ cat _numeros.txt _dados.txt | zzcolunar -z 3
1             2             3            
4             5             1:um:one     
2:dois:two    3:tres:three  4:quatro:four
5:cinco:five 
$

$ cat _numeros.txt _dados.txt | zzcolunar -c -z 2
      1             2      
      3             4      
      5         1:um:one   
 2:dois:two   3:tres:three 
4:quatro:four 5:cinco:five 
$

$ cat _numeros.txt _dados.txt | zzcolunar -r 4
            1             4    2:dois:two  5:cinco:five
            2             5  3:tres:three 
            3      1:um:one 4:quatro:four 
$
