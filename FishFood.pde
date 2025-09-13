class Food {
  // position, velocity, and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;

  // Mass is tied to size
  float mass;
  // PShape for SVG image
  PShape foodShape;

 //food constructor with food taking in 3 variables
  Food(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    // Load SVG image for food
    foodShape = loadShape("FishFood.svg");
  }

  // Newton's 2nd law: F = M * A
  // or A = F / M
  void update() {
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // position changes by velocity
    position.add(velocity);
    // We must clear acceleration each frame
    acceleration.mult(0);
  }

  // Apply force to the food
  void applyForce(PVector force) {
    // Divide by mass
    PVector f = PVector.div(force, mass);
    // Accumulate all forces in acceleration
    acceleration.add(f);
  }

  // Draw food
  void display() {
    shapeMode(CENTER);
    stroke(255);
    strokeWeight(2);
    fill(255, 200);
    shape(foodShape, position.x, position.y, mass*16, mass*16); // Adjust size based on mass
  }

  // Bounce off bottom of canvas
  void checkEdges() {
    if (position.y >= height) {
      velocity.y *= -0.4;  // A little dampening when hitting the bottom
      position.y = height;
    }
  }
}
