% Use this editor as a MiniZinc scratch book

int : born_year;
int: len_born_year;
int: fraction;
array[int] of int: powers = [ 10^i | i in 0..len_born_year-1];
var int : target_year;
array[int] of var int: digits = [ (target_year div n) mod 10 | n in powers ];
constraint sum(digits) == (target_year - born_year) div fraction;
constraint target_year > born_year;
constraint (target_year - born_year) mod fraction == 0;

solve satisfy;