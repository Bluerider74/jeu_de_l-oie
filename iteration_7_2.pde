int[] boxPosition = new int[64];
int[] playerPosition = new int[2];
int[] oldPlayerPosition;
int[] pawnPosition;
int[] hostel;
int[] dice = new int[2];
int boxWidth, boxHeight, goal, round, playerCount;
String[] comment;
boolean[] bottomWell;
boolean prisoner, playerRound;

void setup() {
  size(1400, 400);
  frameRate(2);
  initBoard();
  letsGame();
}

void initBoard() {
  boxWidth = (width-100)/boxPosition.length;
  boxHeight = 200;
  for (int i=0; i<boxPosition.length; i++) {
    boxPosition[i] = 50+i*boxWidth+boxWidth/2;
  }
}

void diceRoll() {
  for (int i=0; i<dice.length; i++) {
    dice[i] = (int)random(1, 7);
  }
}

int indexBox(int xPosition) {
  int index = 0;
  while (boxPosition[index]<xPosition) {
    index++;
  }
  return index;
}

int shiftPlayer(int indexPlayer, int dice1, int dice2) {
  oldPlayerPosition[indexPlayer] = playerPosition[indexPlayer];
  if (round==1 && (dice1+dice2==9 || dice1+dice2==6)) {
    return applyDiceRules(indexPlayer, dice1, dice2);
  }
  int newIndex = indexBox(playerPosition[indexPlayer])+dice1+dice2;
  if (newIndex > goal) {
    return boxPosition[goal-(newIndex-goal)];
  }
  for(int i=0;i<playerPosition.length;i++){
    if(playerPosition[i] == boxPosition[newIndex]){
      comment[indexPlayer] = "vous tombez sur le joueur "+(i+1)+"\n allez à son ancienne position case : "+indexBox(oldPlayerPosition[i]);
      commentDisplay(indexPlayer, comment[indexPlayer]);
      return oldPlayerPosition[i];
    }
  }
  return boxPosition[newIndex];
}

void letsGame() {
  pawnPosition = new int[playerPosition.length];
  bottomWell = new boolean[playerPosition.length];
  for (int i=0; i<playerPosition.length; i++) {
    playerPosition[i] = boxPosition[0];
    pawnPosition[i] = boxPosition[0];
    bottomWell[i] = false;
  }
  oldPlayerPosition = new int[playerPosition.length];
  comment = new String[playerPosition.length];
  round = 1;
  hostel = new int[playerPosition.length];
  goal = boxPosition.length-1;
  playerCount = 0;
}
