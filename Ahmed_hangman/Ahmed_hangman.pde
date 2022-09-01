/*
  Hangman
 by: Mrs. Parsons
 
 Pick a work or phrase from a file
 show the player underscores for letters
 visual representation of errors (hangman)
 letter chosen or not chosen
 */
PFont cs;
String [] mItems = {"START"};
String [] dictionary;
String word;
char[] guess;
int errors =0;
PImage back, testImg;
PImage [] errImg = new PImage[10];
char [] alpha = new char[26];
int level = 0; // 0 menu 1 play 2 win 3 lose
int turn = 0; // 0 start 1 player 2 ai
void setup()
{
  dictionary = loadStrings("words.txt");
  cs=loadFont("CourierNewPS-BoldMT-48.vlw");
  size(1200, 700);
  back = loadImage("back.jpg");
  //testImg = loadImage("error.png");
  for (int i=0; i<errImg.length; i++)
    errImg[i] = loadImage("man"+ (i+1) +".png");
    //if(level ==0)
  //{
  // errImg.length
  //}
}
void draw()
{
  if (level == 0)
  {
    showMenu();
  }
  if (level == 1)
  {
    if (turn == 0)
      pickWord();
    showHangman();
  }
  if (level>1)
  {
    showEnding();
  }
}
void keyTyped()
{
  if (level == 1 && turn == 1)
    checkWord(key);
}
void mousePressed()
{
  if (level==0 && mouseX>100 && mouseX<100+200
    && mouseY >400 && mouseY< 400+60+50)
  {
    level=1;
    turn=0;
  }
  if (level==1 && mouseX>900 && mouseX<900+200
    && mouseY >400 && mouseY< 400+50)
  {
    turn = 0;
    level = 1;
  }
  if (level>1 && mouseX>900 && mouseX<900+200
    && mouseY >400 && mouseY< 400+50)
    level=0;
  
}
void pickWord()
{
  turn=1;
  word = dictionary[(int) random(dictionary.length)];
  guess = new char[word.length()];
  for (int i=0; i<guess.length; i++)
    if ((word.charAt(i)>='a' &&word.charAt(i)<='z')
      ||(word.charAt(i)>='A' &&word.charAt(i)<='Z'))
      guess[i] ='_';
    else guess[i] = word.charAt(i);
  for (int i=0; i<alpha.length; i++)
    alpha[i] = char('a'+i);
  errors=0;
}

void showHangman()
{
  if (level == 1)
    for (int i=0; i<guess.length; i++)
    {
      fill(#F5E4DA);
      text(guess[i], 100+40*i, 120);
    }
  image(back, 0, 0, width, height);
  textSize(30);
  for (int i=0; i<guess.length; i++)
    text(guess[i], 100+40*i, 120);
  //alphabet
  textSize(30);
  for (int i=0; i<alpha.length; i++)
    text(alpha[i], 50+35*i, 540);
  //show errors
  for ( int i=0; i<errors; i++)
  {
    image(errImg[i], 400, 150, 450, 350);
    if (level==2 || level ==3)
      i=0;
  }
  for (int i=0; i<2; i++)
  {
    if (mouseX>900 && mouseX<900+200
      && mouseY >400 && mouseY< 400+50)
      fill(#DBC0B1);
    else fill (#F5E4DA);
    rect(900, 400, 200, 50, 20);
    textSize(40);
    fill(#240510);
    text ("Reset", 940, 435, 20);
  }
}
void showEnding()
{
  fill(255);
  image(back, 0, 0, width, height);
  textSize(50);
  if (level == 2)
    text ("You won", 500, 200);
  if (level == 3)
  {
    text ("You lost", 500, 200);
    text("The word was:"+word, 400, 300);
  }
  rect(900, 400, 200, 50, 20);
  textSize(40);
  fill(#240510);
  text ("Restart", 910, 435, 20);
}
void checkWord(char c)
{
  boolean placed=false;
  if (c>='A' &&c<='Z')
    c= char(c+32);
  if (c>='a' &&c<='z')
  {
    if (alpha[c - 'a'] == 'X')
      return;
    alpha[c-'a'] = 'X';
    for (int i=0; i<word.length(); i++)
    {
      if (c == word.toLowerCase().charAt(i))
      {
        guess[i] = word.charAt(i);
        placed=true;
        if (win())
          level=2;
      }
    }
    if (!placed)
      errors++;
    if (errors>9)
    {
      level=3;
    }
  }
}
void showMenu()
{
  image (back, 0, 0, width, height);
  fill (#F5E4DA);
  textFont (cs);
  textSize(85);
  text ("Hangman", 60, 130);
  textFont (cs);
  textSize(40);
  text("Guess the word", 60, 170);
  noStroke();
  for (int i=0; i<1; i++)
  {
    if (mouseX>100 && mouseX<100+200
      && mouseY >400+i*60 && mouseY< 400+i*60+50)
      fill(#DBC0B1);
    else fill (#F5E4DA);
    rect(100, 400+i*60, 200, 50, 20);
    fill(#240510);
    text (mItems [i], 150, 435+i*60, 20);
  }
}
boolean win()
{
  for (int i=0; i<guess. length; i++)
    if (guess[i] == '_')
      return false;
  return true;
}
