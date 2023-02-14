

void changeCurve()
{
  switch(waveFormState) {
 
    case TYPOGRAPHY:
    {
      amp = new Amplitude(this);
      amp.input(in);
      
      break;
    }
  }
}
void updateWaveForm()
{
  switch(waveFormState)
  {
    case TYPOGRAPHY:
    {
      depthBg = amp.analyze()*5.5; 
      
      break;
    }
  }
}
