void tt();
void test();
void le_results();
int ngates = 0;
int fit = 0;
boolean le_saida = 0;

//bool presence = false;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600); // opens serial port, sets data rate to 9600 bps
  pinMode(13,INPUT);//ng
  pinMode(12,INPUT);//ng
  pinMode(11,INPUT);//ng
  pinMode(10,INPUT);//ng
  pinMode(9,INPUT);//ng
  pinMode(8,INPUT);//saida
  pinMode(7,OUTPUT);//entrada 2 no FPGA
  pinMode(6,OUTPUT);//entrada 1 no FPGA
  pinMode(5,OUTPUT);//tt3
  pinMode(4,OUTPUT);//tt2
  pinMode(3,OUTPUT);//tt1
  pinMode(2,OUTPUT);//tt0
  digitalWrite(5,HIGH);
  digitalWrite(4,LOW); 
  digitalWrite(3,LOW);
  digitalWrite(2,HIGH); 
}

void le_results()
{
  ngates = digitalRead(9)+2*digitalRead(10)+4*digitalRead(11)+2*digitalRead(12)+4*digitalRead(13);
  Serial.print("Number of Logical Gates = ");
  Serial.println(String(ngates));
}

void test()
{
  Serial.println("Inputs    Output ");
  digitalWrite(6,LOW);
  digitalWrite(7,LOW);
  delay(500);
  Serial.print("   0 0        ");
  le_saida=digitalRead(8);
  Serial.println(String(le_saida));
  digitalWrite(6,LOW);
  digitalWrite(7,HIGH);
  delay(500);
  Serial.print("   0 1        ");
  le_saida=digitalRead(8);
  Serial.println(String(le_saida));
  digitalWrite(6,HIGH);
  digitalWrite(7,LOW);
  delay(500);
  Serial.print("   1 0        ");
  le_saida=digitalRead(8);
  Serial.println(String(le_saida));
  digitalWrite(7,HIGH);
  digitalWrite(6,HIGH);
  delay(500);
  Serial.print("   1 1        ");
  le_saida=digitalRead(8);
  Serial.println(String(le_saida));
}


void tt()
{
  Serial.println("Truth Table: Logical Bicombination");
  delay(2000);
}
void loop()
{
  tt();
  test();
  le_results();
}
