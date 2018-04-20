
//data
int[] dotx;
int[] doty;

int[] col;


//graphic data
int rad = 500;

int add = 3;

float size = 10;


//calc data
int len;

int coef = 7;

int cur = 0;

int alg = 0; // 0 = bubblesort   2 = cocktail sort    2 = shell sorting   3-4 = radix lsd sort base 2    5-6 = radix lsd sort base 10


//cocktail
boolean up = true;


//shell
int inner;
int outer;
int temp;

int h = 0;


//radix
int min;
int max;

int exp = 1;


//insertion
int loops = 1;


//selection
int index;


//comb
boolean swapped = true;

int gap;


//main flags
boolean done = false;

boolean begin = true;

boolean sorted = false;


//amount of algorithms
int algamount = 8;


void setup (){
  
  fullScreen ();
  frameRate (240);
  
  colorMode(HSB);
  
  noStroke ();
  
  textSize (35);
  
  createdots ();
  
}

void draw (){
  
  if(frameCount % 3 == 0 || (alg > 1 && alg != 9)){
    translate(width/2, height/2);
    drawdots();
    text ("angle step of " + add, -width/2, -height/2 + 35);
  }
  callout();
  
}


void callout(){
  
  if(alg == 0){
    text ("bubblesort    algorithm 1/" + algamount, -width/2, -height/2 + 35*2);
    if(begin){
      delay(400);
      createdots();
      done = false;
      begin = false;
    }
    for(int i = 0; i < 3; i++){
      bubblesort (col);
      if(done){
        break;
      }
    }
  }else if(alg == 1){
    text ("cocktail sort    algorithm 2/" + algamount, -width/2, -height/2 + 35*2);
    if(begin){
      createdots();
      done = false;
      begin = false;
    }
    for(int i = 0; i < 3; i++){
      cocktail (col);
      if(done){
        break;
      }
    }
  }else if(alg == 2){
    
    text ("shell sorting    algorithm 3/" + algamount, -width/2, -height/2 + 35*2);
    
    if(begin){
      createdots();
      while(h <= col.length / 3){
        h = h * 3 + 1;
      }
      sorted = false;
      begin = false;
    }
    
    //delay(500);
    
    for(int i = 0; i < 20; i++){
    
      if(h > 0){
        
        if(!sorted){
          outer = h;
          sorted = true;
        }
        
        if(outer < col.length){
          temp = col[outer];
          inner = outer;
          
          while (inner > h - 1 && col[inner - h] >= temp){
            col[inner] = col[inner - h];
            
            int a = col [inner]*360/255;
            int a2 = col [inner-h]*360/255;
            
            dotx [inner] = int (cos (radians(a*add))*(inner+coef)/coef);
            doty [inner] = int (sin (radians(a*add))*(inner+coef)/coef);
            dotx [inner-h] = int (cos (radians(a2*add))*(inner+coef+1)/coef);
            doty [inner-h] = int (sin (radians(a2*add))*(inner+coef+1)/coef);
            
            inner -= h;
            
          }
          col[inner] = temp;
          
          int a = col [temp]*360/255;
          dotx [temp] = int (cos (radians(a*add))*(temp+coef)/coef);
          doty [temp] = int (sin (radians(a*add))*(temp+coef)/coef);
          
          outer++;
          
        }else {
          h = (h - 1) / 3;
          outer = h;
        }
        
      }else {
        begin = true;
        alg++;
        createdots();
        delay(400);
        break;
      }
      
    }
    
  }else if(alg == 3){
    text ("Radix LSD base 2    algorithm 4/" + algamount, -width/2, -height/2 + 35*2);
    radixsort(2);
  }else if(alg == 4){
    text ("Radix LSD base 2    algorithm 4/" + algamount, -width/2, -height/2 + 35*2);
    delay(200);
    alg++;
    createdots();
    begin = true;
  }else if(alg == 5){
    text ("Radix LSD base 10    algorithm 5/" + algamount, -width/2, -height/2 + 35*2);
    radixsort(10);
  }else if(alg == 6){
    text ("Radix LSD base 10    algorithm 5/" + algamount, -width/2, -height/2 + 35*2);
    delay(400);
    alg++;
    begin = true;
  }else if(alg == 7){
    
    if(begin){
      createdots();
      loops = 1;
      begin = false;
    }
    
    text ("Insertion sort    algorithm 6/" + algamount, -width/2, -height/2 + 35*2);
    
    for(int i = 0; i < 5; i++){
    
      if(loops < col.length){
        
        int stop = col[loops];
        int j = loops - 1;
        
        while (j>=0 && col[j] > stop){
          col[j+1] = col[j];
          j = j-1;
        }
        
        col[j+1] = stop;
        resetpos();
        loops++;
      
      }else {
        resetpos();
        delay(400);
        alg++;
        begin = true;
        break;
      }
    
    }
    
  }else if(alg == 8){
    
    text ("Selection sort    algorithm 7/" + algamount, -width/2, -height/2 + 35*2);
    
    if(begin){
      createdots();
      loops = 0;
      begin = false;
    }
    
    for(int j = 0; j < 10; j++){
    
      if(loops < col.length){
        
        index = loops;
        
        for(int i = loops + 1; i < col.length; i++){
          if(col[i] < col[index]){
            index = i;
          }
        }
        
        int swap = col[index];
        col[index] = col[loops];
        col[loops] = swap;
        
        loops++;
        
        resetpos();
        
      }else {
        delay(400);
        alg++;
        begin = true;
        break;
      }
    
    }
    
  }else if(alg == 9){
    
    text ("Comb sort    algorithm 8/" + algamount, -width/2, -height/2 + 35*2);
    
    if(begin){
      createdots();
      gap = col.length;
      loops = 0;
      sorted = false;
      begin = false;
    }
    
    for(int i = 0; i < 25; i++){
    
      if(gap != 1 || swapped){
        
        if(!sorted){
          gap = getNextGap(gap);
          
          sorted = true;
          
          swapped = false;
          
          loops = 0;
        }
      
        if(loops < col.length-gap){
          
          if (col[loops] > col[loops+gap]){
            
            int swap = col[loops];
            col[loops] = col[loops+gap];
            col[loops+gap] = swap;
            
            resetpos();
            
            swapped = true;
          }
          
          loops++;
        }else {
          sorted = false;
        }
      
      }else {
        delay(400);
        alg++;
        begin = true;
      }
      
    }
    
  }else {
    text("End of available algorithms    Restarting", -width/2, -height/2 + 35*2);
    alg = 0;
  }
  
}


void bubblesort (int[] colo){
  
  int am = 0;
  
  for (int i = 0; i < findcur(colo); i++){
    
    if(colo [i] > colo [i+1]){
      
      am++;
      
      int swap = colo [i];
      colo [i] = colo [i+1];
      colo [i+1] = swap;
      
      int a = colo [i]*360/255;
      int a2 = colo [i+1]*360/255;
      
      dotx [i] = int (cos (radians(a*add))*(i+coef)/coef);
      doty [i] = int (sin (radians(a*add))*(i+coef)/coef);
      dotx [i+1] = int (cos (radians(a2*add))*(i+coef+1)/coef);
      doty [i+1] = int (sin (radians(a2*add))*(i+coef+1)/coef);
      
      
    }
    
  }
  
  if(am == 0){ 
    done = true;
    alg++;
    begin = true;
  }
  
}

void cocktail (int[] colo){
  
  int am = 0;
  for(int i = 0; i < colo.length - 1; i++){
    
    if(colo [i] > colo [i+1]){
      
      am++;
      
      int swap = colo [i];
      colo [i] = colo [i+1];
      colo [i+1] = swap;
      
      int a = colo [i]*360/255;
      int a2 = colo [i+1]*360/255;
      
      dotx [i] = int (cos (radians(a*add))*(i+coef)/coef);
      doty [i] = int (sin (radians(a*add))*(i+coef)/coef);
      dotx [i+1] = int (cos (radians(a2*add))*(i+coef+1)/coef);
      doty [i+1] = int (sin (radians(a2*add))*(i+coef+1)/coef);
      
      
    }
    
  }
  
  for(int i = (colo.length - 1); i > 0; i--){
      
      if(colo [i-1] > colo [i]){
        
        am++;
        
        int swap = colo [i-1];
        colo [i-1] = colo [i];
        colo [i] = swap;
        
        int a = colo [i-1]*360/255;
        int a2 = colo [i]*360/255;
        
        dotx [i-1] = int (cos (radians(a*add))*(i+coef-1)/coef);
        doty [i-1] = int (sin (radians(a*add))*(i+coef-1)/coef);
        dotx [i] = int (cos (radians(a2*add))*(i+coef)/coef);
        doty [i] = int (sin (radians(a2*add))*(i+coef)/coef);
        
        
      }
      
    }
  
  if(am == 0){ 
    done = true;
    alg++;
    begin = true;
  }
    
}


void radixsort(int r){
  
  if(begin){
    min = col[0];
    max = col[0];
    for(int i = 1; i < col.length; i++){
      if(col[i] < min){
        min = col[i];
      }else if(col[i] > max){
        max = col[i];
      }
    }
    
    begin = false;
  }
  
  if((max - min) / exp >= 1){
    CountingSortByDigit(col, r, exp, min);
    exp *= r;
    delay(r * 4*25);
    resetpos();
  }else {
    alg++;
    done = true;
  }
}


int findcur (int[] arr){
  
  for (int i = len-1; i > 0; i--){
    
    if (arr [i] < arr [i-1]){
      
      cur = i;
      
      break ;
      
    }
    
  }
  
  return (cur);
  
}

int getNextGap(int gap){
  gap = (gap*10)/13;
  
  if (gap < 1){
    return 1;
  }
  
  return gap;
}


void drawdots(){
  
  background (0);
  
  for (int i = 0; i < len; i++){
    
    fill (col [i], 255, 255);
    
    ellipse(doty [i], dotx [i], size, size);
    
  }
  
}



void createdots (){
  
  h = 0;
  
  exp = 1;
  
  len = int (2*PI*rad);
  
  done = false;
  
  begin = true;
  
  loops = 1;
  
  dotx = new int[len];
  doty = new int[len];
  col = new int[len];
  
  for (int i = 0; i < len; i++){
    col[i] = 0;
  }
  int amount = 0;
  while (amount < len){
    
    int j = int (random(1, len));
    
    if (col[j] == 0){
      col [j] = (amount*255)/(len);
      amount++;
    }
    
  }
  
  for (int i = 0; i < len; i++){
    
    int a = col[i]*360/255;
    
    dotx [i] = int (cos (radians(a*add))*(i+coef)/coef);
    doty [i] = int (sin (radians(a*add))*(i+coef)/coef);
    
  }
  
}

void resetpos(){
  
  for (int i = 0; i < len; i++){
    
    int a = col[i]*360/255;
    
    dotx [i] = int (cos (radians(a*add))*(i+coef)/coef);
    doty [i] = int (sin (radians(a*add))*(i+coef)/coef);
    
  }
  
}

void mousePressed (){
  
  if (mouseY < height/2){
    add++;
  }else {
    add--;
  }
  
  createdots ();
  
}

void CountingSortByDigit(int[] array, int radix, int exponent, int minValue) {
    int bucketIndex;
    int[] buckets = new int[radix];
    int[] output = new int[array.length];

    // Initialize bucket
    for (int i = 0; i < radix; i++) {
        buckets[i] = 0;
    }

    // Count frequencies
    for (int i = 0; i < array.length; i++) {
        bucketIndex = int((((array[i] - minValue) / exponent) % radix));
        buckets[bucketIndex]++;
    }

    // Compute cumulates
    for (int i = 1; i < radix; i++) {
        buckets[i] += buckets[i - 1];
    }

    // Move records
    for(int i = array.length - 1; i >= 0; i--) {
        bucketIndex = int((((array[i] - minValue) / exponent) % radix));
        output[--buckets[bucketIndex]] = array[i];
    }

    // Copy back
    for (int i = 0; i < array.length; i++) {
        array[i] = output[i];
    }
    
    resetpos();
    
}