
//void sortPoints(RPoint[] arr) {
//  RPoint reference = arr[0];
//  PVector refVector = new PVector(reference.x, reference.y);
//  for (int i = 0; i < arr.length - 1; i++) {
//    for (int j = 0; j < arr.length - 1 - i; j++) {
//      PVector currentVector = new PVector(arr[j].x, arr[j].y);
//      if (PVector.dist(refVector,currentVector) > PVector.dist(new PVector(arr[i].x, arr[i].y),refVector)) {
//        RPoint temp = arr[j];
//        arr[j] = arr[j + 1];
//        arr[j + 1] = temp;
//      }
//    }
//  }
//}
//void sortPoints(RPoint[] arr) {
//  for (int i = 0; i < arr.length - 1; i++) {
//    RPoint reference = arr[i];
//    PVector refVector = new PVector(reference.x, reference.y);
//    for (int j = i + 1; j < arr.length; j++) {
//      PVector currentVector = new PVector(arr[j].x, arr[j].y);
//      if (PVector.dist(currentVector, refVector) < PVector.dist(new PVector(arr[i].x, arr[i].y), refVector)) {
//        RPoint temp = arr[i];
//        arr[i] = arr[j];
//        arr[j] = temp;
//      }
//    }
//  }
//}
RPath cycleThroughAllPoints()
{
  
  RPoint leftmost = mergedPoints[0];
  for (int i = 1; i < mergedPoints.length; i++) {
    if (mergedPoints[i].x < leftmost.x) {
      leftmost = mergedPoints[i];
    }
  }
  
  RPoint current = leftmost;
  RPoint endpoint = null;
  RPath envelope = new RPath();
  do {
    envelope.addLineTo(current);
    endpoint = mergedPoints[0];
    for (int i = 1; i < mergedPoints.length; i++) {
      if (endpoint == current || crossProduct(current, endpoint, mergedPoints[i]) < 0) {
        endpoint = mergedPoints[i];
      }
    }
    current = endpoint;
  } while (endpoint != leftmost);
  return envelope;
}
float crossProduct(RPoint A, RPoint B, RPoint C) {
  return (B.x - A.x) * (C.y - A.y) - (B.y - A.y) * (C.x - A.x);
}


/*
RPoint[] mergeTwoArraysWithQuantifiedUnion()
{
  ArrayList<RPoint> arrTmp = new ArrayList<RPoint>();
  for(int i=0;i<pointsWave.length;i++)
  {
    RPoint wavePoint = pointsWave[i];
    int xTmp = parseInt( wavePoint.x );
    boolean isThereATextPoint = false;
    for(int j=0;j<pointsText.length;j++)
    {
      RPoint textPoint = pointsText[j];
      if(textPoint.x == xTmp)
      {
        isThereATextPoint = true;
        if(textPoint.y<height*0.2)
        {
          arrTmp.add(textPoint);
        }
      }
      
    }
    if(!isThereATextPoint)
    {
      arrTmp.add(wavePoint);
    }
  }
  return arrTmp.toArray(new RPoint[arrTmp.size()]);
  
}
*/
