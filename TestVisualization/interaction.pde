void keyPressed()
{
  switch(key)
  {
    case 'a':
        bAni = new Ani(this, 0.3, "b",0.0,Ani.LINEAR, "onEnd:wait3");
        bAni.start();
    break;
    case 'n':
      wordsIndex++;
      getTextPoints();
    break;
  }
}

void phaseOut(){
  bAni = new Ani(this, 0.2, "b", 1.0,Ani.LINEAR, "onEnd:phaseIn");
  bAni.start();
}

void wait3()
{
   bAni = new Ani(this, 2.0, "b", 0.0,Ani.LINEAR, "onEnd:phaseOut");
  bAni.start();
}
void phaseIn()
{
  
}
