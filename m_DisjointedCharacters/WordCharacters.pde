class CharContainer
{
  RShape[] charShapes = new RShape[10];
  ParticleCharacter[] particles = new ParticleCharacter[10];
  float lerpVal = 0.0;
  float animVal = 0.0;
  Ani wcAnimation;
  boolean isPlaying = false;
  boolean didEnd = false;
  boolean didOutroBefore = false;
  float lengthOfOutro = 1.5;
  String internalWord;
  void play()
  {
    isPlaying= true;
    didEnd = false;
    
    wcAnimation = new Ani(this, 1.0, "animVal", 0.5, Ani.QUAD_IN_OUT, "onEnd:stay");
    println(" play "+internalWord);
  }
  void outro()
  {
    println( " outro out "+internalWord);
    if(!didOutroBefore)
    {
      println( " outro "+internalWord);
      
      wcAnimation = new Ani(this,lengthOfOutro, "animVal", 1.0, Ani.QUAD_IN_OUT, "onEnd:end");
      didOutroBefore = true;
    }
    
  }
  void stay()
  {
    if(!didOutroBefore)
    {
      println( " stay "+internalWord);
      wcAnimation = new Ani(this, 1.0, "animVal", 0.5, Ani.QUAD_IN_OUT, "onEnd:outro");
    }
  }
  void end()
  {
    didEnd = true;
    println(" finished animation "+internalWord);
  }
  
}
