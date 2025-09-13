class Liquid {
  float x, y, w, h; //floats x,y,w,h for the liquid
  float c; // Coefficient of drag c

  Liquid(float x_, float y_, float w_, float h_, float c_) { // Liquid is a rectangle with the parameters x,y,w,h and c as coefficient of drag
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }


  boolean contains(Food f) {// Is the Food in the Liquid?
    PVector l = f.position;
    if (l.x >= x && l.x <= x + w && l.y >= y && l.y <= y + h) { // Is the food inside the liquid rectangle?
      return true; // Food is within the liquid area
    } else {
      return false; // Food is not within the liquid area
    }
  }

  // Calculate drag force for a given food
  PVector drag(Food f) {
    float speed = f.velocity.mag(); // calculates the speed
    float dragMagnitude = c * speed * speed; // calculates the dragMagnitude

    // Direction is inverse of velocity
    PVector drag = f.velocity.copy(); // Copy the velocity into a new vector
    drag.normalize(); // Scale the vector to a unit vector (normal vektor på dansk, som har længden 1).

    // Scale according to magnitude
    drag.setMag(-dragMagnitude); // Apply the drag magnitude but reversed
    
    return drag; // Return the new drag vector for the given food
  }

  // Display liquid
  void display() {
    noStroke();
    fill(0, 191, 255); // Lighter blue color
    rect(x, y, w, h);
  }
}
