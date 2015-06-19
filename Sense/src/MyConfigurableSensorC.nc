generic module MyConfigurableSensorC(char mode[])
{
  provides interface Read<uint16_t> as Main;
  uses interface Read<uint16_t> as Real;
  uses interface SimulationInterface;
  //provides interface Init;
}

implementation
{
	uint8_t counter = 0;
	 
  	task void readVectorlValue() {
  		signal Main.readDone(SUCCESS, 20);
  	}
  	
  	void initializeSimulation() {
		dbg("Output", "Initializing simulation...\n");
		call SimulationInterface.initializeSimulation();
	}

  	// When a component wants to read a measurement from us
	// we check whether user has selected "real" or "test" mode.
	
	// In case we are in "real mode", user wants to read a real sensor
	// measurement so we forward the `read` call to whatever sensor component
	// user has selected.
	
	// If user has selected "test" mode, it means that we have to
    // start a vectorl simulation
  	command error_t Main.read(){
  		if (mode == "test") {
    		if (counter == 0) {
    			initializeSimulation();
				counter ++;
			}
			
    		dbg("Output", "Simulation reading\n");
			//post readVectorlValue();
    		return SUCCESS;
		} else if (mode == "real") {
			dbg("Output", "Reading from real sensor\n");
			call Real.read();
        	return SUCCESS;	
		} else {
			return 1;	
		}
		
  	}

  	event void Real.readDone(error_t result, uint16_t data) 
  	{
    	signal Main.readDone(SUCCESS, data);
  	}
  	
}
