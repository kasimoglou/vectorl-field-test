generic module MyConfigurableSensorC(char mode[])
{
  provides interface Read<uint16_t> as Test;
  uses interface Read<uint16_t> as Real;
}
implementation
{ 
  task void readVectorlValue() {
    signal Test.readDone(SUCCESS, 20);
  }

  command error_t Test.read() {
    if (mode == "test") {
    	dbg("Output", "Simulation reading\n");
		post readVectorlValue();
    	return SUCCESS;
	} else if (mode == "real") {
		dbg("Output", "Reading from real sensor\n");
        call Real.read();	
	}
  }

  event void Real.readDone(error_t result, uint16_t data) 
  {
    	dbg("Output", "Reading from real sensor done\n");
  }

  
}