
int contador = 60;
int contador2= 5;
int ultimoTiempo;
boolean contadorActivo = true;

boolean estaFijo = false;
boolean estuvoEnUnPlaneta= false;
boolean yendo = false;

float [] distancias = new float[3];

void verificarColisionYActualizarPuntaje(FCircle objeto1, FCircle objeto2, float radioObjeto1, float radioObjeto2) {
  float distancia = dist(objeto1.getX(), objeto1.getY(), objeto2.getX(), objeto2.getY());
  if (distancia < (radioObjeto1 + radioObjeto2) /1.2) {
    objeto2.setPosition(-50, -50); // Eliminar la estrella del mundo
    puntaje++; // Incrementar el puntaje
    sonidoE.amp(0.05);
    sonidoE.play();
  }
}


String conseguirNombre(FBody cuerpo)
{
  String nombre = "nada";

  if (cuerpo != null)
  {
    nombre = cuerpo.getName();

    if (nombre == null)
    {
      nombre = "nada";
    }
  }

  return nombre;
}

void movimientoOvnis() {
  // Mueve la caja11 horizontalmente
  float offsetX = sin(millis() * 0.003) * 100; // Ajustar la velocidad y el rango de movimiento
  ovni1.setPosition(500 + offsetX, 480);
  sensor_ovni.setPosition(500 + offsetX, 480);

  float offsetX2 = sin(millis() * 0.004) * 90;
  ovni2.setPosition(900 + offsetX2, 580);
  sensor_ovni1.setPosition(900 + offsetX2, 580);

  float offsetX3 = sin(millis() * 0.001) * 200;
  ovni3.setPosition(900 + offsetX3, 280);
  sensor_ovni2.setPosition(900 + offsetX3, 280);

  float offsetX_p = sin(millis() * 0.002) * 200;
  misensor_luna.setPosition(1000 + offsetX_p, -50);
  p_luna.setPosition(1000 + offsetX_p, -50);

  if (poderActivo) {
    sensor_ovni.setPosition(-500 + offsetX, -480);
    sensor_ovni1.setPosition(-900 + offsetX2, -580);
    sensor_ovni2.setPosition(-900 + offsetX3, -280);
  }
}

void SonidoOvnis(){

 //distanciasOvni[1] =distanciaEntreObjetos(astronauta.getX(), astronauta.getY(),  sensor_ovni1.getX(),  sensor_ovni1.getY());
 //distanciasOvni[2] = distanciaEntreObjetos(astronauta.getX(), astronauta.getY(),  sensor_ovni2.getX(),  sensor_ovni2.getY());
 
  if ( dist(astronauta.getX(), astronauta.getY(),  sensor_ovni.getX(),  sensor_ovni.getY())<= 100) {
      if(!sChoqOv.isPlaying()){
      sChoqOv.amp(0.5);
      sChoqOv.play();
      }
      else{
         sChoqOv.stop();
      }
    }
    if ( dist(astronauta.getX(), astronauta.getY(),  sensor_ovni1.getX(),  sensor_ovni1.getY())<= 100) {
      if(!sChoqOv.isPlaying()){
      sChoqOv.amp(0.5);
      sChoqOv.play();
      }
      else{
         sChoqOv.stop();
      }
    }
    if ( dist(astronauta.getX(), astronauta.getY(),  sensor_ovni2.getX(),  sensor_ovni2.getY())<= 100) {
      if(!sChoqOv.isPlaying()){
      sChoqOv.amp(0.5);
      sChoqOv.play();
      }
      else{
         sChoqOv.stop();
      }
    }
}



void colision() {

  //no tocar por favor o me pongo a llorar
  for (int i = 0; i < distancias.length; i++) {
    distancias[0] = distanciaEntreObjetos(astronauta.getX(), astronauta.getY(), misensor.getX(), misensor.getY());
    distancias[1] = distanciaEntreObjetos(astronauta.getX(), astronauta.getY(), misensor2.getX(), misensor2.getY());
    distancias[2] = distanciaEntreObjetos(astronauta.getX(), astronauta.getY(), misensor3.getX(), misensor3.getY());


    if (distancias[i] <= 100) {
      atraerAUnPunto();
      println("hola");
      estaFijo = true;
      estuvoEnUnPlaneta= true;
      
      if(!sonidoBoing.isPlaying()){
      sonidoBoing.amp(0.5);
      sonidoBoing.play();
      }
    }


    if (contadorActivo) {

      int tiempoContadorActual = millis();
      if (tiempoContadorActual - ultimoTiempo >= 1000) {
        contador--;
        ultimoTiempo = tiempoContadorActual;
      }
      if (contador >= 0) {
        pushStyle();
        textSize(100);
        text(contador, 70, 120);
        popStyle();
      } else {
        text("¡Tiempo terminado!", width/2 - 30, height/2);
        contadorActivo = false;
      }
    }
  }
}
//utilizar
void atraerAUnPunto() {
  ArrayList<FBody> cuerpos = mundo.getBodies();
  for (FBody cuerpo : cuerpos) {
    float dx = mouseX  - cuerpo.getX();
    float dy = mouseY  - cuerpo.getY();
    cuerpo.addForce(dx * 0, dy * 200);
  }
}

float distanciaEntreObjetos(float x1, float y1, float x2, float y2) {
  return dist(x1, y1, x2, y2);
}

void reinicio () {
  puntaje = 0;
  contador = 60;
  contador3 = 30;
  puntajeGanar=1;
  astronauta.setPosition(100, 560);

  estrella2.setPosition(100, -10);
  //estrella1.setPosition(600, -10);
  //estrella3.setPosition(300, -10);


  //estrella1.setStatic(false);
  estrella2.setStatic(false);
  //estrella3.setStatic(false);

  fuerza_m = 0;
  agregar= true;
  poderActivo = false;
  c=0;
  if(!sonidoF.isPlaying()){
    sonidoF.play();
  }
}
