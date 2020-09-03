/*
 * CPU.h
 *
 *  Created on: Apr 2, 2013
 *      Author: KBE
 */

#ifndef CPU_H_
#define CPU_H_

SC_MODULE (CPU) {
	sc_fifo_in<int> inP1;
	sc_fifo_out<int> outP2;
	sc_fifo_in<int> inP3;
	sc_fifo_in<int> inP4;

	void P1(){
		int v3, v4, result, cnt = 0;
		while (1) {
			cnt++;
			v3 = inP3.read();
			v4 = inP4.read();
			outP2.write(v3 + v4);
			result = inP1.read();
			cout << cnt << ":" << result << endl;
		}
	}

	SC_CTOR (CPU) {
		SC_THREAD(P1);
	}
};

#endif /* CPU_H_ */
