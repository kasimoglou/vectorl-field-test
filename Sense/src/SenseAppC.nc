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
  	components new TimerMilliC();
  	components new MyConfigurableSensorBlockC("test") as Sensor;
  	components new DemoSensorC() as RealSensor;
  	components Rabbits;

  	SenseC.Boot -> MainC;
  	SenseC.Timer -> TimerMilliC;
  	SenseC.Read -> Sensor;
  	Sensor.RealSensor -> RealSensor;
  	Sensor.Simulation -> Rabbits;
}
