/*
  This sensor component is like DemoSensorC except that
  it instantiates SenseSimulationSensorC module which
  will produce sensor readings
*/
generic configuration MySensorC(){
  provides interface Read<uint16_t>;
}
implementation {
  components new SenseSimulationSensorC();
  Read = SenseSimulationSensorC;
}
