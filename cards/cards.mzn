% First exercise Bocconi

int: n_cards;
int: n_red;
int: n_black = n_cards - n_red;
int: left_split;
int: right_split = n_cards - left_split;
var 0..n_red: n_red_left_split;
var 0..n_black: n_black_left_split;
var 0..n_red: n_red_right_split;
var 0..n_black: n_black_right_split;

constraint n_black_right_split = n_black - n_black_left_split;
constraint n_red_right_split = n_red - n_red_left_split;
constraint left_split = n_red_left_split + n_black_left_split;
constraint right_split = n_red_right_split + n_black_right_split;
solve satisfy;