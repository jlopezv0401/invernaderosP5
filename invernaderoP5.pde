//************************************************************************
//Variables Globales Interfaz
//************************************************************************
import controlP5.*;
//import processing.net.*; 
import processing.net.Client; 

ControlP5 cp5;
controlP5.Button botonAcceso;
controlP5.Textfield textoUser;
controlP5.Textfield textoSecret;

Textlabel nombre;
Textlabel invernaDisponible;
Textlabel[] nombreInverna;

Textlabel[] labelRed;
controlP5.Textfield[] textoIp;
controlP5.Textfield[] textoPuerto;
controlP5.Textfield[] textoMascara;
controlP5.Textfield[] textoGate;

Textlabel[] labelTemp;
Textlabel[] labelTempActual;
Textlabel[] labelTempC;
Textlabel[] labelTempF;
Textlabel[] labelTempMax;
Textlabel[] labelTempMin;
Textlabel labelTempCSta;
Textlabel labelTempFSta;
Textlabel[] labelVentila;
Textlabel[] labelFoco;
Knob[] knobTempMax;
Knob[] knobTempMin;
Toggle[] toggleVentila;
Toggle[] toggleFoco;

Textlabel[] labelRiego;
Textlabel[] labelRiegoFecha;
Textlabel[] labelRiegoHora;
controlP5.Textfield[] textRiegoFecha;
controlP5.Textfield[] textRiegoHora;
Toggle[] toggleRiego;

Textlabel[] labelFumiga;
Textlabel[] labelFumigaFecha;
Textlabel[] labelFumigaHora;
controlP5.Textfield[] textFumigaFecha;
controlP5.Textfield[] textFumigaHora;
Toggle[] toggleFumiga;

//RadioButton radioInverna;
Toggle[] toggleInverna;
Group[] controlInverna;
Accordion acordeon;

PFont fuenteLogin;
PFont fuenteDisp;
ControlFont font;
ControlFont fontTemp;

PImage columna, banner;

//************************************************************************
//Variables Globales control App
//************************************************************************
String usuario = "";
String secreto = "";
boolean construido = false;

//************************************************************************
//Variables Globales Red y Arduino
//************************************************************************
processing.net.Client myClient; 
processing.net.Client myClient1;
int dataIn; 
int leidoInt;
String valorLeido;
int tempMax = 28;
int tempMin = 30;
boolean foco;
boolean ventila;
boolean riego;
boolean fumiga;
boolean modo;
int tempPasado;
int tiempoCambio;
byte dato;

ArrayList<String> invernaLista = new ArrayList<String>();
//Jedis jedis = new Jedis("127.0.0.1");

void setup() {
  invernaLista.add("invernadero1");
  invernaLista.add("invernadero2");
  invernaLista.add("invernadero3");
  
  myClient = new processing.net.Client(this, "192.168.10.250", 9999);
  
  size(959, 700);
  columna = loadImage("columna01.png");
  banner = loadImage("banner.gif");

  
  fuenteLogin = loadFont("Verdana-14.vlw");
  fuenteDisp = loadFont("Digital-7Mono-48.vlw");
  cp5 = new ControlP5(this);
  font = new ControlFont(fuenteLogin);
  fontTemp = new ControlFont(fuenteDisp);
  
//  controlP5.addButton("button",10,0,0,80,20).setId(1);  
//  controlP5.controller("button").captionLabel().setControlFont(font);
  
//************************************************************************
//Controles para pantalla de Acceso
//************************************************************************
  botonAcceso = cp5.addButton("acceso")
     .setPosition(500,400)
     .setSize(100,20)
     .setId(1)
     ;
     
//  botonAcceso.captionLabel().setControlFont(font);
//  botonAcceso.captionLabel().setControlFontSize(18);
//  botonAcceso.setId(2);
//  botonAcceso.captionLabel().set("Accesar");

  textoUser = cp5.addTextfield("usuario")
     .setPosition(500,320)
     .setSize(140,20)
     .setFont(font)
     .setColor(color(255,0,0))
     .setId(2)
     .setAutoClear(false)
     .setColorValue(0xfffffff0)
     .setFocus(true);

  textoSecret = cp5.addTextfield("pass")
     .setPosition(500,360)
     .setSize(140,20)
     .setFont(font)
     .setColor(color(255,0,0))
     .setAutoClear(false)
     .setColorValue(0xfffffff0)
//     .setPasswordMode(true)
     .setId(3);
     
//************************************************************************
//Controles generales
//************************************************************************

    nombre = cp5.addTextlabel("nombre")
                    .setPosition(10,100)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20))
                    ;
                    
    invernaDisponible = cp5.addTextlabel("invernaDisponible")
                    .setPosition(10,170)
                    .setColorValue(0xfffffff0)
                    .setFont(createFont("Arial",16))
                    ;
                    
    acordeon = cp5.addAccordion("acordeonInverna")
                 .setPosition(240,100)
                 .setWidth(700); 
                    
//    radioInverna = cp5.addRadioButton("radioInverna")
//           .setPosition(50,230)
//           .setSize(60,25)
//           .setColorForeground(color(120))
//           .setColorActive(color(255))
//           .setColorLabel(color(255))
//           .setItemsPerRow(1)
//           .setSpacingRow(20);

                 
//    labelTempCSta = cp5.addTextlabel("labelTempCSta")
//           .setColorValue(0xffffff00)
//           .setFont(fontTemp)
//           .setLabelVisible(false);
           
//    labelTempFSta = cp5.addTextlabel("labelTempFSta" + str(x))
//           .setPosition(420,180)
//           .setColorValue(0xffffff00)
//           .setFont(fontTemp)
//           .setText("72 ºF")
   
}

//************************************************************************
//Funcion draw()
//************************************************************************

void draw() {

  smooth();
  background(0);
  image(banner, 0, 0);
  image(columna, 0, 79);
  
//  if (myClient != null) {
    dataIn = myClient.readChar();
    
    valorLeido = str(dataIn);
    leidoInt = int(valorLeido); 

    if (labelTempC !=null) {
        labelTempC[0].setText(valorLeido + " ºC");
        labelTempF[0].setText(str(((leidoInt*9)/5) + 32) + " ºF");
        tempPasado = leidoInt;
    }

//  if (dataIn>30)
//    myClient.write(1);
//  else if (dataIn<29)
//    myClient.write(0);

//    if (modo == true){
//      myClient.write(8);
//    }
//    else {
//      myClient.write(9);
//    }

    if (ventila == false && foco == false && riego == false)
      myClient.write(7);
    else if (ventila == true && foco == false && riego == false)
      myClient.write(0);
    else if (ventila == false && foco == true && riego == false)
      myClient.write(1);
    else if (ventila == true && foco == true && riego == false)
      myClient.write(2); 
    else if (ventila == false && foco == false && riego == true)
      myClient.write(3);
    else if (ventila == true && foco == false && riego == true)
      myClient.write(4);
    else if (ventila == false && foco == true && riego == true)
      myClient.write(5);
    else if (ventila == true && foco == true && riego == true)
      myClient.write(6);
//  }
  
  println(valorLeido);
  delay(50);
    
//    if (keyPressed){
//      if (key == 'a'){
//        myClient.write(1);
//        println("1");
//      }
//      else if (key == 's'){
//        myClient.write(0);
//        println("0");
//      }
//    }
  

}

//************************************************************************
//Controlador general
//************************************************************************

public void controlEvent(ControlEvent theEvent) {
//  println(theEvent.controller().id());
  if (theEvent.controller().id() == 3)
    comprobar();
}


//************************************************************************
//Controles
//************************************************************************

public void acceso() {
  comprobar();  
}

public void usuario(String theText) {
  usuario = theText;
  textoUser.setFocus(false);
  textoSecret.setFocus(true);
}

public void secreto(String theText) {
  secreto = theText;
  textoSecret.setFocus(false);

}

void toggleInverna0(boolean theFlag ) {
  if(theFlag==true) {
    controlInverna[0].setVisible(false);
//    modo = false;
  } else {
    controlInverna[0].setVisible(true);
    myClient = new processing.net.Client(this, "192.168.10.250", 9999);
//    myClient1 = new processing.net.Client(this, "192.168.11.250", 9999); 
//    modo = true;
  }
}

void toggleInverna1(boolean theFlag ) {
  if(theFlag==true) {
    controlInverna[1].setVisible(false);
  } else {
    controlInverna[1].setVisible(true);
  }
}

void toggleInverna2(boolean theFlag ) {
  if(theFlag==true) {
    controlInverna[2].setVisible(false);
  } else {
    controlInverna[2].setVisible(true);
  }
}

void toggleVentila0(boolean theFlag ) {
  if(theFlag==true) {
    ventila = true;
    println("Ventila on");
  } else {
    ventila = false;
    println("Ventila off");
  }
}

void toggleFoco0(boolean theFlag ) {
  if(theFlag==true) {
    foco = true;
    println("Foco on");
  } else {
    foco = false;
    println("Foco off");
  }
}

void toggleRiego0(boolean theFlag ) {
  if(theFlag==true) {
    riego = true;
    println("Riego on");
  } else {
    riego = false;
    println("Riego off");
  }
}

void toggleFumiga0(boolean theFlag ) {
  if(theFlag==true) {
    fumiga = true;
    println("Fumiga on");
  } else {
    fumiga = false;
    println("Fumiga off");
  }
}

//void knobTempMax0(int theValue) {
//  if (labelTempMax != null) {
//    labelTempMax[0].setText(str(theValue) + " ºC");
//    tempMax = theValue;
//  }
//}
//
//void knobTempMin0(int theValue) {
//  if (labelTempMin != null) {      
//    labelTempMin[0].setText(str(theValue) + " ºC");
//    tempMin = theValue;
//  }
//}

//**************************************************************
//Control del boton acceso
//**************************************************************

public void comprobar(){
//  String consulta = "usuario:" + textoUser.getText();
//  String id = jedis.get(consulta);
//  consulta = "usuario:" + id + ":pass";
//  String secreto = jedis.get(consulta);
  String secreto = textoSecret.getText();
  
  if (secreto != null) {
    if (secreto.equals("1111")) {
      botonAcceso.setVisible(false);
      textoUser.setVisible(false);
      textoSecret.setVisible(false);
//      nombre.setText("Bienvenido:\n " + jedis.get("usuario:" + id));
      nombre.setText("Bienvenido:\n ");
//       List invernaLista = jedis.lrange("inverna:" + id, 0, -1); 
       int numInverna = invernaLista.size();
       
//       strokeWeight(4);   // Thicker
//       fill(255);
//       line(5, 160, 200, 160);
       
       invernaDisponible.setText(str(numInverna) +" invernaderos disponibles" );
       
       nombreInverna = new Textlabel[numInverna];
       toggleInverna = new Toggle[numInverna];
       controlInverna = new Group[numInverna];   
       
       labelRed = new Textlabel[numInverna];
       textoIp = new controlP5.Textfield[numInverna];
       textoPuerto = new controlP5.Textfield[numInverna];
       textoMascara = new controlP5.Textfield[numInverna];
       textoGate = new controlP5.Textfield[numInverna];
      
       labelTemp = new Textlabel[numInverna];
       labelTempMin = new Textlabel[numInverna];
       labelTempMax = new Textlabel[numInverna];
       knobTempMin = new Knob[numInverna];
       knobTempMax = new Knob[numInverna];
       toggleVentila = new Toggle[numInverna];
       toggleFoco = new Toggle[numInverna];
       labelTempActual = new Textlabel[numInverna];
       labelTempC = new Textlabel[numInverna];
       labelTempF = new Textlabel[numInverna];
       
       labelRiego = new Textlabel[numInverna];
       textRiegoFecha = new controlP5.Textfield[numInverna];
       textRiegoHora= new controlP5.Textfield[numInverna];
       toggleRiego = new Toggle[numInverna];
       
       labelFumiga = new Textlabel[numInverna];
       textFumigaFecha = new controlP5.Textfield[numInverna];
       textFumigaHora= new controlP5.Textfield[numInverna];
       toggleFumiga = new Toggle[numInverna];
       
       //**************************************************************
       //Genera acordeon y toggles de automatico para cada invernadero
       //**************************************************************
       for (int x = 0; x < numInverna; x ++) {
         
         String nombreTog = invernaLista.get(x).toString();
         
         
         nombreInverna[x] = cp5.addTextlabel("nombreInverna" + nombreTog)
           .setPosition(10,230+(80*x))
           .setColorValue(0xfffffff0)
           .setFont(createFont("Arial",14))
           .setText(nombreTog);
         
         toggleInverna[x] = cp5.addToggle("toggleInverna" + str(x))
           .setPosition(40,250+(80*x))
           .setSize(80,25)
//           .setValue(false)
           .setMode(ControlP5.SWITCH)
           .setCaptionLabel("Automatico On / Off");
           
//         radioInverna.addItem(nombreRadio,x+1);
         
         controlInverna[x] = cp5.addGroup("controlInverna" + str(x))
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(550);
                
       //**************************************************************
       //Genera controles en cada pesatania del acordeon
       //**************************************************************

         labelRed[x] = cp5.addTextlabel("labelRed" + str(x))
           .setPosition(10,15)
           .setColorValue(0xffffff00)
           .setFont(createFont("Arial",14))
           .setText("Configuracion de Red")
           .moveTo(controlInverna[x]);
       
         textoIp[x] = cp5.addTextfield("textIp" + str(x))
           .setPosition(10,40)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("192.168.40.250")
           .setCaptionLabel("IP Invernadero")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
         textoPuerto[x] = cp5.addTextfield("textPuerto" + str(x))
           .setPosition(180,40)
           .setSize(100,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("9999")
           .setCaptionLabel("Puerto")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
         textoMascara[x] = cp5.addTextfield("textMascara" + str(x))
           .setPosition(320,40)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("255.255.255.0")
           .setCaptionLabel("Mascara de Red")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
         textoGate[x] = cp5.addTextfield("textGate" + str(x))
           .setPosition(500,40)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("192.168.40.250")
           .setCaptionLabel("IP Invernadero")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
           
       //**************************************************************
       //Genera controles para subseccion Temperatura
       //**************************************************************

         labelTemp[x] = cp5.addTextlabel("labelTemp" + str(x))
           .setPosition(10,90)
           .setColorValue(0xffffff00)
           .setFont(createFont("Arial",14))
           .setText("Monitor de Temperatura")
           .moveTo(controlInverna[x]);
           
         knobTempMax[x] = cp5.addKnob("knobTempMax" + str(x))
               .setRange(0,40)
               .setValue(28)
               .setPosition(30,120)
               .setRadius(50)
               .setViewStyle(Knob.ARC)
               .setNumberOfTickMarks(20)
               .setTickMarkLength(1)
               .snapToTickMarks(false)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 160, 100))
               .setColorActive(color(255,255,0))
               .setCaptionLabel("Temperatura Max")
               .moveTo(controlInverna[x]);
               
         labelTempMax[x] = cp5.addTextlabel("labelTempMax" + str(x))
           .setPosition(60,240)
           .setColorValue(0xfffffff0)
           .setFont(createFont("Arial",12))
           .setText("28 ºC")
           .moveTo(controlInverna[x]);
               
         knobTempMin[x] = cp5.addKnob("knobTempMin" + str(x))
               .setRange(0,40)
               .setValue(30)
               .setPosition(180,120)
               .setRadius(50)
               .setViewStyle(Knob.ARC)
               .setNumberOfTickMarks(20)
               .setTickMarkLength(1)
               .snapToTickMarks(false)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 160, 100))
               .setColorActive(color(255,255,0))
               .setCaptionLabel("Temperatura Min")
               .moveTo(controlInverna[x]);
               
         labelTempMin[x] = cp5.addTextlabel("labelTempMin" + str(x))
           .setPosition(210,240)
           .setColorValue(0xfffffff0)
           .setFont(createFont("Arial",12))
           .setText("30 ºC")
           .moveTo(controlInverna[x]);
               
         toggleVentila[x] = cp5.addToggle("toggleVentila" + str(x))
           .setPosition(330,130)
           .setSize(60,20)
           .setValue(false)
           .setMode(ControlP5.SWITCH)
           .setCaptionLabel("Ventilador On / Off")
           .moveTo(controlInverna[x]);
           
         toggleFoco[x] = cp5.addToggle("toggleFoco" + str(x))
           .setPosition(330,180)
           .setSize(60,20)
           .setValue(false)
           .setMode(ControlP5.SWITCH)
           .setCaptionLabel("Foco On / Off")
           .moveTo(controlInverna[x]);
           
         labelTempActual[x] = cp5.addTextlabel("labelTempActual" + str(x))
           .setPosition(460,110)
           .setColorValue(0xfffffff0)
           .setFont(createFont("Arial",12))
           .setText("Temperatura Actual")
           .moveTo(controlInverna[x]);
           
         labelTempC[x] = cp5.addTextlabel("labelTempC" + str(x))
           .setPosition(460,130)
           .setColorValue(0xffffff00)
           .setFont(fontTemp)
//           .setText(valorLeido + " ºC")
           .moveTo(controlInverna[x]);
           
         labelTempF[x] = cp5.addTextlabel("labelTempF" + str(x))
           .setPosition(460,180)
           .setColorValue(0xffffff00)
           .setFont(fontTemp)
//           .setText(str(((leidoInt*9)/5) + 32) + "º F")
           .moveTo(controlInverna[x]);

//         if (x == 0){
//           labelTempCSta.setPosition(420,130);
//           labelTempCSta.moveTo(controlInverna[x]);
//         } 

       //**************************************************************
       //Genera controles para subseccion Riego
       //**************************************************************
       
         labelRiego[x] = cp5.addTextlabel("labelRiego" + str(x))
           .setPosition(10,280)
           .setColorValue(0xffffff00)
           .setFont(createFont("Arial",14))
           .setText("Programacion de Riego")
           .moveTo(controlInverna[x]);
       
         textRiegoFecha[x] = cp5.addTextfield("textRiegoFecha" + str(x))
           .setPosition(10,310)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("12/03/2009")
           .setCaptionLabel("Fecha")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
         textRiegoHora[x] = cp5.addTextfield("textRiegoHora" + str(x))
           .setPosition(180,310)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("4:30 pm")
           .setCaptionLabel("Hora")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);  
      
         toggleRiego[x] = cp5.addToggle("toggleRiego" + str(x))
           .setPosition(360,310)
           .setSize(60,20)
           .setValue(false)
           .setMode(ControlP5.SWITCH)
           .setCaptionLabel("Riego On / Off")
           .moveTo(controlInverna[x]);   
       
       
       //**************************************************************
       //Genera controles para subseccion Fumiga
       //**************************************************************
       
         labelFumiga[x] = cp5.addTextlabel("labelFumiga" + str(x))
           .setPosition(10,360)
           .setColorValue(0xffffff00)
           .setFont(createFont("Arial",14))
           .setText("Programacion de Riego")
           .moveTo(controlInverna[x]);
       
         textFumigaFecha[x] = cp5.addTextfield("textFumigaFecha" + str(x))
           .setPosition(10,380)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("12/03/2009")
           .setCaptionLabel("Fecha")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);
           
         textFumigaHora[x] = cp5.addTextfield("textFumigaHora" + str(x))
           .setPosition(180,380)
           .setSize(140,20)
           .setFont(font)
           .setColor(color(255,0,0))
           .setText("4:30 pm")
           .setCaptionLabel("Hora")
           .setColorValue(0xfffffff0)
           .moveTo(controlInverna[x]);  
      
         toggleFumiga[x] = cp5.addToggle("toggleFumiga" + str(x))
           .setPosition(360,380)
           .setSize(60,20)
           .setValue(false)
           .setMode(ControlP5.SWITCH)
           .setCaptionLabel("Fumigacion On / Off")
           .moveTo(controlInverna[x]);   
       
         acordeon.addItem(controlInverna[x]);
       }
       acordeon.open(0);

    }
  }
}

