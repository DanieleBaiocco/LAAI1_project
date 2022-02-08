% labyrinth

int : r;
int : c;

array[0..1] of int : start_pair;
array[0..1] of int : end_pair;
set of int : TOT_POINTS = 0..r*c-4;
array[TOT_POINTS] of  : path;
%max(i | i in index_set(path))
%constraint che dice che nel path possono esserci sono pairs direttamente collegate

