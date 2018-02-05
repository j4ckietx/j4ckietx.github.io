PFont f;
import processing.sound.*;
SoundFile file;

float ballX = 500;
float ballY = 400;

int directionX = 1;
int directionY = 1;
float speed = 3;

float x1 = 10;
float x2 = 980;
float y1 = 370;
float y2 = 370;

boolean p1UP = false;
boolean p1DOWN = false;

boolean p2UP = false;
boolean p2DOWN = false;

boolean showMenu = true;
boolean winMenu = false;

int point1 = 0;
int point2 = 0;
int paddleL1 = 100;
int paddleL2 = 100;

void setup() {
    size(1000, 800);
    f = createFont("NovaMono", 80, true);
    file = new SoundFile(this, "bloop.wav");
}

void keyPressed() {
    if (key == 'w') {
        p1UP = true;
    }
    if (key == 's') {
        p1DOWN = true;
    }
    if (key == 32) {
        showMenu = false;
        winMenu = false;
        ballX = 500;
        ballY = 400;
        point1 = point2 = 0;
        x1 = 10;
        x2 = 980;
        y1 = 370;
        y2 = 370;
        paddleL1 = paddleL2 = 100;
    }
    if (key == 8) {
        showMenu = true;
        winMenu = false;
        point1 = point2 = 0;
    }

    if (key == CODED) {
        if (keyCode == UP) {
            p2UP = true;
        }
        if (keyCode == DOWN) {
            p2DOWN = true;
        }
    }

}

void keyReleased() {
    //println("release: " + key);
    if (key == 'w') {
        p1UP = false;
    }
    if (key == 's') {
        p1DOWN = false;
    }
    if (key == CODED) {
        if (keyCode == UP) {
            p2UP = false;
        }
        if (keyCode == DOWN) {
            p2DOWN = false;
        }
    }
}

void draw() {
    background(20);
    fill(230);
    println(speed);

    //line
    for (int dot = 0; dot < 40; dot++) {
        int dotx = 500;
        int doty = 20 * dot;
        rect(dotx, doty, 10, 10);
    }

    //score
    textFont(f, 50);
    text(point1, 412, 100);
    text(point2, 575, 100);
    
    if (point1 >= 5 || point2 >= 5) {
        winMenu = true;
    }

    //ball
    if (showMenu != true) {
        ballX = ballX + directionX * speed;
        ballY = ballY + directionY * speed;
    } 
    if (ballX >= 1000 - 10) {
        ballX = 500;
        ballY = 400;
        point1 += 1;
        paddleL2 -= 20;
        file.play();
    }
    if (ballX <= 0) {
        ballX = 500;
        ballY = 400;
        point2 += 1;
        paddleL1 -= 20;
        file.play();
    }

    if (ballY >= 800 - 10 || ballY <= 0) {
        directionY = -directionY;
    }
    if (ballX >= x2 - 10 && ballY <= y2 + paddleL2 && ballY >= y2) {
        directionX = -abs(directionX);
        speed += 0.25;
    }
    if (ballX <= x1 + 10 && ballY <= y1 + paddleL1 && ballY >= y1) {
        directionX = abs(directionX);
        speed += 0.25;
    }
    fill(255, 243, 10);
    rect(ballX, ballY, 10, 10);



    //paddles
    if (p1UP == true) {
        y1 -= 8;
    } else if (p1DOWN == true) {
        y1 += 8;
    }
    if (p2UP == true) {
        y2 -= 8;
    } else if (p2DOWN == true) {
        y2 += 8;
    }

    if (y1 >= 800 - paddleL1) {
        y1 = 800 - paddleL1;
    } else if (y1 <= 0) {
        y1 = 0;
    }

    if (y2 >= 800 - paddleL2) {
        y2 = 800 - paddleL2;
    } else if (y2 <= 0) {
        y2 = 0;
    }

    fill(250);
    rect(x1, y1, 10, paddleL1);
    rect(x2, y2, 10, paddleL2);

    if (showMenu) {
        fill(20);
        rect(0, 0, 1000, 800);
        fill(250);
        textFont(f, 32);
        text("pong game", 50, 50);
        text("player 1: [q] / [a] to move", 50, 120);
        text("player 2: [up] / [down] to move", 50, 190);
        text("press [space] to start", 50, 330);
        text("press [backspace] to quit", 50, 400);
    }
    
    if (winMenu) {
        ballX = 500;
        ballY = 400;
        fill(255, 220, 18);
        rect(0, 0, 1000, 800);
        noStroke();
        fill(0);
          for (int dot = 0; dot < 40; dot++) {
          int dotx = 500;
          int doty = 20 * dot;
          rect(dotx, doty, 10, 10);
          }
        if (point1 >= 5){
            textFont(f, 80);
            text("you win", 100, 200);
            textFont(f, 26);
            text("press [space] to restart", 80, 500);
            text("press [backspace] to quit", 80, 560);
        } else {
            textFont(f, 80);
            text("you win", 600, 200);
            textFont(f, 26);
            text("press [space] to restart", 550, 500);
            text("press [backspace] to quit", 550, 560);
        }
    }
}