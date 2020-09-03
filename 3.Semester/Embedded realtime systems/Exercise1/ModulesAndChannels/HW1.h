/*
 * HW1.h
 *
 *  Created on: Apr 2, 2013
 *      Author: KBE
 */

#ifndef HW1_H_
#define HW1_H_

SC_MODULE (HW1) {
	sc_fifo_out<int> outP3;
	sc_fifo_out<int> outP4;

	void P3(){
		while (1) {
			outP3.write(3);
			wait(20, SC_MS);
		}
	}

	void P4(){
		while (1) {
			outP4.write(4);
			wait(20, SC_MS);
		}
	}

	SC_CTOR (HW1) {
		SC_THREAD(P3);
		SC_THREAD(P4);
	}
};

#endif /* HW1_H_ */
