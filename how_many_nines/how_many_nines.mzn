
int : n_digits;
int : max_digits_after_mult;
set of int : problem_range = 10^(n_digits-1) .. 10^(n_digits)-1;
set of int : multiplicator_range;
int: num_to_check;
array[int] of int: powers = [ 10^i | i in 0..max_digits_after_mult-1];

var problem_range : result;

constraint assert(n_digits > 0, "The number of digits cannot be less or equal 0");
constraint assert(max_digits_after_mult >= n_digits, "The maximum number of digits that is possible to generate cannot be smaller than the number of digits of the input number");
constraint assert(num_to_check > 0 /\ num_to_check<=9, "The number that must be contained in at least one of the digits resulting from each multiplication of the result with a multiplicator must be a digit between 1 and 9 ");

% it ensures that for each multiplicator, if it is multiplied with the result to return, there exist at least a digit that is equal to the num_to_check
constraint forall(i in multiplicator_range)(
           exists (n in powers)(((result * i) div n) mod 10 == num_to_check)
           );
           
solve satisfy;

output["The resulting value is "++ format(result)]

