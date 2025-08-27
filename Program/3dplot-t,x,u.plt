reset
set pm3d map
unset grid
set xlabel "t "
set ylabel "x "
set zlabel "u "
#set yrange [6:0] reverse
set yrange [*:*] reverse
set palette rgb 23,28,3; #set title "ocean (green-blue-white)\ntry also other permutations";
#set view 28, 6
# every :::(first block)::(last block)
splot 'data.txt' using 1:2:3 with pm3d notitle
#set term png
# #'plot-u-L-n.pdf'
#set output 'plot-u-6-3.png'
#splot 'data-6-3-0.001-200.0-0.1-0.001-0.25.txt' using ($1):($2):($3) with pm3d notitle
#set term qt
#replot
