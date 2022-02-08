include "alldifferent.mzn";

int: num_digits;
int: lower_bound = 10^(num_digits - 1);
int: upper_bound = 10^(num_digits) - 1;
var lower_bound..upper_bound : number;
array[int] of int: powers = [ 10^i | i in 0..num_digits-1];
array[int] of var int: digits = [ (number div n) mod 10 | n in powers ];
constraint forall (digit in digits) (digit mod 2 == 0);
constraint alldifferent(digits);
constraint number mod 11 == 0;

solve minimize number;

output ["The number is ", format(number)];