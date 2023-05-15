#!/bin/bash
# Script file to reproduce the results presented in the paper "Learning nonlinear hybrid automata from input–output time-series data"
# This file must be executed from the folder HybridLearner/build

# We will copy all outputs in the folder results
X=$(find ../results 2>/dev/null)  # redirecting the error message to null device
if test -z "$X"
then
	echo "Result folder created!"	
	mkdir ../results
else
	echo "results folder already exists!"
fi

# **** Switched Oscillator *****
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/oscillator.slx --engine learn-ha-loop --variable-category 'x:output, y:output'  --output-file oscillator_64.txt   --simu-init-size 2 --initial-value 'x>=0.01 & x<=0.09 & y>=0.01 & y<=0.09'   --time-horizon 10 --sampling-time 0.01 --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.1 --segment-relative-fine-error 0.01  --precision-equivalence 100.0 --max-traces 3 --max-stoptime 20 --invariant 2  --cluster-algo dtw  --correlation-threshold 0.89 --distance-threshold 1.0   --max-generate-trace-size 1024  --ode-speedup 50 --filter-last-segment 1 --solver-type fixed --ode-solver FixedStepAuto >../results/outputOsci_withoutType.txt
mkdir ../results/oscillator
mkdir ../results/oscillator/BeforeAnnotation
cp oscillator_64/oscillator_640.slx ../results/oscillator/BeforeAnnotation/oscillator_64.slx
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/oscillator.slx --engine learn-ha-loop --variable-category "x:output, y:output"  --output-file oscillator_64.txt   --simu-init-size 2 --initial-value "x>=0.01 & x<=0.09 & y>=0.01 & y<=0.09"   --time-horizon 10 --sampling-time 0.01 --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.1 --segment-relative-fine-error 0.01  --precision-equivalence 100.0 --max-traces 10 --max-stoptime 20 --invariant 2  --cluster-algo dtw  --correlation-threshold 0.89 --distance-threshold 1.0   --max-generate-trace-size 1024  --ode-speedup 50 --filter-last-segment 1 --solver-type fixed --ode-solver FixedStepAuto  --variable-types 'x0=t1,x1=t1' >../results/outputOsci_Type.txt
mkdir ../results/oscillator/AfterAnnotation
cp oscillator_64/oscillator_640.slx ../results/oscillator/AfterAnnotation/oscillator_64_Type.slx
# Copying the trajectories use as a Training Set. We take a single file by appending all trajectories
cp simu_oscillator_64.txt ../results/oscillator
# create folders to populate output trajectories generated by the learned models
mkdir ../results/oscillator/BeforeAnnotation/testData_Output
mkdir ../results/oscillator/AfterAnnotation/testData_Output

# **** Bouncing Ball *****
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/ex_sldemo_bounce_Input.slx --engine learn-ha-loop --variable-category "u:input, x:output, v:output"  --output-file bball_64.txt --simu-init-size 2 --initial-value "u>=-9.5 & u<=-9.9 & x>=10.2 & x<=10.5 & v>=15 & v<=15"  --input-signal-type "u=linear" --numberOf-control-points "u=4"  --time-horizon 13 --sampling-time 0.001 --modes 1 --degree 1 --boundary-degree 1 --segment-relative-error 0.1  --segment-relative-fine-error 0.01 --precision-equivalence 50.0 --max-traces 1 --max-stoptime 20 --invariant 2  --cluster-algo dtw  --correlation-threshold 0.8 --distance-threshold 9.0  --fixed-interval-data 0 --filter-last-segment 1  --max-generate-trace-size 1024  --ode-speedup 50 --solver-type fixed --ode-solver FixedStepAuto > ../results/outputBall_withoutType.txt
mkdir ../results/bball
mkdir ../results/bball/BeforeAnnotation
cp bball_64/bball_640.slx ../results/bball/BeforeAnnotation/bball_64.slx
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/ex_sldemo_bounce_Input.slx --engine learn-ha-loop --variable-category "u:input, x:output, v:output"  --output-file bball_64.txt --simu-init-size 2 --initial-value "u>=-9.5 & u<=-9.9 & x>=10.2 & x<=10.5 & v>=15 & v<=15"  --input-signal-type "u=linear" --numberOf-control-points "u=4"  --time-horizon 13 --sampling-time 0.001 --modes 1 --degree 1 --boundary-degree 1 --segment-relative-error 0.1  --segment-relative-fine-error 0.01 --precision-equivalence 50.0 --max-traces 5 --max-stoptime 20 --invariant 2  --cluster-algo dtw  --correlation-threshold 0.8 --distance-threshold 9.0  --fixed-interval-data 0 --filter-last-segment 1  --max-generate-trace-size 1024  --ode-speedup 50 --solver-type fixed --ode-solver FixedStepAuto   --variable-types 'x0=t1,x1=t3' --t3-values 'x1=0' > ../results/outputBall_Type.txt
mkdir ../results/bball/AfterAnnotation
cp bball_64/bball_640.slx ../results/bball/AfterAnnotation/bball_64_Type.slx
# Copying the trajectories use as a Training Set. We take a single file by appending all trajectories
cp simu_bball_64.txt ../results/bball/
# create folders to populate output trajectories generated by the learned models
mkdir ../results/bball/BeforeAnnotation/testData_Output
mkdir ../results/bball/AfterAnnotation/testData_Output

# **** Two Tanks *****
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/twoTank.slx  --engine learn-ha-loop --variable-category "u:input, x1:output, x2:output"  --output-file twoTanks_64.txt  --simu-init-size 2 --initial-value "u>=-0.1 & u<=0.1 & x1>=1.2 & x1<=1.2 & x2>=1 & x2<=1"  --input-signal-type "u=linear" --numberOf-control-points "u=2"  --time-horizon 9.3 --sampling-time 0.001 --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.01 --segment-relative-fine-error 0.01  --precision-equivalence 10.5 --max-traces 1 --max-stoptime 20  --invariant 2 --cluster-algo dtw  --correlation-threshold 0.7 --distance-threshold 1.5  --max-generate-trace-size 1024  --filter-last-segment 1 --ode-speedup 50 --solver-type fixed --ode-solver FixedStepAuto > ../results/outputTwoTanks_withoutType.txt
mkdir ../results/twoTanks
mkdir ../results/twoTanks/BeforeAnnotation
cp twoTanks_64/twoTanks_640.slx ../results/twoTanks/BeforeAnnotation/twoTanks_64.slx
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/twoTank.slx  --engine learn-ha-loop  --variable-category "u:input, x1:output, x2:output"  --output-file twoTanks_64.txt  --simu-init-size 2 --initial-value "u>=-0.1 & u<=0.1 & x1>=1.2 & x1<=1.2 & x2>=1 & x2<=1"  --input-signal-type "u=linear" --numberOf-control-points "u=2"  --time-horizon 9.3 --sampling-time 0.001 --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.01 --segment-relative-fine-error 0.01  --precision-equivalence 10.5 --max-traces 10 --max-stoptime 20  --invariant 2 --cluster-algo dtw  --correlation-threshold 0.7 --distance-threshold 1.5  --max-generate-trace-size 1024  --filter-last-segment 1 --ode-speedup 50 --solver-type fixed --ode-solver FixedStepAuto  --variable-types 'x0=t1,x1=t1,x2=t1' > ../results/outputTwoTanks_Type.txt
mkdir ../results/twoTanks/AfterAnnotation
cp twoTanks_64/twoTanks_640.slx ../results/twoTanks/AfterAnnotation/twoTanks_64_Type.slx
# Copying the trajectories use as a Training Set. We take a single file by appending all trajectories
cp simu_twoTanks_64.txt ../results/twoTanks
# create folders to populate output trajectories generated by the learned models
mkdir ../results/twoTanks/BeforeAnnotation/testData_Output
mkdir ../results/twoTanks/AfterAnnotation/testData_Output

# **** Cell Model *****
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/cell/excitable_cell.slx --engine learn-ha-loop  --variable-category "x:output"  --output-file cellModel_64.txt --simu-init-size 2 --initial-value "x>=-76 & x<=-74" --time-horizon 500 --sampling-time 0.01 --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.01 --segment-relative-fine-error 0.01  --precision-equivalence 500.0 --max-traces 2 --max-stoptime 20  --invariant 2  --cluster-algo dtw  --correlation-threshold 0.92 --distance-threshold 1.0 --ode-speedup 3 --max-generate-trace-size 1024 --filter-last-segment 1 --solver-type fixed --ode-solver FixedStepAuto  > ../results/outputCell_withoutType.txt
mkdir ../results/cell
mkdir ../results/cell/BeforeAnnotation
cp cellModel_64/cellModel_640.slx ../results/cell/BeforeAnnotation/cellModel_64.slx
./HybridLearner --simulink-model-file ../src/test_cases/engine/learn_ha_loop/cell/excitable_cell.slx --engine learn-ha-loop  --variable-category "x:output"  --output-file cellModel_64.txt --simu-init-size 2 --initial-value "x>=-76 & x<=-74" --time-horizon 500 --sampling-time 0.01  --modes 4 --degree 1 --boundary-degree 1 --segment-relative-error 0.01 --segment-relative-fine-error 0.01  --precision-equivalence 500.0 --max-traces 2 --max-stoptime 20  --invariant 2  --cluster-algo dtw  --correlation-threshold 0.92 --distance-threshold 1.0 --ode-speedup 3 --max-generate-trace-size 1024 --filter-last-segment 1 --solver-type fixed --ode-solver FixedStepAuto  --variable-types 'x0=t1' > ../results/outputCell_Type.txt
mkdir ../results/cell/AfterAnnotation
cp cellModel_64/cellModel_640.slx ../results/cell/AfterAnnotation/cellModel_64_Type.slx
# Copying the trajectories use as a Training Set. We take a single file by appending all trajectories
cp simu_cellModel_64.txt ../results/cell
# create folders to populate output trajectories generated by the learned models
mkdir ../results/cell/BeforeAnnotation/testData_Output
mkdir ../results/cell/AfterAnnotation/testData_Output

# **** Engine Timing System *****. Here it first learns HA as a plain text-file from trajectories as input file, then transform txt to SLX model
./HybridLearner --engine learn-ha --simu-trace-file ../src/test_cases/engine/learn_ha/enginetiming/dataBBC/engine_64.txt  --variable-category "throttle:input, torque:input, engineSpeed:output" --output-file engineTiming_64.txt  --modes 20 --degree 1 --boundary-degree 1 --segment-relative-error 0.99  --segment-relative-fine-error 0.01   --invariant 2  --cluster-algo dtw  --correlation-threshold 0.9 --distance-threshold 1000 --ode-speedup 100  --fixed-interval-data 0 --filter-last-segment 0 --lmm-step-size 5 >  ../results/outputEngineTiming_withoutType.txt
./HybridLearner --variable-category "x0:input, x1:input, x2:output" --engine txt2slx --model-file engineTiming_64.txt --time-horizon 10 --sampling-time 0.01 --invariant 2 --input-signal-type "x0=fixed-step & x1=fixed-step" --degree 1 --ode-solver 'ode45' --fixed-interval-data 0  --numberOf-control-points "x0=3 & x1=3"  --initial-value "x0>=2 & x0<=2 & x1>=24 & x1<=24 & x2=2000" # we do not actually use this parameters for Testing instead use the Test Set input signal
mkdir ../results/engine
mkdir ../results/engine/BeforeAnnotation
cp engineTiming_64/engineTiming_640.slx ../results/engine/BeforeAnnotation/engineTiming_64.slx

./HybridLearner --engine learn-ha --simu-trace-file ../src/test_cases/engine/learn_ha/enginetiming/dataBBC/engine_64.txt --modes 20 --degree 1 --boundary-degree 1 --segment-relative-error 0.99  --segment-relative-fine-error 0.01 --output-file engineTiming_64.txt --cluster-algo dtw  --correlation-threshold 0.9 --distance-threshold 1000 --invariant 2 --variable-category "throttle:input, torque:input, engineSpeed:output" --ode-speedup 100  --fixed-interval-data 0 --filter-last-segment 0 --lmm-step-size 5 --variable-types 'x2=t1' >  ../results/outputEngineTiming_Type.txt
./HybridLearner --variable-category "x0:input, x1:input, x2:output" --engine txt2slx --model-file engineTiming_64.txt --time-horizon 10 --sampling-time 0.01 --invariant 2 --input-signal-type "x0=fixed-step & x1=fixed-step" --degree 1 --ode-solver 'ode45' --fixed-interval-data 0  --numberOf-control-points "x0=3 & x1=3"  --initial-value "x0>=2 & x0<=2 & x1>=24 & x1<=24 & x2=2000"
mkdir ../results/engine/AfterAnnotation
cp engineTiming_64/engineTiming_640.slx ../results/engine/AfterAnnotation/engineTiming_64_Type.slx
# To see the trajectories use as a Training Set, one can look at the "../src/test_cases/engine/learn_ha/enginetiming/dataBBC/engine_64.txt"
# create folders to populate output trajectories generated by the learned models
mkdir ../results/engine/BeforeAnnotation/testData_Output
mkdir ../results/engine/AfterAnnotation/testData_Output


data_osci_withoutType=$(cat ../results/outputOsci_withoutType.txt)
data_osci_Type=$(cat ../results/outputOsci_Type.txt)

data_ball_withoutType=$(cat ../results/outputBall_withoutType.txt)
data_ball_Type=$(cat ../results/outputBall_Type.txt)

data_twoTanks_withoutType=$(cat ../results/outputTwoTanks_withoutType.txt)
data_twoTanks_Type=$(cat ../results/outputTwoTanks_Type.txt)

data_Cell_withoutType=$(cat ../results/outputCell_withoutType.txt)
data_Cell_Type=$(cat ../results/outputCell_Type.txt)

data_EngineTiming_withoutType=$(cat ../results/outputEngineTiming_withoutType.txt)
data_EngineTiming_Type=$(cat ../results/outputEngineTiming_Type.txt)


echo "Benchmark,Time-Without-Type,Time-Type" > ../results/runningTime_HybridLearner.csv
echo "Bouncing-Ball,${data_ball_withoutType},${data_ball_Type}" >> ../results/runningTime_HybridLearner.csv

echo "TwoTanks,${data_twoTanks_withoutType},${data_twoTanks_Type}" >> ../results/runningTime_HybridLearner.csv

echo "Oscillator,${data_osci_withoutType},${data_osci_Type}" >> ../results/runningTime_HybridLearner.csv

echo "Cell,${data_Cell_withoutType},${data_Cell_Type}" >> ../results/runningTime_HybridLearner.csv

echo "Engine-Timing,${data_EngineTiming_withoutType},${data_EngineTiming_Type}" >> ../results/runningTime_HybridLearner.csv


# cleaning files
rm ../results/outputOsci_withoutType.txt
rm ../results/outputOsci_Type.txt
rm ../results/outputBall_withoutType.txt
rm ../results/outputBall_Type.txt
rm ../results/outputTwoTanks_withoutType.txt
rm ../results/outputTwoTanks_Type.txt
rm ../results/outputCell_withoutType.txt
rm ../results/outputCell_Type.txt
rm ../results/outputEngineTiming_withoutType.txt
rm ../results/outputEngineTiming_Type.txt

