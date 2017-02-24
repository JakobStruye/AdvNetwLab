#size and shape of the plot
set size square

#labels at the axes
set xlabel "Maximum Transferable Unit (MTU) [bytes]"
set ylabel "Average throughput [Mbps]"


#output to pdf
set term pdf

#set the name of the output file
set output "L3-4-1-tput.pdf"

#actual plot command: 2 plots are made, using tput-tcp1.dat and tput-udp1.dat as input.
# 'with linespoints' specifies the line type
# 'title' specifies the legend
 plot 'L3-4-1.tcp.txt' with  linespoints title "TCP", \
	'L3-4-1.udp.txt' with  linespoints title "UDP"
