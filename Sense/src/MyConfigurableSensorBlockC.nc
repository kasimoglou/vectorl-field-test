generic configuration MyConfigurableSensorBlockC (char mode[]){
	provides interface Read<uint16_t> as Main;
	uses interface Read<uint16_t> as RealSensor;
	uses interface Read<uint16_t> as SimulatedSensor;
	uses interface SimulationInterface as Simulation;
	
}
implementation{
	components new MyConfigurableSensorC(mode) as MySensor;
	components new TimerMilliC() as RuntimeTimer;
	components Runtime;
	components MainC;
	
	MySensor.Main = Main; 
	MySensor.Real = RealSensor;
	
	MySensor.Simulation = SimulatedSensor;
	MySensor.RuntimeEngine -> Runtime;
	
	Runtime.SimulationInitializer = Simulation;
	Runtime.EventTimer -> RuntimeTimer;
	
	MainC.SoftwareInit -> MySensor;
	
}