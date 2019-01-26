class Star {
  int x, y;
  int distance;
  
  Star () {
    this.x = (int)random (1, width-2);
    this.y = 0;
    this.distance = (int)random (1, 6);
  }
  void move () {
    this.y+= this.distance;
    
  }
  void draw () {
    stroke ((int)map (this.distance, 1, 5, 64, 255));
    ellipse (this.x, this.y, 1, 1);
  }
}
class Rock {
  int x, y;
  PImage rock_img;
  
  boolean active;
  
  int speed;
  
  Rock (int x, int y) {
    this.x = x;
    this.y = y;
    this.rock_img = loadImage ("rock.png");
    this.speed = (int)random (1, 10);
    this.active = true;
  }
  void erase () {
    this.active = false;
  }
  void move () {
    this.y+= speed;
  }
  void draw () {
    image (this.rock_img, this.x, this.y);
  }
}
class Ship {
  int x, y;
  PImage ship_img;
    
  Ship (int x, int y) {
    this.x = x;
    this.y = y;
    
    this.ship_img = loadImage ("ufo.png");
  }
  void move (int new_x, int new_y) {
    this.x = new_x;
    this.y = new_y;
  }
  void draw () {
    image (this.ship_img, this.x, this.y);
  }
}

Ship ship;
ArrayList rocks;

int gr = 0;
int er = 0;

void setup () {
  size (400, 600);
  ship = new Ship (width/2, (height/3)*2);
  
  this.rocks = new ArrayList ();
  noCursor ();
}
void draw () {
  spawnRock ();
  ship.move (mouseX, mouseY);
  moveRocks ();
  
  background (0);
  
  ship.draw ();
  drawRocks ();
  
  mantainRocks ();
  
  String s = "gen: "+str (gr)+"\nel: "+str (er)+"\nreal: "+str (rocks.size ());
  text (s, 20, 20);
}
void spawnRock () {
  if (random (0, 1000)>980) {
    Rock rock = new Rock ((int)random (30, width-60), 0);
    rocks.add (rock);
    gr++;
  }
}
void moveRocks () {
  for (int i=0; i<rocks.size (); i++) {
    Rock rock = (Rock)rocks.get (i);
    rock.move ();
    
    if (rock.y>height) rock.erase ();
  }
  
}
void drawRocks () {
  for (int i=0; i<rocks.size (); i++) {
    Rock rock = (Rock)rocks.get (i);
    image (rock.rock_img, rock.x, rock.y);
  }
}
void mantainRocks () {
  int index = 0;
  while (index<rocks.size ()) {
    Rock rock = (Rock)rocks.get (index);
    if (!rock.active) {
      rocks.remove (index);
      er++;
    } else index++;
  }
}