import processing.serial.*;
import controlP5.*;

Serial myPort;

int[] rc_vals = new int[5];

final String serialConfigFile = "serialconfig.txt";
int selectedPort = 0;

ControlP5 cp5;
DropdownList ddl_serial;
Button btn_refresh;
Button btn_connect;

Textlabel  lab_text_ail;
Textlabel  lab_text_ele;
Textlabel  lab_text_thr;
Textlabel  lab_text_rud;
Textlabel  lab_text_ax1;

Textlabel  lab_val_ail;
Textlabel  lab_val_ele;
Textlabel  lab_val_thr;
Textlabel  lab_val_rud;
Textlabel  lab_val_ax1;

Slider sld_ail;
Slider sld_ele;
Slider sld_thr;
Slider sld_rud;
Slider sld_ax1;

String[] last_availablePorts = null;

Boolean connected = false;

void setup()
{ 
  configUI();
}

void configUI()
{
  frameRate(30);

  size(400, 500);

  cp5 = new ControlP5(this);

  // Create serial port drop down list

  btn_refresh = cp5.addButton("btn_refresh")
    .setPosition(10, 10)
    .setWidth(45)
    .setCaptionLabel("Refresh");

  ddl_serial = cp5.addDropdownList("ddl_serial")
    .setPosition(65, 25)
      .setWidth(170);

  btn_connect = cp5.addButton("btn_connect")
        .setPosition(245, 10)
        .setWidth(40)
        .setSwitch(true)
        .setCaptionLabel("Connect");
        
  refreshSerialList();

  // Create labels for channels and values

  lab_text_ail = cp5.addTextlabel("lab_text_ail")
    .setText("Aileron:")
      .setPosition(10, 50);

  lab_val_ail = new Textlabel(cp5, "1500", 60, 50);
  
  lab_text_ele = cp5.addTextlabel("lab_text_ele")
    .setText("Elevator:")
      .setPosition(10, 70);

  lab_val_ele = new Textlabel(cp5, "1500", 60, 70);
  
  lab_text_thr = cp5.addTextlabel("lab_text_thr")
    .setText("Throttle:")
      .setPosition(10, 90);

  lab_val_thr = new Textlabel(cp5, "1500", 60, 90);
  
  lab_text_rud = cp5.addTextlabel("lab_text_rud")
    .setText("Rudder:")
      .setPosition(10, 110);

  lab_val_rud = new Textlabel(cp5, "1500", 60, 110);
  
  lab_text_ax1 = cp5.addTextlabel("lab_text_ax1")
    .setText("Aux 1:")
      .setPosition(10, 130);

  lab_val_ax1 = new Textlabel(cp5, "1500", 60, 130);
  
  sld_ail = cp5.addSlider("sld_ail")
                .setPosition(100, 50)
                .setRange(0,3000)
                .setHeight(10)
                .setWidth(100)
                .setCaptionLabel("")
                .setValue(0)
                .setLabelVisible(false);
                
  sld_ele = cp5.addSlider("sld_ele")
                .setPosition(100, 70)
                .setRange(0,3000)
                .setHeight(10)
                .setWidth(100)
                .setCaptionLabel("")
                .setValue(0)
                .setLabelVisible(false);
                
  sld_thr = cp5.addSlider("sld_thr")
                .setPosition(100, 90)
                .setRange(0,3000)
                .setHeight(10)
                .setWidth(100)
                .setCaptionLabel("")
                .setValue(0)
                .setLabelVisible(false);
                
  sld_rud = cp5.addSlider("sld_rud")
                .setPosition(100, 110)
                .setRange(0,3000)
                .setHeight(10)
                .setWidth(100)
                .setCaptionLabel("")
                .setValue(0)
                .setLabelVisible(false);
                
  sld_ax1 = cp5.addSlider("sld_ax1")
                .setPosition(100, 130)
                .setRange(0,3000)
                .setHeight(10)
                .setWidth(100)
                .setCaptionLabel("")
                .setValue(0)
                .setLabelVisible(false);
                
}

public void btn_refresh(int theValue)
{
  refreshSerialList();
}

public void btn_connect(int theValue)
{
  boolean btn_on = btn_connect.getBooleanValue();
  if (btn_on)
  {
    try
    {
      myPort = new Serial(this, ddl_serial.getItem(selectedPort).getText(), 9600);
      myPort.bufferUntil('\n');
      
      btn_connect.setWidth(55);
      btn_connect.setCaptionLabel("Disconnect");
      
      connected = true;
    }
  catch (RuntimeException ex) {
    connected = false;
    btn_connect.setOff();
    // Swallow error if port can't be opened, keep port closed.
    myPort = null; 
    println("Problem opening port");
  }
  }
  else
  {
    connected = false;
    myPort.stop();
    myPort.clear();
    
    rc_vals = new int[5];
    
    btn_connect.setWidth(40);
    btn_connect.setCaptionLabel("Connect");
  }
}

void serialEvent(Serial p)
{
  try
  {
    String incoming = myPort.readStringUntil('\n');
  
    if (incoming.startsWith("R"))
    {
      String[] string_parts = incoming.split(",");
  
      rc_vals[0] = Integer.parseInt(string_parts[1]);
      rc_vals[1] = Integer.parseInt(string_parts[2]);
      rc_vals[2] = Integer.parseInt(string_parts[3]);
      rc_vals[3] = Integer.parseInt(string_parts[4]);
      rc_vals[4] = Integer.parseInt(string_parts[5].trim());
    }
  }
  catch (RuntimeException ex)
  {
    println("Error in SerialEvent()");
  }
}

void refreshSerialList()
{
  ddl_serial.clear();
  selectedPort = 0;
  
  String[] availablePorts = Serial.list();
  
  String[] serialConfig = loadStrings(serialConfigFile);
  if (serialConfig != null && serialConfig.length > 0)
  {
    String savedPort = serialConfig[0];
    
    for (int i = 0; i < availablePorts.length; ++i)
    {
      ddl_serial.addItem(availablePorts[i], i);

      if (availablePorts[i].equals(savedPort))
      {
        selectedPort = i;
        ddl_serial.setIndex(i);
      }
    }

    if (selectedPort == 0)
    {
      selectedPort = 1;
      ddl_serial.setIndex(selectedPort);
    }
  }
  
}

void draw()
{
  // Clear screen
  background(0);

  // Update vals of UI
  lab_val_ail.setText(String.valueOf(rc_vals[0]));
  lab_val_ail.draw(this);
  
  lab_val_ele.setText(String.valueOf(rc_vals[1]));
  lab_val_ele.draw(this);
  
  lab_val_thr.setText(String.valueOf(rc_vals[2]));
  lab_val_thr.draw(this);

  lab_val_rud.setText(String.valueOf(rc_vals[3]));
  lab_val_rud.draw(this);

  lab_val_ax1.setText(String.valueOf(rc_vals[4]));
  lab_val_ax1.draw(this);
  
  sld_ail.setValue(rc_vals[0]);
  sld_ele.setValue(rc_vals[1]);
  sld_thr.setValue(rc_vals[2]);
  sld_rud.setValue(rc_vals[3]);
  sld_ax1.setValue(rc_vals[4]);

  // Request state update from teensy
  if (connected)
  {
    myPort.write('*');
  }
}

