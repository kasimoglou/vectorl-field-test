generic module SenseSimulationSensorC(char mode[])
{
  provides interface Init;
  provides interface Read<uint16_t>;
}
implementation {

  uint32_t counter;

  command error_t Init.init() {
    counter = TOS_NODE_ID * 40;
    return SUCCESS;
  }
  
  task void readTask() {
    float val = (float)counter;
    val = val / 20.0;
    val = sin(val) * 32768.0;
    val += 32768.0;
    counter++;
    signal Read.readDone(SUCCESS, (uint16_t)val);
  }
  command error_t Read.read() {
    dbg("Output", "You are in %s mode\n", mode);
    post readTask();
    return SUCCESS;
  }
}
