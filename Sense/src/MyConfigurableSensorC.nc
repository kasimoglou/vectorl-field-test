generic module MyConfigurableSensorC(char mode[])
{
  provides interface Read<uint16_t> as Main;
  uses interface Read<uint16_t> as Real;
  uses interface Read<uint16_t> as Simulation;
  uses interface SimulationInterface as RuntimeEngine;
  provides interface Init;
}

implementation
{
	uint8_t counter = 0;
	 
  	// When a component wants to read a measurement from us
	// we check whether user has selected "real" or "test" mode.
	
	// In case we are in "real mode", user wants to read a real sensor
	// measurement so we forward the `read` call to whatever sensor component
	// user has selected.
	
	// If user has selected "test" mode, it means that we have to
    // start a vectorl simulation
  	command error_t Main.read(){
  		if (mode == "test") {
			call Simulation.read();
    		return SUCCESS;
		
		} else if (mode == "real") {
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
  	
  	event void Simulation.readDone(error_t result, uint16_t data){
		// TODO Auto-generated method stub
		signal Main.readDone(SUCCESS, data);
	}

	command error_t Init.init(){
		// TODO Auto-generated method stub
		if (mode == "test") {
			dbg("Output", "Simulation mode. Starting\n");
			call RuntimeEngine.initializeSimulation();
				
		} else {
			dbg("Output", "Real mode. Starting\n");
		}
		return SUCCESS;
	}

}
