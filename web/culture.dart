import 'dart:math';

// The World in which the cells live.
class culture {

  var cellDish = {};
  int width = 80;
  var rng = new Random();

  culture() {

    //growth
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < width; y++) {
        cellDish["$x-$y"] = new cell(x, y, cellDish);
      }
    }
  }

  // Set population - ignoring repeats.
  void initPopulation(int Pop) {
    for (int i = 0; i < Pop; i++) {
      add(rng.nextInt(width), rng.nextInt(width));
    }
  }

  void add(x, y) {
    cell c = cellDish["$x-$y"];
    c.state = 1;
  }

  void update() {
    cellDish.forEach((k, c) => c.update());
    cellDish.forEach((k, c) => c.commit());
  }

}

// The Cellular Level Object.
class cell {

  cell(this.x, this.y, this.Environment);
  int x, y;
  Map Environment;
  int state = 0;
  int nextState = -1;
  int age = 0;
  int updates = 0;

  void update() {
    int n = getNeighbours();
    updates++;
    if ((state == 1 && n == 2) || n == 3) {
      nextState = 1;
      age++;
    } else {
      nextState = 0;
      age = 0;
    }

  }

  void commit() {
    state = nextState;
  }

  int getNeighbours() {
    int n = 0;

    if (isNeighbourPopulated(x - 1, y - 1)) n++;
    if (isNeighbourPopulated(x, y - 1)) n++;
    if (isNeighbourPopulated(x + 1, y - 1)) n++;

    if (isNeighbourPopulated(x - 1, y)) n++;
    if (isNeighbourPopulated(x + 1, y)) n++;

    if (isNeighbourPopulated(x - 1, y + 1)) n++;
    if (isNeighbourPopulated(x, y + 1)) n++;
    if (isNeighbourPopulated(x + 1, y + 1)) n++;

    //print("$n");
    return n;
  }

  bool isNeighbourPopulated(int nx, int ny) {
    var t = Environment["$nx-$ny"];
    if (t == null) return false;
    if (t.state == 1) {
      return true;
    } else {
      return false;
    }
  }
}
