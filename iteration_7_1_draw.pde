void draw() {
  colorMode(RGB, 255, 255, 255);
  background(100);
  textSize(20);
  fill(255);
  textAlign(LEFT);
  text("Round : "+round, 50, 50);
  println("round "+round);
  playerDisplay();
  textAlign(CENTER);
  boardDisplay();
  pawnDisplay();
  round++;
}
void boardDisplay() {
  for (int i=0; i<boxPosition.length; i++) {
    colorMode(RGB, 255, 255, 255);
    fill(200);
    rect(50+i*boxWidth, 200, width/boxPosition.length, boxHeight/2);
    fill(0);
    textSize(15);
    text(i, boxPosition[i], boxHeight*1.45);
    applyRules(i, -1);
  }
}
void playerDisplay() {
  for (int i=0; i<playerPosition.length; i++) {
    colorMode(HSB, 360, 100, 100);
    fill(50*i, 99, 99);
    text("Joueur "+(i+1), (25+width/playerPosition.length*i), 80);
    println("player "+(i+1));
    if (hostel[i]>0) {
      hostel[i]--;
      comment[i] = "Bievenue à l'hotel, vous y restez "+hostel[i]+" round";
      commentDisplay(i, comment[i]);
    } else if (bottomWell[i] && indexBox(playerPosition[i])==3) {
      comment[i] = "Toujours au fond du puit...";
      commentDisplay(i, comment[i]);
    } else if (prisoner && indexBox(playerPosition[i])==52) {
      comment[i] = "Les rats de la prisons vous chatouillent les pieds...";
      commentDisplay(i, comment[i]);
    } else /*if(dice[0]!=0 && dice[1]!=0)*/ {
      diceRoll();
      text("Résultat des dés : "+dice[0]+" + "+dice[1]+" = "+(dice[0]+dice[1]), (25+width/playerPosition.length*i), 110);
      println(dice[0], " + ", dice[1]);
      playerPosition[i] = shiftPlayer(i, dice[0], dice[1]);
      applyRules(indexBox(playerPosition[i]), i);
    }
    println(comment[i]);
    println("position de ",indexBox(oldPlayerPosition[i])," a ",indexBox(playerPosition[i]));
    comment[i] = "";
  }
}
void pawnDisplay() {
  for (int i=0; i<playerPosition.length; i++) {
    colorMode(HSB, 360, 100, 100);
    fill(50*i, 99, 99);
    circle(playerPosition[i], boxHeight*1.2+20*i, 15);
  }
}
void commentDisplay(int indexPlayer, String comment) {
  colorMode(HSB, 360, 100, 100);
  fill(50*indexPlayer, 99, 99);
  text(comment, (25+width/playerPosition.length*indexPlayer), 140);
}
