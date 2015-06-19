generic configuration MyConfigurableSensorBlockC (char mode[]){
	provides interface Read<uint16_t> as Main;
	uses interface Read<uint16_t> as RealSensor;
	uses interface SimulationInterface as Simulation;
}
implementation{
	components new MyConfigurableSensorC(mode) as MySensor;
	//components MainC;
	
	MySensor.Main = Main; 
	MySensor.Real = RealSensor;
	MySensor.SimulationInterface = Simulation;
	//MainC.SoftwareInit -> MySensor;
	
}