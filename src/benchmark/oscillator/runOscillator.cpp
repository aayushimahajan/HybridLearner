/*
 * runOscillator.cpp
 *
 *  Created on: 05-Oct-2021
 *      Author: amit
 */



#include "runOscillator.h"

void runOscillator(std::unique_ptr<MATLABEngine> &ep, user_inputs::ptr user, const std::vector<double> initial_CE_values, intermediateResult::ptr intermediate) {


	std::string cmd4 = "time_horizon = ";
	cmd4.append(to_string(user->getTimeHorizon()));
	cmd4.append(";");
	ep->eval(convertUTF8StringToUTF16String(cmd4));

	cmd4 = "time_step = ";
	cmd4.append(to_string(user->getSampleTime()));
	cmd4.append(";");
	ep->eval(convertUTF8StringToUTF16String(cmd4));

	cmd4 = "x0_0 = ";
	cmd4.append(to_string(initial_CE_values[0]));
	cmd4.append(";");
	ep->eval(convertUTF8StringToUTF16String(cmd4));

	cmd4 = "x1_0 = ";
	cmd4.append(to_string(initial_CE_values[1]));
	cmd4.append(";");
	ep->eval(convertUTF8StringToUTF16String(cmd4));



	unsigned int execution_count = user->getNumberMatlabSimulationExecuted();
	std::string cmd = "cd ";
	std::string cmd2=" && rm result.txt";
	std::string pathOriginalModel_str="";


	//std::cout<<"cmd = "<< cmd <<std::endl;
	pathOriginalModel_str = intermediate->getMatlabPathForOriginalModel();
	//std::cout <<"tmp_str=" << pathOriginalModel_str <<std::endl;
	cmd.append(pathOriginalModel_str);
	cmd.append(cmd2);
	//std::cout << "cmd = " << cmd << std::endl;

	//Removing the files generated by Matlab in the previous run
	if (execution_count == 0) {	//running for the first time

		int x = system(cmd.c_str());
		if (x == -1) {
			std::cout <<"Error executing cmd: " << cmd <<std::endl;
		}
		//system("cd ../src/benchmark/oscillator && rm result.tsv");	//most important file is result.tsv others I may see later if need arise
		cmd="addpath (genpath('";
		cmd.append(pathOriginalModel_str);
		cmd.append("'))");
		//engEvalString(ep, "addpath (genpath('../src/benchmark/oscillator'))"); //Since tool BBC4CPS will be executed from Release or Debug
		ep->eval(convertUTF8StringToUTF16String(cmd));
	}

	cmd="cd('";
	cmd.append(pathOriginalModel_str);
	cmd.append("')");
	//engEvalString(ep, "cd('../src/benchmark/oscillator')");
	ep->eval(convertUTF8StringToUTF16String(cmd));

	//ep->eval(convertUTF8StringToUTF16String("run_oscillator"));
	ep->eval(u"run_oscillator");


	//This code can be used for other Models also.
	/*engEvalString(ep, "plot(x1,x2);");
	engEvalString(ep, "title('x1 vs. x2 of the Plot');");
	engEvalString(ep, "xlabel('x1');");
	engEvalString(ep, "ylabel('x2');");*/

	std::cout << "Done Calling Matlab's Simulink (simulation)\n" << std::endl;

}