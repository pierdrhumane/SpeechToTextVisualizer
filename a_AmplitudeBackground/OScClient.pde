import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


long lastTime;
String newWord = null;

void initOSC()
{
   oscP5 = new OscP5(this, 8080);

}

void oscEvent(OscMessage theOscMessage) {
  
  //if (theOscMessage.checkAddrPattern("/")) {
    //println("message received:",theOscMessage);
    newWord = theOscMessage.get(0).stringValue();
  //}
}
