void initGeomerative()
{
   RG.init(this);
  grp = RG.getText("HELLO", "humane-regular.ttf", 100, CENTER);
}
RPoint[] getPoints(String word)
{
   grp = RG.getText(word, "humane-regular.ttf", 100, CENTER);
  
  // SHAPE
  RG.setPolygonizer(RG.ADAPTATIVE);
  //grp.draw();

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
  RPoint pointsText[] = grp.getPoints();
  return pointsText;
}
