

void changeCurve()
{
  switch(waveFormState) {
  case FFT:
    {
      waveform = null;
      amp= null;
      fft = new FFT(this, bands);
      fft.input(in);
      //STARTING FFT
      println("starting FFT");
      positionParticlesOnALine();
      break;
    }
  case WAVE:
    {
      fft = null;
      amp= null;
      waveform = new Waveform(this, bands);
      waveform.input(in);
      positionParticlesOnALine();
      break;
    }
  case RIPPLE:
    {
      fft = null;
      waveform = null;
      amp = new Amplitude(this);
      amp.input(in);

      float diameter = 10;
      float numOfParticlesCycle = 6;
      float index = 0;
      for (int i = 0; i<particles.length; i++)
      {
        if (index >numOfParticlesCycle)
        {
          diameter *=2;
          numOfParticlesCycle *=1.5;
          index = 0;
        }

        float angle = index/numOfParticlesCycle;
        particles[i].position.x = cos(angle*TWO_PI)*diameter;
        particles[i].position.y = sin(angle*TWO_PI)*diameter;
        particles[i].originalPos.x = particles[i].position.x;
        particles[i].originalPos.y = particles[i].position.y;
        particles[i].setTarget(new PVector(particles[i].position.x, particles[i].position.y));
        index++;
      }
      break;
    }
    case TYPOGRAPHY:
    {
      break;
    }
  case WAVE_SHAPE:
    {
      fft = null;
      amp= null;
      waveform = new Waveform(this, bands);
      waveform.input(in);
      positionParticlesOnALine();
      break;
    }
  }
}
void updateWaveForm()
{
  if (waveFormState == FFT)
  {
    fft.analyze(spectrum);
  } else if (waveFormState == WAVE)
  {
    waveform.analyze(spectrum);
  } else if (waveFormState == RIPPLE)
  {
    addToArray(amp.analyze());
  }
}
//void addToArray(float value) {
//  for (int i = valuesRipple.length - 1; i > 0; i--) {
//    valuesRipple[i] = valuesRipple[i-1];
//  }
//  valuesRipple[0] = value;
//}

void addToArray(float value) {
  System.arraycopy(valuesRipple, 0, valuesRipple, 1, valuesRipple.length - 1);
  valuesRipple[0] = value;
}
void positionParticlesOnALine()
{
  float unit = width/particles.length;
  for (int i = 0; i<particles.length; i++)
  {
    particles[i].position.x = (unit*i)-width/2;
    particles[i].position.y =  height/2;
    particles[i].setTarget(new PVector(particles[i].position.x, particles[i].position.y));
  }
}
