/**
 * 
 * Sensing demo application. See README.txt file in this directory for usage
 * instructions and have a look at tinyos-2.x/doc/html/tutorial/lesson5.html
 * for a general tutorial on sensing in TinyOS.
 *
 * @author Jan Hauer
 */

module SenseC
{
	uses {
    	interface Boot;
	    interface Timer<TMilli>;
	    interface Read<uint16_t>;
	}
}
implementation
{
  // sampling frequency in binary milliseconds
  #define SAMPLING_FREQUENCY 100
  
  event void Boot.booted() {
    	dbg("Output", "Application Booted in Sensor\n");
    	call Timer.startPeriodic(SAMPLING_FREQUENCY);
  }

  event void Timer.fired() 
  {
   		call Read.read();
  }

  event void Read.readDone(error_t result, uint16_t data) 
  {
    	if (result == SUCCESS){
      		dbg("Output", "SENSOR SIMULATION: Time is %u and sensor reads %u rabbits.\n", call Timer.getNow() ,data);
    	}
  }
}
