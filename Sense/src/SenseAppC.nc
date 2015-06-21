/**
 * 
 * Sensing demo application. See README.txt file in this directory for usage
 * instructions and have a look at tinyos-2.x/doc/html/tutorial/lesson5.html
 * for a general tutorial on sensing in TinyOS.
 * 
 * @author Jan Hauer
 */

configuration SenseAppC 
{ 
} 
implementation { 
  
  	components SenseC, MainC;
  	components new TimerMilliC() as PeriodicReading;
  	components LocalTimeMilliC as Timer;
  	components new MyConfigurableSensorBlockC("test") as Sensor;
  	components new DemoSensorC() as RealSensor;
  	components Rabbits;
	
	// Component responsible for sensing
	// It periodically requests for sensor readings
  	SenseC.Boot -> MainC;
  	SenseC.Timer ->PeriodicReading;
  	SenseC.Read -> Sensor;
  	
  	// Our Configurable Component which handles sensing.
  	// If it is on "test" mode it provides results from `SimulatedSensor`.
  	// If it is on "real" mode it provides results from `RealSensor`.
  	Sensor.RealSensor -> RealSensor;
  	Sensor.SimulatedSensor -> Rabbits;
  	Sensor.Simulation -> Rabbits;
  	
  	// Component responsible for environment simulation.
  	// It needs a Timer.
  	Rabbits.Timer -> Timer;
  	
}
