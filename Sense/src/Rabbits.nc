#include "Rabbits.h";
#include "PriorityQueue.h"

module Rabbits{
	provides interface SimulationInterface;
	uses interface LocalTime<TMilli> as Timer;
	provides interface Read<uint16_t> as SensorReading;
}
implementation{
	struct rabbits rabbit;
	
	void on_7rabbits_10generation(uint8_t n) {
 	 	rabbit.rabbits.tmp = rabbit.rabbits.thisgen;
 	 	rabbit.rabbits.thisgen += rabbit.rabbits.lastgen;
 	 	rabbit.rabbits.lastgen = rabbit.rabbits.tmp;
 	 	
 	 	dbg("Output", "ENVIRONMENT SIMULATION: Rabbits now are: %u\n", rabbit.rabbits.thisgen);
 	 	
 	 	//if (n < generation) {
 			add(&event_queue, on_7rabbits_10generation, call Timer.get() + 1, event_counter++);
 		//}
	}
 	 
 	void on_3sys_4Init() {
 	 	add(&event_queue, on_7rabbits_10generation, call Timer.get() + 0, event_counter++);
	}
	

	command void SimulationInterface.initializeSimulation(){
		// TODO Auto-generated method stub
		rabbit.rabbits.thisgen = 1;
		on_3sys_4Init();
	}

	task void getValue() {
		signal SensorReading.readDone(SUCCESS, rabbit.rabbits.thisgen);
	}

	command error_t SensorReading.read(){
		// TODO Auto-generated method stub
		post getValue();
		return SUCCESS;
	}
}