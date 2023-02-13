class WordContainer
{
  RShape[] charShapes = new RShape[10];
  ParticleCharacter[] particles = new ParticleCharacter[10];
  float lerpVal = 0.0;
  float animVal = 0.0;
  Ani wcAnimation;
  boolean isPlaying = false;
  boolean didEnd = false;
  boolean didOutroBefore = false;
  String internalWord;
  void play()
  {
    isPlaying= true;
    didEnd = false;
    
    wcAnimation = new Ani(this, 1.5, "animVal", 0.5, Ani.QUAD_IN_OUT, "onEnd:stay");
    println(internalWord + " play");
  }
  void outro()
  {
    if(!didOutroBefore)
    {
      println(internalWord + " outro");
      wcAnimation = new Ani(this,1.5, "animVal", 1.0, Ani.QUAD_IN_OUT, "onEnd:end");
      didOutroBefore = true;
    }
  }
  void stay()
  {
    println(internalWord + " stay");
    wcAnimation = new Ani(this, 1.0, "animVal", 0.5, Ani.QUAD_IN_OUT, "onEnd:outro");
  }
  void end()
  {
    didEnd = true;
    println(internalWord+" finished animation");
  }
  
}
