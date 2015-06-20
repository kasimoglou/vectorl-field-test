#include "Rabbits.h";
#include "PriorityQueue.h"

module Rabbits{
	provides interface SimulationInterface;
}
implementation{
	struct rabbits rabbit;
	struct priority_queue event_queue;
	uint8_t event_counter = 0;
	
	void on_7rabbits_10generation(uint8_t n) {
 	 	rabbit.rabbits.tmp = rabbit.rabbits.thisgen;
 	 	rabbit.rabbits.thisgen += rabbit.rabbits.lastgen;
 	 	rabbit.rabbits.lastgen = rabbit.rabbits.tmp;
 	 	
 	 	dbg("Output", "Rabbits now are: %u\n", rabbit.rabbits.thisgen);
 	 	
 	 	if (n < generation) {
 			on_7rabbits_10generation(n+1);
 		}
	}
 	 
 	void on_3sys_4Init() {
 	 	dbg("Output", "Rabbits now are: %u\n", rabbit.rabbits.thisgen);
 	    on_7rabbits_10generation(2);
	}
	

	command void SimulationInterface.initializeSimulation(){
		// TODO Auto-generated method stub
		struct event_node node;
		
		dbg("Output", "Generation %u\n", generation);
		rabbit.rabbits.thisgen = 1;
		initialize(&event_queue);
		
		add(&event_queue, on_3sys_4Init, 0, event_counter);
		
		dbg("Output", "Event queue size is now %u\n", event_queue.rear);
		node = delete(&event_queue);
		dbg("Output", "Event queue size is now %u\n", event_queue.rear);
		node.event_handler();
		
	}
}