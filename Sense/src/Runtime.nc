#include "PriorityQueue.h"

module Runtime{
	provides interface SimulationInterface as RuntimeInitializer;
	uses interface SimulationInterface as SimulationInitializer;
	uses interface Timer<TMilli> as EventTimer;
}
implementation{

	task void schedule_wake_up() {
		if (!isEmpty(&event_queue)) {
			call EventTimer.startOneShot(event_queue.nodes[0].priority - call EventTimer.getNow());
		}
	}
	
	command void RuntimeInitializer.initializeSimulation(){
		// TODO Auto-generated method stub
		dbg("Output", "Runtime engine initialized.\n");
		initialize(&event_queue);
		call SimulationInitializer.initializeSimulation();
		post schedule_wake_up();
	}

	event void EventTimer.fired(){
		// TODO Auto-generated method stub
		struct event_node event_to_execute;
		while (!isEmpty(&event_queue) && event_queue.nodes[0].priority <= call EventTimer.getNow()) {
			event_to_execute = delete(&event_queue);
			event_to_execute.event_handler();
		}
		
		post schedule_wake_up();
	}
}