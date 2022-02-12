% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";

int : N;
int : M;
%var 0..N : result;
int : L;
array[1..L] of string: morse_input;
int : R;
array[1..R,1..L] of var int : result;
array[1..26] of  string: morse_alph = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."];
array[1..N,1..M] of int: dictionary;

constraint alldifferent(result);
constraint forall(i in 1..R, j in 1..L)(
           morse_alph[result[i,j]]==morse_input[j]
           );
                  

%array[int] of set of int : e = [1..2, 2..3];
%output[i | i in slice_1d(s, e, 1..3)];