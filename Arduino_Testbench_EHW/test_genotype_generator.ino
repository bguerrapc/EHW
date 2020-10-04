int genotype[]={0,0,0,0,0,0,0,0,0,1};
int genotype_dec = 0;
int assist = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); // opens serial port, sets data rate to 9600 bps
}

void loop() {
  // put your main code here, to run repeatedly:
    assist = genotype[9];
    genotype[9] = genotype[0] ^ genotype[4] ^ assist; 
    genotype[8] = assist;
    genotype[7] = genotype[8];
    genotype[6] = genotype[7];
    genotype[5] = genotype[6];
    genotype[4] = genotype[5];
    genotype[3] = genotype[4];
    genotype[2] = genotype[3];
    genotype[1] = genotype[2];
    genotype[0] = genotype[1]; 
    genotype_dec=genotype[9]+2*genotype[8]+4*genotype[7]+8*genotype[6]+16*genotype[5]+32*genotype[4]+64*genotype[3]+128*genotype[2]+256*genotype[1]+512*genotype[0];
    Serial.print("I received: ");
    Serial.println(genotype_dec, DEC);
    delay(1000);
}
