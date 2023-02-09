void displayWord()
{
  if (bAni !=null)
    {
      bAni.end();
      Ani.killAll();
    }
    bAni =  Ani.to(this, 0.3, "b", 1.0, Ani.LINEAR, "onEnd:wait3");
    bAni.start();
}
void phaseOut() {
  bAni = Ani.to(this, 0.2, "b", 0.0, Ani.LINEAR);
  bAni.start();
}

void wait3()
{
  bAni = Ani.to(this, 2.0, "b", 1.0, Ani.LINEAR, "onEnd:phaseOut");
  bAni.start();
}
