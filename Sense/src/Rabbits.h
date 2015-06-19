#ifndef RABBITS_H
#define RABBITS_H
    const uint8_t generation = 10;
	
	struct rabbits {
		struct _model_sys {
			
		} sys;
		
		struct _model_rabits {
			uint8_t lastgen;
			uint8_t thisgen;
			uint8_t tmp;
			
		} rabbits;
	};
	
#endif /* RABBITS_H */
