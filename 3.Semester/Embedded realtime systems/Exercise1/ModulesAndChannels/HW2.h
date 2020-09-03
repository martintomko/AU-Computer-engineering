/*
 * HW2.h
 *
 *  Created on: Apr 2, 2013
 *      Author: KBE
 */

#ifndef HW2_H_
#define HW2_H_

SC_MODULE (HW2) {
	sc_fifo_out<int> outP1;
	sc_fifo_in<int> inP2;

	void P2(){
		int value;
		while (1) {
			value = inP2.read();
			outP1.write(value*2);
		}
	}

	SC_CTOR (HW2) {
		SC_THREAD(P2);
	}
};

#endif /* HW2_H_ */
