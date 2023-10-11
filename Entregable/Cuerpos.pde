

void cuerposalmundo() {
  //agregar todo al mundo
  mundo.add(planeta1);
  //mundo.add(estrella1);
  //mundo.add(estrella3);
  mundo.add(p_luna);
  mundo.add(p_tierra);
  mundo.add(planeta3);
  mundo.add(planeta5);
  mundo.add(estrella2);
  mundo.add(planeta4);
  //mundo.add(planeta2);
  mundo.add(planeta8);
  mundo.add(planeta9);
  mundo.add(astronauta);
  mundo.add(ovni1);
  mundo.add(ovni2);
  mundo.add(ovni3);
  mundo.add(planeta6);
  mundo.add(planeta7);
  mundo.add(misensor);
  mundo.add(misensor2);
  mundo.add(misensor3);
  mundo.add(misensor6);

  mundo.add(sensor_ovni);
  mundo.add(sensor_ovni1);
  mundo.add(sensor_ovni2);

  mundo.add(misensor_luna);
}

// Funciones para crear esferas
FCircle crearEsferaRaw(float x, float y, float t, color c, float g, boolean e) {
  FCircle main = new FCircle(t);
  main.setPosition(x, y);
  main.setVelocity(0, 0);
  main.setFillColor(c);
  main.setStatic(e);
  float r = (t / 20) / 2;
  main.setDensity(g / (PI * r * r));
  main.setNoStroke();
  return main;
}

FCircle crearCirculo(float x, float y, float t, color c) {
  return crearEsferaRaw(x, y, t, c, 10, false);
}

FCircle crearSensor(float x, float y, float t, color c) {
  return crearEsferaRaw(x, y, t, c, 10, true);
}


FCircle crearEsferaRow(float x, float y, float t, color c, float g, boolean e) {
  FCircle main = new FCircle(t);
  main.setPosition(x, y);
  main.setVelocity(0, 0);
  main.setFillColor(c);
  main.setStatic(e);
  float r = (t / 20) / 2;
  main.setDensity(g / (PI * r * r));
  main.setNoStroke();
  return main;
}

FCircle crearEsferaConPeso(float x, float y, float t, color c, float p) {
  return crearEsferaRow(x, y, t, c, p, false);
}

FCircle crearEsferaEstatica(float x, float y, float t, color c) {
  return crearEsferaRow(x, y, t, c, 100, true);
}

void crearCuerpos() {

  //astronauta, pj principal
  astronauta = crearCirculo(100, 560, 50, 0);

  // Ovnis (aunque su fuerza deberia ser horizontal no vertical)
  ovni1 = crearEsferaEstatica(300, 560, 70, 0);
  ovni2 = crearEsferaEstatica(100, 360, 70, 0);
  ovni3 = crearEsferaEstatica(100, 360, 70, 0);

  //sensor
  sensor_ovni = crearEsferaEstatica(300, 560, 70, 0);
  sensor_ovni1 = crearEsferaEstatica(100, 360, 70, 0);
  sensor_ovni2 = crearEsferaEstatica(100, 360, 70, 0);

  //Planetas rosas
  planeta1 = crearEsferaEstatica(420, 600, 100, 0);
  planeta3 = crearEsferaEstatica(width/2, 700, 100, 0);
  planeta9 = crearEsferaEstatica(width/2+400, 600, 100, 0);

  //rocas
  planeta4 = crearEsferaEstatica(width/2-170, 160, 100, 0);
  planeta8 = crearEsferaEstatica(220, 300, 90, 0);

  //Planetas marte
  planeta5 = crearEsferaEstatica(width/2+120, 500, 100, 0);
  //planeta2 = crearEsferaEstatica(width/2-80, 400, 100, 0);
  planeta7 = crearEsferaEstatica(width/2+500, 400, 100, 0);
  planeta6 = crearEsferaEstatica(width/2+230, 300, 100, 0);

  // tierra y luna
  p_luna = crearEsferaEstatica(1250, -10, 300, 0);
  p_tierra = crearEsferaEstatica(100, 750, 300, 0);

  // Estrellas
  estrella2 = crearEsferaConPeso(100, -10, 30, 0, 1800000);
  //estrella1 = crearEsferaConPeso(600, -10, 30, 0, 3800000);
  //estrella3 = crearEsferaConPeso(300, -10, 30, 0, 3800000);

  // Inicializa cada sensor
  misensor = crearSensor(width/2+400, 600, 90, 0);
  misensor2 = crearSensor(width/2, 700, 90, 0);
  misensor3= crearSensor(width/2+500, 400, 90, 0);

  misensor_luna = crearSensor(width/2, 100, 300, 0);
}

void cambioDeEstado () {
  float distanciaLuna = dist( misensor_luna.getX(), misensor_luna.getY(), astronauta.getX(), astronauta.getY());
  if (distanciaLuna <=180) {
    estado = 3;
    c=0;
    teclaPresionada = false;
  }
  if (contador ==0 ) {
    estado = 2;
    c=0;
    teclaPresionada = false;
  }
}
