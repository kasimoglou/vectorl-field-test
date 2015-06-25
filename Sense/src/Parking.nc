#include "CarParking.h";
#include "PriorityQueue.h"

module Parking{
	provides interface SimulationInterface;
	uses interface LocalTime<TMilli> as Timer;
	provides interface Read<uint16_t> as SensorReading;
}
implementation{
	struct parking parking;
	
	void on_3car_3Out() {
		uint8_t pos = carSpot[parking.on_3car_3Out_args.i];
		dbg("Output", "Car left spot %u at time %u\n", pos, call Timer.get());
		parking.parking.spotTaken[pos] = !parking.parking.spotTaken[pos];
	}
	
	void on_3car_2In() {
		uint8_t pos = carSpot[parking.on_3car_2In_args.i];
 	 	
 	 	dbg("Output", "Car arrived at spot %u at time %u\n", pos, call Timer.get());
 	 	
 	 	parking.parking.spotTaken[pos] = !parking.parking.spotTaken[pos];
 	 	dbg("Output", "Spot %u has value %u\n", pos, parking.parking.spotTaken[pos]);

		// schedule departure
		parking.on_3car_3Out_args.i = parking.parking.arrival;
		add(&event_queue, on_3car_3Out, carOutTime[parking.parking.arrival] , event_counter++);
		
		// schedule arrival of next car
		parking.parking.arrival  = parking.parking.arrival + 1;
 	 	if (parking.parking.arrival < (uint8_t)(sizeof(carInTime)/ sizeof(carInTime[0]))) {
 	 		dbg("Output", "Next arrival will be at time %u\n", carInTime[parking.parking.arrival]);
 	 		parking.on_3car_2In_args.i = parking.parking.arrival;
 	 		add(&event_queue, on_3car_2In, carInTime[parking.parking.arrival], event_counter++);
 		} else {
 			dbg("Output","No next arrival, total arrivals=%u\n", parking.parking.arrival);
 		}
	}
	
	
 	 
 	void on_3sys_4Init() {
 		parking.on_3car_2In_args.i = parking.parking.arrival;
 	 	add(&event_queue, on_3car_2In, carInTime[parking.parking.arrival] , event_counter++);
	}

	command void SimulationInterface.initializeSimulation(){
		// TODO Auto-generated method stub
		
		// initialize global variables
		parking.parking.arrival = 0;
		parking.parking.spotTaken[0] = 0;
		parking.parking.spotTaken[1] = 0;
		on_3sys_4Init();
	}

	task void getValue() {
		signal SensorReading.readDone(SUCCESS, parking.parking.spotTaken[0]);
	}

	command error_t SensorReading.read(){
		// TODO Auto-generated method stub
		post getValue();
		return SUCCESS;
	}
}