int c = 0;
int tiempoInicio = 0;
int contador3 = 20;
boolean teclaPresionada = false;
boolean yasono = false;

int puntajeGanar = 1;


//------------------------------------------------------------------------------comenzar
void comenzar () {
 // int tiempo_Actual =millis();

  pushStyle();
  fill(0);
  textSize(90);
  textFont(miTipografia);
  image (inicio, 0, 0, 1366, 788);

  if (teclaPresionada==true) {
    //c++;
    text(c/30 + " seg",width/2-35, height/2+220);
  //  int tiempoPresionado = tiempo_Actual - tiempoInicio;
  //  text(tiempoPresionado/1000+ " seg", width/2-35, height/2+220);
  }else{
    text("0"+" seg", width/2-35, height/2+220);
    teclaPresionada = false;
    c=0;
    }
    if(teclaPresionada == false){
    text("0"+" seg", width/2-35, height/2+220);
    c=0;
    }
if (c >=90) {
     estado= 5;
     c=0;
     teclaPresionada = false;
    }
  
  //  if (tiempoPresionado >=3000) {
  //    estado =5;
  //    teclaPresionada = false;
  //  }
  //} 
  //else {
  //  text("0"+ " seg", width/2-35, height/2+220);
  
  popStyle();
}


//-------------------------------------------------------------------------------Instrucciones
void lasInstrucciones() {


  image (instrucciones, 0, 0, 1366, 788);
  pushStyle();
  fill(255);
  textSize(28);
  int tiempoContadorActual = millis();
  if (contadorActivo) {
    if (estado ==5 )
      text(contador3+ " seg", width/2+530, height/2+120);
    if (tiempoContadorActual - ultimoTiempo >= 1000) {
      contador3--;
      ultimoTiempo = tiempoContadorActual;
    }
  }
  if (contador3 == 0) {
    estado = 1;
    c=0;
    fuerza_m=0;
  }
  popStyle();
}


//------------------------------------------------------------------------------juego
void juego () {

  textFont(miTipografia);
  background(fondo);

  //verificarColisionYActualizarPuntaje(astronauta, estrella1, 50, 30) ;
  verificarColisionYActualizarPuntaje(astronauta, estrella2, 50, 30) ;
  //verificarColisionYActualizarPuntaje(astronauta, estrella3, 50, 30) ;


  HUD();

  //ACA SE DEFINE COMO EL ASTRONAUTA SE VUELVE ESTATICO AL COLISIONAR CON PLANETAS
  colision ();
  SonidoOvnis();

  // CONDICION PARA QUE EL ASTRONAUTA VUELVA A LA TIERRA
  if ( astronauta.getY() > 737) {
    astronauta.setPosition(100, 560);
    fuerza_m= 0;
    println("borde");
    sonidovacio.amp(0.2);
    sonidovacio.play();
    pushStyle();
    fill(250,0,0,150);
    rect (0,0, 1300, 768);
    popStyle();
  }

  //imagenes atadas a los objetos de fisica
  imagenes();
  movimientoOvnis();

  //dibujarInterfaz
  pushStyle();
  noFill();

  if (lock) {
    fuerza_m++;
    if (fuerza_m>=50) {
      fuerza_m = 0;
    }
    float lx = astronauta.getX()+10*cos(angulo);
    float ly = astronauta.getY()+10*sin(angulo);
    fill(255, 255, 255, 100);
    stroke(255);
    line(astronauta.getX(), astronauta.getY(), lx, ly); //estado de reposo
    ellipse(astronauta.getX(), astronauta.getY(), 40+fuerza_m, 40+fuerza_m);
  } else {
    angulo_m+=0.1;
    float lx = astronauta.getX()+80*cos(angulo_m);
    float ly = astronauta.getY()+80*sin(angulo_m);
    fill(255);
    stroke(255);
    line(astronauta.getX(), astronauta.getY(), lx, ly);
    circle(lx, ly,20);
  }
  popStyle();


  for (int i=0; i<gravedadFicticia.size(); i++) {
    gravedadFicticia.get(i).addForce(0, 1000);
  }


  //estabilizar las estrellas
  if ( estrella2.getY() >= 370) {
    estrella2.setStatic(true);
  }
  //if ( estrella1.getY() >= 300) {
  //  estrella1.setStatic(true);
  //}
  //if ( estrella3.getY() >= 560) {
  //  estrella3.setStatic(true);
  //}
}

//------------------------------------------------------------------------------Ganaste
void ganaste () {
   
  //sonidoW.amp(0.05);
  //if(!sonidoW.isPlaying()&& estado==3){
  //sonidoW.play();
  //}
  //if (sonidoW.isPlaying() &&  > 2600) {
  //  sonidoW.stop();
  // }

  //sonidoW.stop();

  //println(millis());
  //int tiempo_Actual = millis();

  pushStyle();
  fill(0);
  textFont(miTipografia);
  textSize(30);
  image (ganaste, 0, 0, 1366, 788);

  if (teclaPresionada) {
    //c++;
    text(c/30 + " seg",width/2+530, height/2+250);
    //int tiempoPresionado = tiempo_Actual - tiempoInicio;
    //text(tiempoPresionado/1000+ " seg", width/2+530, height/2+250);

    if (c >=90) {

      estado =4;
      contador = 25;
      contador2 = 5;
      teclaPresionada = false;
      c=0;
    }
  } else {
    text("0"+ " seg", width/2+530, height/2+250);
    teclaPresionada = false;
  }
  popStyle();

  if (estado == 3 && !sonidoW.isPlaying() && puntajeGanar ==1) {
    sonidoW.amp(0.04);
    sonidoF.stop();
    sonidoW.play();
    puntajeGanar++;
  }
}



//------------------------------------------------------------------------------Perdiste
void   perdiste() {
  sonidoL.amp(0.05);
  if (!sonidoL.isPlaying()&& estado==2) {
    sonidoL.play();
    sonidoL.stop();
  }

  //int tiempo_Actual = millis();
  pushStyle();
  fill(0);
  textFont(miTipografia);
  textSize(30);
  image (perdiste, 0, 0, 1366, 788);

  if (teclaPresionada) {
    //c++;
    text(c/30 + " seg",width/2+530, height/2+250);
   // int tiempoPresionado = tiempo_Actual - tiempoInicio;
    //text(tiempoPresionado/1000+ " seg", width/2+530, height/2+250);

    if (c >=90) {
      estado =4;
      contador = 20;
      contador2 = 5;
      teclaPresionada = false;
      c=0;
    }
  } else {
    text("0"+ " seg", width/2+530, height/2+250);
    teclaPresionada = false;
  }
  popStyle();

  if (estado == 2 && !sonidoL.isPlaying() && puntajeGanar ==1) {
    sonidoL.amp(0.4);
    sonidoF.stop();
    sonidoL.play();
    puntajeGanar++;
  }
}


//------------------------------------------------------------------------------Creditos
void   creditos() {
  int tiempoContadorActual = millis();
  background(creditos);
  pushStyle();
  textFont(miTipografia);
  textSize(20);
  text(contador2+ " seg", width/2+530, height/2+70);
  popStyle();

  if (contadorActivo) {


    if (tiempoContadorActual - ultimoTiempo >= 1000) {
      contador2--;
      ultimoTiempo = tiempoContadorActual;
    }
  }
  if (contador2 == 0) {
    estado = 0;
  }
}
