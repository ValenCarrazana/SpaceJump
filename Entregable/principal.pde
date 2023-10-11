import fisica.*;
import oscP5.*;
import processing.sound.*;

SoundFile sonidoF, sonidoE, sonidoP, sonidoW, sonidoL, sonidoS, sChoqOv, sonidovacio, sonidoBoing;
OscP5 oscP5;
FWorld mundo;
FCircle astronauta, p_luna, p_tierra, estrella2, ovni1, ovni2, ovni3;
FCircle planeta1, planeta2, planeta3, planeta4, planeta5, planeta6, planeta7, planeta8, planeta9;
FCircle misensor, misensor2, misensor3, misensor6, misensor_luna;
FCircle sensor_ovni, sensor_ovni1, sensor_ovni2;

ArrayList<FBody> gravedadFicticia = new ArrayList<FBody>();

float angulo, fuerza, angulo_m, fuerza_m;
boolean lock = false;
boolean estaImpulsado = false;
boolean agregar= false;
boolean poderActivo= false;
boolean saltando= false;

int estado = 0;

void setup() {
  size(1366, 768);
  oscP5 = new OscP5(this, 12000);
  sonidoF = new SoundFile(this, "ruidofondo.mp3");
  sonidoE = new SoundFile(this, "estrella.mp3");
  sonidoW = new SoundFile(this, "win.mp3");
  sonidoL = new SoundFile(this, "lost.mp3");
  sonidoP = new SoundFile(this, "escudo.mp3");
  sonidoS = new SoundFile (this, "salto.mp3");
  sonidovacio = new SoundFile (this, "explosion.mp3");
  sChoqOv = new SoundFile (this, "metal.mp3");
  sonidoBoing = new SoundFile (this, "aaaa.mp3");


  ultimoTiempo = millis();
  //load imagenes :)
  cargarImagenes();

  miTipografia = createFont("nasalization-rg.otf", 32);

  //no tocar nada
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();

  crearCuerpos();

  p_luna.setName ("p_luna");
  astronauta.setName ("astronauta");
  misensor.setName ("misensor");
  misensor2.setName ("misensor2");
  misensor3.setName ("misensor3");
  misensor_luna.setName ("misensor_luna");


  sensor_ovni.setName ("sensor_ovni");
  sensor_ovni1.setName ("sensor_ovni1");
  sensor_ovni2.setName ("sensor_ovni2");

  //gravedadFicticia.add(caja2);   no

  cuerposalmundo();
  sonidoF.amp(0.05);
  sonidoF.loop();
}


//////////////////////////////////////////////////////////////////////////////


void draw() {

  mundo.remove(ovni1);
  mundo.remove(ovni2);
  mundo.remove(ovni3);


  switch(estado) {
    //------------------inicio del juego
  case 0:
    comenzar ();
    break;

    //------------------juego
  case 1:
    juego();
    mundo.step();
    mundo.draw();
    cambioDeEstado ();
    break;

    //------------------perdiste
  case 2:
    perdiste();
    break;

    //------------------ganaste
  case 3:
    ganaste();
    break;

    //------------------creditos
  case 4:
    creditos();
    reinicio ();
    //     if(agregar== true){
    //mundo.add(ovni1);
    //  mundo.add(ovni2);
    //  mundo.add(ovni3);
    //  agregar= false;
    //}
    break;

    //--------------------------
  case 5:
    lasInstrucciones();
    break;
  }
  //if (!sonidoP.isPlaying()&& puntaje==3){
  //   sonidoP.amp(0.05);
  //   sonidoP.play();
  //  }
}


//////////////////////////////////////////////////////////////////////////////
void keyPressed() {
  if (key== 'p' && estado==1 && puntaje==1) {
    if (!sonidoP.isPlaying()) {
      sonidoP.amp(0.05);
      sonidoP.play();
      poderActivo = true;
      puntaje =4;
      println("poderactivado");
    }
  }


  if ( key == 't' && lock) {
    fuerza = fuerza_m;
    fuerza_m = 0;
    float x = cos(angulo)*fuerza*190;
    float y = sin(angulo)*fuerza*190;
    astronauta.addImpulse(x, y);
    lock = false;
    estaImpulsado = false;
    println("ya determino su impulso");

    if (!sonidoS.isPlaying()) {
      sonidoS.amp(0.9);
      sonidoS.play();
    }
  } else {
    angulo =angulo_m;
    angulo_m = 0;
    lock = true;
    estaImpulsado = true;
    println("ya determino su direccion");
  }


  if (key == 'k' && !teclaPresionada) {
    teclaPresionada = true;
    tiempoInicio = millis();
  }
}


//////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  if (key == 'k'|| key == 'K') {
    teclaPresionada = false;
  }
}

void oscEvent(OscMessage m) {
  println(m);

  if (m.addrPattern().equals("/wek/outputs") ) {
    if (m.get(0).floatValue() == 1 /*&& (lock)*/) {
      if (estado==1) {
        fuerza = fuerza_m;
        fuerza_m = 0;
        float x = cos(angulo)*fuerza*190;
        float y = sin(angulo)*fuerza*190;
        astronauta.addImpulse(x, y);
        lock = false;
        estaImpulsado = false;
        sonidoS.amp(0.07);
        if (!sonidoS.isPlaying()) {
          
          sonidoS.play();
        }
      }
    } else if (m.get(0).floatValue() == 2) {
      angulo =angulo_m;
      //angulo_m = 0;
      lock = true;
      estaImpulsado = true;
      sonidoS.stop();
      // cerrado= true;
    } else if (m.get(0).floatValue() == 4) {
      if (puntaje == 1) {
        if (!sonidoP.isPlaying()) {
          sonidoP.amp(0.05);
          sonidoP.play();
          poderActivo = true;
          puntaje =4;
          println("poderactivado");
        }
        mundo.remove(ovni1);
        mundo.remove(ovni2);
        mundo.remove(ovni3);
      }
    } else if (m.get(0).floatValue() == 3) {
      println(c);
      c++;
      teclaPresionada = true;
      tiempoInicio = millis();
    } else {
      println("entran otros mensajes");
    }
  }
}
