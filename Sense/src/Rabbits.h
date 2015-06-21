#ifndef RABBITS_H
#define RABBITS_H
    const uint8_t generation = 10;
	
	struct rabbits {
		struct _model_sys {
			
		} sys;
		
		struct _model_rabits {
			uint16_t lastgen;
			uint16_t thisgen;
			uint16_t tmp;
			
		} rabbits;
	};
	
#endif /* RABBITS_H */
