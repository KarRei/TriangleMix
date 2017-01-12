/*
  Creates a triangle-cloud visual. The color scheme of the cloud is based
  on the album cover from a Spotify track.
  
  Author: Karin Reidarman

*/

int numParticles = 300; //Number of potential triangle-vertices
ArrayList<Triangle> triangles;
Particle[] parts = new Particle[numParticles];

PImage albumCover;

void setup() {
  fullScreen(P3D);
  
  // Get info from Spotify Web API
  String baseURL = "https://api.spotify.com/v1/tracks/";
  //THE ID OF THE SPOTIFY TRACK
  String trackID = "2HvhaceS88NpdOdTavv41q"; // "3IKrvhLZtyDpHVNe9rqxED";
  JSONObject json = loadJSONObject(baseURL + trackID);
  JSONObject album = json.getJSONObject("album");
  JSONArray images = album.getJSONArray("images");
  JSONObject bigImage = images.getJSONObject(0);
  String albumCoverURL = bigImage.getString("url");
  
  //Load the album cover
  albumCover = loadImage(albumCoverURL, "jpg");
  
  //Fill the part-array with Particle objects
  for(int i = 0; i < numParticles; i++) {
    parts[i] = new Particle();
  }
}

void draw() {
  background(20);
  
  //Translate the cloud to the middle of the screen and rotate the scene
  translate(width/2, height/2);
  rotateY(frameCount/90.0);
  rotateX(frameCount/100.0);
  
  triangles = new ArrayList<Triangle>();
  Particle p1, p2;
   
  // Move the particles
  for (int i = 0; i < numParticles; i++) {
    parts[i].move();
  }

  // Fill the neighboors-arrayList of each particle
  for(int i = 0; i < numParticles; i++) {
    p1 = parts[i];
    p1.neighboors = new ArrayList<Particle>();
    p1.neighboors.add(p1); //Add the current particle to the list
    
    // Go throught the rest of the particles
    for (int j = i+1; j < numParticles; j++){ 
      p2 = parts[j];
      float d = PVector.dist(p1.pos, p2.pos); //d = distance between the two particles
      
      // Check if the distance between the particles is less than DIST_MAX
      if (d > 0 && d < Particle.DIST_MAX) {
        p1.neighboors.add(p2);
      }
    }
    
    //If there is at least 3 particles (vertices), a triangle can be made
    if (p1.neighboors.size() > 2) {
      addTriangles(p1.neighboors);
    }
  }
  drawTriangles();
}

void drawTriangles()
{ 
  beginShape(TRIANGLES);
  //Draw all the triangles in the arrayList
  for (int i = 0; i < triangles.size(); i ++)
  {
    Triangle t = triangles.get(i);
    // Find the x-,y-values of the middle-point of the triangle
    PVector pos = t.getMiddle();
    // Map the values on to the albumCover and find the color of the image in that pixel
    int x = (int)map(pos.x, -250, 250, 0, albumCover.width);
    int y = (int)map(pos.y, -250, 250, 0, albumCover.height);
    color pix = albumCover.get(x, y);
    // Assign the color to the triangle
    fill(pix, 30);
    stroke(max(pix-15, 0), 30);
    t.display();
  }
  endShape();  
}

void addTriangles(ArrayList<Particle> p_neighboors)
{
  int size = p_neighboors.size();
  // Check that there is at least 3 particles, then a triangle can be drawn
  if (size > 2)
  {
    for (int i = 1; i < size-1; i ++)
    { 
      for (int j = i+1; j < size; j ++)
      {
        // Make a Triangle-object and add it to the triangles-arrayList
        triangles.add(new Triangle(p_neighboors.get(0).pos, p_neighboors.get(i).pos, p_neighboors.get(j).pos));
      }
    }
  }
}