void keyPressed()
{
  switch(key)
  {
  case 'a':
    animationValue = 0;
    bAni = Ani.to(this, 1.0, "animationValue", 0.5, Ani.QUAD_IN_OUT, "onEnd:wait3");
    bAni.start();
    break;
  case 'n':
    wordsIndex++;
    wordsIndex = wordsIndex%words.length;
    wordToDisplay = words[wordsIndex];
    getTextPoints();
    displayWord();

    break;
  }
}

void phaseOut() {
  bAni = Ani.to(this, 1.0, "animationValue", 1.0, Ani.QUAD_IN_OUT, "onEnd:phaseIn");
  bAni.start();
}

void wait3()
{
  bAni = Ani.to(this, 2.0, "animationValue", 0.5, Ani.QUAD_IN_OUT, "onEnd:phaseOut");
  bAni.start();
}
void phaseIn()
{
}
void updateWord()
{
  if(newWord != null)
  {
    
    wordToDisplay = newWord;
    getTextPoints();
    println("add new word to display",wordToDisplay);
    newWord = null;
    displayWord();
   
  }
}
void displayWord()
{
  if (bAni !=null)
    {
      bAni.end();
      Ani.killAll();
    }
     animationValue = 0;
    bAni =  Ani.to(this, 1.0, "animationValue", 0.5, Ani.QUAD_IN_OUT, "onEnd:wait3");
    bAni.start();
}
