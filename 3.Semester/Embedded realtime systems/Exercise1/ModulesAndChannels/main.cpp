/*
 * main.cpp
 *
 *  Created on: Apr 2, 2013
 *      Author: tihsc
 */

#include <iostream>
using namespace std;
#include <systemc.h>
#include "CPU.h"
#include "HW1.h"
#include "HW2.h"

int sc_main(int argc, char* argv[]) {
	  // Creating modules and channels
	  CPU instCPU("instPU");
	  HW1 instHW1("instHW1");
	  HW2 instHW2("instHW2");
	  sc_fifo<int> C1("C1");
	  sc_fifo<int> C2("C2");
	  sc_fifo<int> C3("C3");
	  sc_fifo<int> C4("C4");

	  // Connecting channels to modules
	  instHW1.outP3(C3);
	  instHW1.outP4(C4);
	  instHW2.outP1(C1);
	  instHW2.inP2(C2);
	  instCPU.inP1(C1);
	  instCPU.outP2(C2);
	  instCPU.inP3(C3);
	  instCPU.inP4(C4);

	  sc_start(200, SC_MS);
	  return 0;
}
