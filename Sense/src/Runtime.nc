#include "PriorityQueue.h"

module Runtime{
	provides interface SimulationInterface as RuntimeInitializer;
	uses interface SimulationInterface as SimulationInitializer;
	uses interface Timer<TMilli> as EventTimer;
}
implementation{

	task void start() {
		call EventTimer.startPeriodic(50);
	}
	
	command void RuntimeInitializer.initializeSimulation(){
		// TODO Auto-generated method stub
		dbg("Output", "Runtime engine initialized.\n");
		initialize(&event_queue);
		call SimulationInitializer.initializeSimulation();
		post start();
	}

	event void EventTimer.fired(){
		// TODO Auto-generated method stub
		struct event_node event_to_execute;
		if (!isEmpty(&event_queue)) {
			while (event_queue.nodes[0].priority <= call EventTimer.getNow()) {
				event_to_execute = delete(&event_queue);
				event_to_execute.event_handler();
			}
		} else {
			dbg("Output", "No events\n");
		}
	}
}