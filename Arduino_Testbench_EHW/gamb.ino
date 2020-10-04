void setup() {
  // put your setup code here, to run once:
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
  pinMode(6, INPUT);
  pinMode(13,OUTPUT);
  Serial.begin(9600);

}

void loop() {
  // put your main code here, to run repeatedly:
  int a=digitalRead(6);
  int b=digitalRead(5);
  int c=digitalRead(4);
  int d=digitalRead(3);
  int e;
  //if (a == 1 || b == 1 || c == 1 || d == 1)
  if (d^c^b^a == 1)
  {
    e = 1;  
  }
  else 
  {
    e = 0;
  }
  if(e==1)
  {
     digitalWrite(13,HIGH);
  }
  else 
  {
  digitalWrite(13,LOW);
  }
  Serial.print(a);
  Serial.print(b);
  Serial.print(c);
  Serial.print(d);
  Serial.print("=");
  Serial.print(e);
  Serial.println(" ");
  delay(500);

}
