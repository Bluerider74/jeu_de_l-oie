int applyDiceRules(int indexPlayer, int dice1, int dice2) {
  if ((dice1==4 && dice2==5) || (dice1==5 && dice2==4)) {
    comment[indexPlayer] = "Vous avez fait 4 et 5,\n allez en case 53.";
    commentDisplay(indexPlayer, comment[indexPlayer]);
    return boxPosition[53];
  }
  if ((dice1==6 && dice2==3) || (dice1==3 && dice2==6)) {
    comment[indexPlayer] = "Vous avez fait 3 et 6,\n allez en case 26.";
    commentDisplay(indexPlayer, comment[indexPlayer]);
    return boxPosition[26];
  }
  comment[indexPlayer] = "Vous avez fait 6,\n allez en case 12.";
  commentDisplay(indexPlayer, comment[indexPlayer]);
  return boxPosition[12];
}

void applyRules(int indexBoard, int indexPlayer) {
  applyGoose(indexBoard, indexPlayer);
  applyHostel(indexBoard, indexPlayer);
  applyWell(indexBoard, indexPlayer);
  applyLabyrinthe(indexBoard, indexPlayer);
  applyJail(indexBoard, indexPlayer);
  applySkull(indexBoard, indexPlayer);
  applyVictory(indexBoard, indexPlayer);
}
void applyGoose(int indexBoard, int indexPlayer) {
  if (indexBoard==9 || indexBoard==18 || indexBoard==27 || indexBoard==36 || indexBoard==45 || indexBoard==54) {
    if (indexPlayer==-1) {
      fill(255, 255, 0);
      text("O", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      comment[indexPlayer] = "Une Oie!, score de dés est doublé.";
      commentDisplay(indexPlayer, comment[indexPlayer]);
      playerPosition[indexPlayer] = shiftPlayer(indexPlayer, dice[0], dice[1]);
      applyRules(indexBox(playerPosition[indexPlayer]), indexPlayer);
    }
  }
}
void applyHostel(int indexBoard, int indexPlayer) {
  if (indexBoard==19) {
    if (indexPlayer==-1) {
      fill(0, 0, 255);
      text("H", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      hostel[indexPlayer] = 2;
      comment[indexPlayer] = "Bievenue à l'hotel, vous y restez "+hostel[indexPlayer]+" round";
      commentDisplay(indexPlayer, comment[indexPlayer]);
    }
  }
}
void applyWell(int indexBoard, int indexPlayer) {
  if (indexBoard==3) {
    if (indexPlayer==-1) {
      fill(0, 0, 0);
      text("O", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      for (int i=0; i<bottomWell.length; i++) {
        bottomWell[i] = false;
      }
      comment[indexPlayer] = "Vous êtes tombé dans le puit,\n vous devez attendre qu'un autre joueur vous sauve.";
      commentDisplay(indexPlayer, comment[indexPlayer]);
      bottomWell[indexPlayer] = true;
    }
  }
}
void applyLabyrinthe(int indexBoard, int indexPlayer) {
  if (indexBoard==42) {
    if (indexPlayer==-1) {
      fill(0, 200, 0);
      text("L", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      comment[indexPlayer] = "Vous êtes perdu dans le Labyrinthe,\n vous ressortez en case 30.";
      commentDisplay(indexPlayer, comment[indexPlayer]);
      playerPosition[indexPlayer] = shiftPlayer(indexPlayer, -6, -6);
    }
  }
}
void applyJail(int indexBoard, int indexPlayer) {
  if (indexBoard==52) {
    if (indexPlayer==-1) {
      fill(0, 0, 0);
      text("#", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      comment[indexPlayer] = "Vous êtes en Prison,\n attendez qu'un autre joueur vous délivre.";
      commentDisplay(indexPlayer, comment[indexPlayer]);
      prisoner = !prisoner;
    }
  }
}
void applySkull(int indexBoard, int indexPlayer) {
  if (indexBoard==58) {
    if (indexPlayer==-1) {
      fill(255, 0, 0);
      text("X", boxPosition[indexBoard], boxHeight*1.1);
    } else {
      comment[indexPlayer] = "Vous êtes mort, recommencez à la case zéro.";
      commentDisplay(indexPlayer, comment[indexPlayer]);
      playerPosition[indexPlayer] = shiftPlayer(indexPlayer, -29, -29);
    }
  }
}
void applyVictory(int indexBoard, int indexPlayer) {
  if (indexBoard==goal && indexPlayer!=-1) {
    comment[indexPlayer] = "Victoire du joueur "+(indexPlayer+1);
    commentDisplay(indexPlayer, comment[indexPlayer]);
    noLoop();
  }
}
