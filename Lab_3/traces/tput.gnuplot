#size and shape of the plot
set size square

#labels at the axes
set xlabel "Rates [Mbps]"
set ylabel "Average throughput [Mbps]"


#output to pdf
set term pdf

#set the name of the output file
set output "poging2_L3-2-1-tput.pdf"

#actual plot command: 2 plots are made, using tput-tcp1.dat and tput-udp1.dat as input.
# 'with linespoints' specifies the line type
# 'title' specifies the legend
 plot 'poging2_L3-2-1.tcp.txt' with  linespoints title "TCP", \
	'poging2_L3-2-1.udp.txt' with  linespoints title "UDP"

#new outpufile
set output "poging2_L3-2-1-usage.pdf"

#labels at the axes
set xlabel "Rates [Mbps]"
set ylabel "Relative link usage"

# 'using' specifies what data from the file is plotted: 
# '1:($2/$2)' means the values of column 1 are used as x-values, and the value of column 2 divided by column 1 as y-values 
 plot  'poging2_L3-2-1.tcp.txt' using 1:($2/$1) with linespoints axis x1y2 title "TCP",\
	   'poging2_L3-2-1.udp.txt' using 1:($2/$1) with linespoints axis x1y2 title "UDP"
