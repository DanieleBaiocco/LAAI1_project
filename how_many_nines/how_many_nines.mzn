% Use this editor as a MiniZinc scratch book

int : n_digits;
int : max_digits_generated;
set of int : ProblemRange = 10^(n_digits-1) .. 10^(n_digits)-1;
var ProblemRange : result;
set of int : PowerRange;
int: num_to_check;
array[int] of int: powers = [ 10^i | i in 0..max_digits_generated-1];

constraint forall(i in PowerRange)(
           exists (n in powers)(((result * i) div n) mod 10 == num_to_check)
           );
           
solve satisfy;


