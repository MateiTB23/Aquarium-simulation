// Liquid
Liquid liquid;
// Wind
Wind wind;
Food[] foods = new Food[18]; // Define the foods array
import controlP5.*;

ControlP5 cp5;
Button westWindButton, eastWindButton, resetButton;
float windStrength = 0.00; // Initial wind strength
float displayedWindStrength = 0.00; // Initial displayed wind strength
float windIncrement = 0.002; // Amount to increase wind strength

void setup() {
  size(1280, 720); //size of canvas
   wind = new Wind(random(1, 2), 0); // initialize new wind object 
  resetSimulation(); // Resetting the simulation
  liquid = new Liquid(0, height/2, width, height/2, 0.1);  // Initialize liquid object
  // Create wind object
 

  // Initialize ControlP5 libary, which i use for buttons
  cp5 = new ControlP5(this);

  // Button for adding wind to the west direction
  westWindButton = cp5.addButton("increaseWestWind")
    .setPosition(170, 20)
    .setSize(140, 40)
    .setLabel("Wind to the West")
    .setFont(createFont("Arial-BoldMT", 12))
    .setColorBackground(color(185))
    .setColorActive(color(200));

  // Button for adding wind to the east direction
  eastWindButton = cp5.addButton("increaseEastWind")
    .setPosition(330, 20)
    .setSize(140, 40)
    .setLabel("Wind to the East")
    .setFont(createFont("Arial-BoldMT", 12))
    .setColorBackground(color(185))
    .setColorActive(color(200));

  // Button for resetting the simulation 
  resetButton = cp5.addButton("resetSimulation")
    .setPosition(20, 20)
    .setSize(140, 40)
    .setLabel("Reset Simulation")
    .setFont(createFont("Arial-BoldMT", 12))
    .setColorBackground(color(185))
    .setColorActive(color(200));
}

void draw() {
  background(0); // make the background black

  liquid.display(); // Draw the water
  for (Food food : foods) { // for every food in foods
    if (liquid.contains(food)) { // Is the food in the liquid?
      PVector drag = liquid.drag(food); // Calculate drag force on the food
      food.applyForce(drag);   // Apply drag force to food
    } else {
      food.applyForce(wind.forceWind); // apply wind on food if not in liquid
    }

    // Gravity is scaled by mass here!
    PVector gravity = new PVector(0, 0.01*food.mass); // gravity vector based on foods mass 
    food.applyForce(gravity); // Apply gravity

    // Update and display
    food.update(); 
    food.display();
    food.checkEdges();
  }

  fill(255);
  // display wind strength and direction
  if(wind.forceWind.x>0){
     text("Wind strength is currently: " + wind.forceWind.x*1000 + "m/s" + " to the west", 20, 80);
  } if(wind.forceWind.x<0) {
    text("Wind strength is currently: " + wind.forceWind.x*(-1000) + "m/s" + " to the east", 20, 80);
  } else{
     text("Wind strength is currently: " + wind.forceWind.x*1000 + "m/s", 20, 80);
  }
}

void increaseWestWind() { // increaseWestWind function
  wind.forceWind.x -= windIncrement; // Set wind force to the West
  displayedWindStrength = wind.forceWind.x; // Update displayed wind strength
}

void increaseEastWind() { // increaseEastWind function
  wind.forceWind.x += windIncrement; // Set wind force to the East
  displayedWindStrength = wind.forceWind.x; // Update displayed wind strength
}


void resetSimulation() { // resetSimulation function
  wind.forceWind.set(0, 0); // Set wind force to zero
  for (int i = 0; i < foods.length; i++) {
    foods[i] = new Food(random(0.5, 3), 40+i*70, 0); // re-instantiate all food objects
  }
}
