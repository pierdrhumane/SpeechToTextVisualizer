

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
       
      break;
    }
  }
}

void addToArray(float value) {
  System.arraycopy(valuesRipple, 0, valuesRipple, 1, valuesRipple.length - 1);
  valuesRipple[0] = value;
}
