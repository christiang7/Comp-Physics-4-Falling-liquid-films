echo '----------------Start Program----------------'

#### comiplation and producing of the output

notangle -Rfalling-liquid-films.jl falling-liquid-films.nw > falling-liquid-films.jl
notangle -R3dplot-t,x,u.plt falling-liquid-films.nw > 3dplot-t,x,u.plt
notangle -Rx-trajectory.plt falling-liquid-films.nw > x-trajectory.plt
notangle -Rxstart.txt falling-liquid-films.nw > xstart.txt

#### parameter overview
#                              L     N     delta_t     limit_t     delta_x     schalter     C_n(0)     output time
#julia falling-liquid-films.jl p1(L) p2(N) p3(delta_t) p4(limit_t) p5(delta_x) p6(schalter) p7(C_n(0)) p8(output time)

#### programming tasks
: '
0:
+  checking the right solution
1:
+  use for N the triple number of unstable modes
+  3D plot
+  show for L >= 20 solutions are turbulent
|  dependancy of the number of modes N

2:
+  particle plot of the final stage of the evolution
+  a good plot of particles path
+  a free choosable start point for a particle

'


#### computation

## compilation of interesting plots

# nice patterns and turbulently flow
#time julia falling-liquid-films.jl 64 40 1e-3 200 1e-1 1 0.001 0.25 | gnuplot -p

#stable wave
#time julia falling-liquid-films.jl 10 8 1e-3 140 1e-1 1 0.01 0.3 | gnuplot -p

#also nice plots
#time julia falling-liquid-films.jl 25 12 1e-3 280 1e-1 1 0.005 0.25 | gnuplot -p

# nice turbulents at L = 50 and particle trajectories
#time julia falling-liquid-films.jl 50 30 1e-3 140 1e-1 1 0.01 0.3 | gnuplot -p

# the beginnings of turbulents
#time julia falling-liquid-films.jl 20 10 1e-2 217.5 1e-1 1 0.005 0.25 | gnuplot -p

#also interesting turbulents
#time julia falling-liquid-films.jl 25 12 1e-3 280 1e-1 1 0.005 0.25 | gnuplot -p

# some more 'orderd' turbulents
#time julia falling-liquid-films.jl 50 30 1e-3 240 1e-1 1 0.0001 0.3 | gnuplot -p

# also nice
#time julia falling-liquid-films.jl 30 20 1e-3 440 1e-1 1 0.5 0.2 | gnuplot -p

### tasks

## stable waves

#time julia falling-liquid-films.jl 15 5 1e-3 200 1e-1 1 0.5 0.25 | gnuplot -p

# L = 6
#time julia falling-liquid-films.jl 6 3 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

# L = 7
#time julia falling-liquid-films.jl 7 3 1e-3 200 1e-1 1 0.001 0.25 | gnuplot -p

# L = 10
#time julia falling-liquid-films.jl 10 6 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

# L = 15
#time julia falling-liquid-films.jl 15 9 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

## turbulent

# L = 20
# starting of turbulents
#time julia falling-liquid-films.jl 20 9 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

# L = 27
#time julia falling-liquid-films.jl 27 12 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

# L = 40
#time julia falling-liquid-films.jl 40 19 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

# L = 64
#time julia falling-liquid-films.jl 64 30 1e-3 200 1e-1 0 0.001 0.25 #| gnuplot -p

## dependacy on the number of modes
# 
: '
for L = 30 triple 14
n = 6 castrophe
n = 7 stable with strong piek, turbulent
n = 8 stable, turbulent
n = 9 stable, trubolent with some strong waves
n = 10 :, : 
n = 11 :, :
n = 12 :, :
n = 13 :, :
n = 

at 13 everytime the same picture

for L = 27 triple 13
n = 5 catastrophe
n = 6 very turbulent and almost unstable
n = 7 more stable, also turbulent, by C(0) = 0.001 then goes to steady state
n = 8 more stable, :
n = 9 more stable
n = 10 same
n = 11 other picture turbulent 
n = 12 same
n = 13 same
n = 14 other picture turbulent
n = 15 same it 
n = 16 very turbulent
n = 17 same
n = 18 same
n = 19 same  by C(0) = 0.001 then goes to steady state
n = 20 very turbulent
n = 21 same
n = 22 same

'
#time julia falling-liquid-films.jl 27 12 1e-3 350 1e-1 1 0.001 0.75 | gnuplot -p

###testing

time julia falling-liquid-films.jl 27 13 1e-3 350 1e-1 1 0.001 0.75 | gnuplot -p

#### Plot of data

echo '----------------Gnuplot Start----------------'
#gnuplot live-plot.txt -p &

### 3D plot for t,x,u values
gnuplot 3dplot-t,x,u.plt -p

### x trajectory plot t,x
gnuplot x-trajectory.plt -p

echo '----------------End ----------------'

