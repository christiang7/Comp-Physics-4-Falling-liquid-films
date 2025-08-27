reset
#set key outside rmargin
set key off
set xlabel "t "
set ylabel "x "
set yrange [*:*] reverse
#set yrange [6:0] reverse
# every :::(first block)::(last block)
# every ::(first line):::(last line)
# every :::1::50
plot 'xtrajectory.txt' using ($1):($2) ps 0.4 pt 5 lc rgb 'blue' #title ' '.i.'. x'
#set term png
# #'plot-x-L-n.pdf'
#set output 'plot-x-6-3.png'
#plot 'xtrajectory-6-3-0.001-200.0-0.1-0.001-0.25.txt' using ($1):($2) ps 0.3 pt 5 lc rgb 'blue' notitle
#set term qt
#replot
