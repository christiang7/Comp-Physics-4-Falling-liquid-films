# Falling liquid films: Kuramoto-Sivashinsky equation program


function output(channel, data1, data2, data3 )
   if channel == 1
      write(single_particle_file,"$data1 $data2 $data3 \n")
   elseif channel == 2
      write(xtrajectory_file,"$data1 $data2 $data3 \n")
   elseif channel == 3
      write(data_file,"$data1 $data2 $data3 \n")
   elseif (channel == 4 && schalter == 1 )
      println("$data1 $data2 $data3")
   end
end

function Init()

   global L = parse(Int, ARGS[1] )# length of the x direction
   global N = parse(Int, ARGS[2] )# number of modes
   global M = 2*N+1
   global delta_t = parse(Float64, ARGS[3] )# time step
   global limit_t = parse(Float64, ARGS[4] )# time of simulation
   global delta_x = parse(Float64, ARGS[5] )# x step
   global x = Float64[0:delta_x:L;] # grid for x plotting
   global xsize = length(x )
   global C = complex(zeros(Float64, M ) ) # complex coefficients C_n
   fill!( C, parse(Float64, ARGS[7] )) # start points of C_n(0) at t = 0
   global F = complex(zeros(Float64, M ) )# function for the nonlinear terms
   global X = zeros(Float64, xsize ) # particles in the flow
   global Y = zeros(Float64, xsize ) # particles in the flow
   global out_time = parse(Float64, ARGS[8] )
   global schalter = parse(Int, ARGS[6] ) # switch for live plotting of u,x
   global lineend = 1
   
   ### data files for the output and input
   if schalter == 0
      global data_file = open("data-$L-$N-$delta_t-$limit_t-$delta_x-$(parse(Float64, ARGS[7] ) )-$out_time.txt","w") # file for x,t,u plotting
      global xtrajectory_file = open("xtrajectory-$L-$N-$delta_t-$limit_t-$delta_x-$(parse(Float64, ARGS[7] ) )-$out_time.txt","w") # file for x trajectory plotting of x,t
      global single_particle_file = open("single_particle-$L-$N-$delta_t-$limit_t-$delta_x-$(parse(Float64, ARGS[7] ) )-$out_time.txt","w")
   else
      global data_file = open("data.txt","w") # file for x,t,u plotting
      global xtrajectory_file = open("xtrajectory.txt","w") # file for x trajectory plotting of x,t
      global single_particle_file = open("single_particle.txt","w")
   end
   global xstart_file = open("xstart.txt")# file for positions of particles 
    
   output(1, "#$(parse(Int,ARGS[1]))-$(parse(Int,ARGS[2]))-\\
#$(parse(Float64,ARGS[3]))-$(parse(Float64,ARGS[4]))-\\
#$(parse(Float64,ARGS[5]))-$(parse(Int,ARGS[6]))-\\
#$(parse(Float64,ARGS[7])))", " ", " ")
   output(2, "#$(parse(Int,ARGS[1]))-$(parse(Int,ARGS[2]))-\\
#$(parse(Float64,ARGS[3]))-$(parse(Float64,ARGS[4]))-\\
#$(parse(Float64,ARGS[5]))-$(parse(Int,ARGS[6]))-\\
#$(parse(Float64,ARGS[7])))", " ", " ")
   output(3, "#$(parse(Int,ARGS[1]))-$(parse(Int,ARGS[2]))-\\
#$(parse(Float64,ARGS[3]))-$(parse(Float64,ARGS[4]))-\\
#$(parse(Float64,ARGS[5]))-$(parse(Int,ARGS[6]))-\\
#$(parse(Float64,ARGS[7])))", " ", " ") 
   output(4, "set yrange [-6:6]", " ", " " )
   
   # setup a number of particles 
   XPoints()
end

function XPoints()
   # starting points of the grid
   for j in 0:xsize-1
      Y[j+1]=x[j+1]
   end
   # starting points for specifig number of particles, definied in the xstart file
   global lineend = 1
   while !eof(xstart_file)
     X[lineend] = parse(Float64, readline(xstart_file ) )
     #println("$lineend $X[lineend]")
     lineend += 1
   end
end

function FunctionU(x)
   u = complex(Float64(0 ) )
   for ne in 1:M
         if (ne > N+1)
            u = u + conj(C[2*N+2-ne])*exp(im*(ne-1-N )*2*pi*x/L )
         elseif (ne <= N+1)
            u = u + (C[ne])*exp(im*(ne-1-N )*2*pi*x/L )
         end
      end
   return u
end

function CompCoeff()
   for ne in 1:N
      C[N+1-ne]=conj(C[N+1+ne] )
   end
   for ne in 2+N:M
      F[ne] = 0
      for l in ne-N:M
         F[ne] = F[ne] + C[l] * C[ne-l+N+1]
      end
      F[ne]=-F[ne]*im*(ne-N-1)*pi/L
   end
end

function CompAdvect(t,j)
   Y[j+1]=Y[j+1] + out_time*real(FunctionU(Y[j+1] ) )
   if Y[j+1]>L
      Y[j+1]=Y[j+1]-L
   elseif Y[j+1]<0
      Y[j+1]=Y[j+1]+L
   end
   output(2, t, Y[j+1], " " )
end

function CompSingAdvect(t)
   for j in 1:lineend
      X[j]=X[j] + out_time*real(FunctionU(X[j] ) )
      if X[j]>L
         X[j]=X[j]-L
      elseif X[j]<0
         X[j]=X[j]+L
      end
      output(1, t, X[j], " " )
   end
   output(1, " ", " ", " " )
end

function CompVelo(t)
   output(4, "plot '-' using 2:3 w l", " ", " " )
   for j in 0:xsize-1 #x direction steps
      w::Float64 = real(FunctionU(x[j+1] ) )
      output(3, t, j*delta_x, w )
      output(4, t, j*delta_x, w )
      
      CompAdvect(t,j)
   end
   output(2, " ", " ", " " )
   output(3, " ", " ", " " )
   output(4, "eol: 0", " ", " " )
end

function NumCalc()
   Fe = complex(zeros(Float64, M ) )
   for t in 0:delta_t:limit_t
      Ce = complex(zeros(Float64, M ) )
      for ne in N+2:M
         a = Float64(((ne-N-1)*2*pi/L )^2-((ne-N-1)*2*pi/L )^4 )
         Fe[ne]=F[ne]
         Ce[ne] = C[ne]*exp(a*delta_t) + F[ne]*(exp(a*delta_t )-1 )/a
      end
      
      CompCoeff()
      
      for ne in N+2:M
         a = Float64(((ne-N-1 )*2*pi/L )^2-((ne-N-1 )*2*pi/L )^4 )
         C[ne] = Ce[ne] + (F[ne]-Fe[ne] )*(exp(a*delta_t ) -1 - a*delta_t )/(a^2*delta_t )
      end
      if (trunc(mod(t*1e4, out_time*1e4)) == 0 )
         CompVelo(t)
         CompSingAdvect(t)
      end
   end
end


# Execution of algorithm to simulate the falling liquid films.

Init()

CompCoeff()

NumCalc()

