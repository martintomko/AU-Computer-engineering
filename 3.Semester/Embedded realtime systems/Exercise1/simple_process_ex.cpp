#include "simple_process_ex.h"

void simple_process_ex::my_thread_process(void) {
  std::cout << "my_thread_process executed within "
            << name() 
            << std::endl;
  for (int i = 1; i < 110; i++) {
	  wait(10, SC_MS);
	  fifo.write(i);
  }
}

void simple_process_ex::my_thread_process2(void) {
  std::cout << "my_thread_process 2 executed within "
            << name()
            << std::endl;
  while (1) {
	  std::cout << fifo.read() << std::endl;
  }
}

void simple_process_ex::my_method(void) {
  std::cout << "my_method executed within "
            << name()
            << std::endl;
}
