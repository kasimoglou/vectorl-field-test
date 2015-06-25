#ifndef CAR_PARKING_H
#define CAR_PARKING_H

const uint32_t carInTime[4] = {8000, 9100, 9400, 10100};
const uint32_t carOutTime[4] = {9500, 9300, 10200, 10300};
const uint8_t carSpot[4] = {0, 1, 1, 0};
	
	struct parking {
		struct _model_sys {
			
		} sys;
		
		struct _model_parking {
			uint8_t arrival;
			bool spotTaken[2];
		} parking;
		
		struct on_3car_2In_args {
			uint8_t i;
		} on_3car_2In_args;
		
		struct on_3car_3Out_args {
			uint8_t i;
		} on_3car_3Out_args;
	};

#endif /* CAR_PARKING_H */
