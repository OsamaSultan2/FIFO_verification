vlib work
vlog *.sv +define+SIM +cover -covercells
vsim -voptargs=+acc work.top -cover
coverage save data.ucdb -onexit
run 0
do wave.do 
run -all
