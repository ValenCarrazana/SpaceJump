PFont miTipografia;

int maxImagenes = 5;
int imageIndex = 0;
int maxImagenes1 = 2;
int imageIndex1 = 0;
int imageCambiar = 100;
int tiempoAnteriorDeCambio = 0;
int puntaje = 0;

PImage inicio, creditos, instrucciones, ganaste, perdiste, fondo;
PImage ovni, imagenPlaneta, marte, tierra, luna, saturno, piedrita;
PImage imagenAstronauta, imagenAstronauta_Salto;
PImage escudo, escudo_salto;
PImage [] images = new PImage [maxImagenes];
PImage [] imagesHud = new PImage [maxImagenes1];
PImage flecha;
boolean sonar= false;


void cargarImagenes() {
  inicio = loadImage ("inicio.png");
  fondo = loadImage("fondo2.png");
  imagenAstronauta = loadImage("astronauta1.png");
  imagenAstronauta_Salto= loadImage("astronauta2.png");
  imagenPlaneta = loadImage("planeta1.png");
  ovni = loadImage("ovnibasic.png");
  marte = loadImage("marte.png");
  tierra = loadImage("tierra.png");
  luna = loadImage("luna.png");
  ganaste = loadImage("ganaste.png");
  perdiste = loadImage("perdiste.png");
  instrucciones = loadImage("instrucciones.png");
  creditos = loadImage("creditos.png");
  escudo = loadImage("escudo1.png");
  escudo_salto = loadImage("escudo2.png");
  saturno = loadImage("saturn.png");
  piedrita = loadImage("piedrita.png");
  flecha = loadImage("picodeflecha.png");

  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("starMovimiento" + i + ".png");
  }

  for (int i = 0; i < imagesHud.length; i++) {
    imagesHud[i] = loadImage("hud" + i + ".png");
  }
}


void imagenes () {
  //atar imagenes a los objetos de fisica
  image(saturno, planeta1.getX() - 100 / 2, planeta1.getY() - 100 / 2, 100, 100);
  
  image(piedrita, planeta4.getX() - 100 / 2, planeta4.getY() - 100 / 2, 100, 100);
  image(piedrita, planeta8.getX() - 90 / 2, planeta8.getY() - 90 / 2, 90, 90);
  image(marte, planeta9.getX() - 100 / 2, planeta9.getY() - 100 / 2, 100, 100);
  image(marte, planeta3.getX() - 100 / 2, planeta3.getY() - 100 / 2, 100, 100);
  image(marte, planeta7.getX() - 100 / 2, planeta7.getY() - 100 / 2, 100, 100);
 
  image(imagenPlaneta, planeta5.getX() - 100 / 2, planeta5.getY() - 100 / 2, 100, 100);
  //image(imagenPlaneta, planeta2.getX() - 100 / 2, planeta2.getY() - 100 / 2, 100, 100);
  image(imagenPlaneta, planeta6.getX() - 100 / 2, planeta6.getY() - 100 / 2, 100, 100);

  image(tierra, p_tierra.getX() - 300 / 2, p_tierra.getY() - 300 / 2, 300, 300);
  image(luna, p_luna.getX() - 300 / 2, p_luna.getY() - 300 / 2, 300, 300);

  //ovnis
  image(ovni, ovni1.getX() - 70 / 2, ovni1.getY() - 70 / 2, 70, 70);
  image(ovni, ovni2.getX() - 70 / 2, ovni2.getY() - 70 / 2, 70, 70);
  image(ovni, ovni3.getX() - 70 / 2, ovni3.getY() - 70 / 2, 70, 70);

  //estrellitas
  //image(images[imageIndex], estrella1.getX() - 30 / 2, estrella1.getY() - 30 / 2, 30, 30);
  image(images[imageIndex], estrella2.getX() - 30 / 2, estrella2.getY() - 30 / 2, 30, 30);
  //image(images[imageIndex], estrella3.getX() - 30 / 2, estrella3.getY() - 30 / 2, 30, 30);


  if (estaImpulsado) {
    image(imagenAstronauta, astronauta.getX() - 50 / 2, astronauta.getY() - 50 / 2, 50, 50);
  } else {
    image(imagenAstronauta_Salto, astronauta.getX() - 50 / 2, astronauta.getY() - 50 / 2, 50, 50);
  }
  
    if (estaImpulsado && poderActivo) {
    image( escudo, astronauta.getX() - 50 / 2, astronauta.getY() - 50 / 2, 50, 50);
  } else  if (estaImpulsado == false && poderActivo){
    image( escudo_salto, astronauta.getX() - 50 / 2, astronauta.getY() - 50 / 2, 50, 50);
  }
  
}

void HUD () {
  // Dibujar el puntaje en el HUD
  image(imagesHud[imageIndex1], 1150, 650, 200, 100);

  if (puntaje >= 1) {
    image(imagesHud[imageIndex1+1], 1100, 615, 300, 156);
  } 

  if (millis() - tiempoAnteriorDeCambio >= imageCambiar) {
    imageIndex = (imageIndex + 1) % images.length;
    tiempoAnteriorDeCambio = millis();
  }

  if (puntaje == 1 && key=='p') {
    mundo.remove(ovni1);
    mundo.remove(ovni2);
    mundo.remove(ovni3);
  }
}
