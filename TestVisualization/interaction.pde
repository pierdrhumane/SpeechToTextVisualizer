void keyPressed()
{
  switch(key)
  {
  case 'a':
    bAni = Ani.to(this, 0.3, "b", 0.0, Ani.LINEAR, "onEnd:wait3");
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
  bAni = Ani.to(this, 0.2, "b", 1.0, Ani.LINEAR, "onEnd:phaseIn");
  bAni.start();
}

void wait3()
{
  bAni = Ani.to(this, 2.0, "b", 0.0, Ani.LINEAR, "onEnd:phaseOut");
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
    bAni =  Ani.to(this, 0.3, "b", 0.0, Ani.LINEAR, "onEnd:wait3");
    bAni.start();
}
