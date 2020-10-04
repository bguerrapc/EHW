float lumi = 0.0;
int clarity = 0;
bool presence = false;
bool g0,g1,g2,g3,g4,g5,g6,g7,g8,g9 = false;

void setup() 
{
  // put your setup code here, to run once:
  Serial.begin(9600); // opens serial port, sets data rate to 9600 bps
  pinMode(OUTPUT,13);
  pinMode(OUTPUT,12);
  pinMode(INPUT,11);
  for (int i = 2; i <= 10; i++)
  {
    pinMode(INPUT,i);
  }
}

void loop() 
{
  presence = digitalRead(11);
  lumi = analogRead(0);
  clarity = 1000*(lumi/5.0);
  if(presence == true)
  {
    if(clarity<=500)
    {
      digitalWrite(13,HIGH);
      digitalWrite(12,HIGH);  
    }
    else
    {
      digitalWrite(13,LOW);
      digitalWrite(12,HIGH);
    }
  }
  else
  {
    if(clarity<=500)
    {
      digitalWrite(13,HIGH);
      digitalWrite(12,LOW);  
    }
    else
    {
      digitalWrite(13,LOW);
      digitalWrite(12,LOW);
    }
  }
}
