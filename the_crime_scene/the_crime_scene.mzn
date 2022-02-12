int : n_clues; 
int: xi;
int: yi;
set of int : X_DOM = -xi..xi;
set of int : Y_DOM = -yi..yi;
array[1..n_clues] of X_DOM: x_pos_clues;
array[1..n_clues] of Y_DOM : y_pos_clues;
array[X_DOM, Y_DOM] of var 0..1 : grid_roll;
list of var opt X_DOM : fx= [i| i in X_DOM, j in Y_DOM where grid_roll[i,j] == 1 ];
list of var opt Y_DOM : fy= [j| i in X_DOM, j in Y_DOM where grid_roll[i,j] == 1 ];

%metto 1 quando sto fuori dai 3 di distanza, metto 0 altrimenti.
%metto come constraint che se ho 1 allora la somma degli uno vicino a lui in tutte le direzioni deve esser di 2

constraint forall(i in X_DOM, j in Y_DOM, c in 1..n_clues)(
                 if round((sqrt(pow(i-x_pos_clues[c],2)+pow(j - y_pos_clues[c],2)))) < 3 then grid_roll[i,j]=0 else 
                 if round((sqrt(pow(i-x_pos_clues[c],2)+pow(j - y_pos_clues[c],2)))) == 3 then grid_roll[i,j]=1 else true endif
                  endif
           );
%constraint forall(i in 1..length(fx), j in 1..length(fx))(
%                  if (i==j \/ (i =1 /\ j =length(fx) \/ (i =length(fx) /\ j =1))) then true else ((fx[i] != fx[j]) \/ (fy[i] != fy[j])) endif    
%           );
constraint fx[1] == fx[length(fx)] /\ fy[1] == fy[length(fx)]; 
constraint sum( i in X_DOM, j in Y_DOM )(grid_roll[i,j])>3;
%constraint forall(i in 2..length(fx))(
%                 (fx[i] == fx[i-1] /\ (fy[i] == fy[i-1] + 1  \/ fy[i] == fy[i-1] - 1))
%                 \/
 %                ((fx[i] == fx[i-1] + 1  \/ fx[i] == fx[i-1] - 1) /\ fy[i] == fy[i-1])
%                 \/
%                 ((fx[i] == fx[i-1] + 1 \/ fx[i] == fx[i-1] - 1) /\ (fy[i] == fy[i-1] + 1  \/ fy[i] == fy[i-1] - 1))
 %          );

solve minimize sum( i in X_DOM, j in Y_DOM )(grid_roll[i,j]);
output[format(fx)];
output[format(fy)];
output[format(length(fx))];

%output([format(sqrt(pow(i-x_pos_clues[c],2)+pow(j - y_pos_clues[c],2))) | i in X_DOM, j in Y_DOM, c in 1..n_clues]);