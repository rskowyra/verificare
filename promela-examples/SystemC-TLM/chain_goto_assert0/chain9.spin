//Variables
bool e=0;
bool e1=0;
bool e2=0;
bool e3=0;
bool e4=0;
bool e5=0;
bool e6=0;
bool e7=0;
bool e8=0;
bool e9=0;

active proctype source(){
   goto l1;

   // white states
   l1: atomic{goto f12;}
   l2: atomic{goto l3;}
   l3:  goto stop;

   // black states
   atomic{skip;
   }


   // inlining f1
   // white states

   // black states
   atomic{skip;
   f11: goto f12;
   f12: e1=0;goto f13;
   f13: goto l3;
   f14:  goto stop
   }


   stop: skip
}

active proctype p1(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e1=1;goto l2;
   l2: e1==0 -> goto l3;
   l3: goto f22;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f2
   // white states

   // black states
   atomic{skip;
   f21: goto f22;
   f22: e2=0;goto f23;
   f23: goto l5;
   f24:  goto stop
   }


   stop: skip
}

active proctype p2(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e2=1;goto l2;
   l2: e2==0 -> goto l3;
   l3: goto f32;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f3
   // white states

   // black states
   atomic{skip;
   f31: goto f32;
   f32: e3=0;goto f33;
   f33: goto l5;
   f34:  goto stop
   }


   stop: skip
}

active proctype p3(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e3=1;goto l2;
   l2: e3==0 -> goto l3;
   l3: goto f42;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f4
   // white states

   // black states
   atomic{skip;
   f41: goto f42;
   f42: e4=0;goto f43;
   f43: goto l5;
   f44:  goto stop
   }


   stop: skip
}

active proctype p4(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e4=1;goto l2;
   l2: e4==0 -> goto l3;
   l3: goto f52;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f5
   // white states

   // black states
   atomic{skip;
   f51: goto f52;
   f52: e5=0;goto f53;
   f53: goto l5;
   f54:  goto stop
   }


   stop: skip
}

active proctype p5(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e5=1;goto l2;
   l2: e5==0 -> goto l3;
   l3: goto f62;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f6
   // white states

   // black states
   atomic{skip;
   f61: goto f62;
   f62: e6=0;goto f63;
   f63: goto l5;
   f64:  goto stop
   }


   stop: skip
}

active proctype p6(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e6=1;goto l2;
   l2: e6==0 -> goto l3;
   l3: goto f72;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f7
   // white states

   // black states
   atomic{skip;
   f71: goto f72;
   f72: e7=0;goto f73;
   f73: goto l5;
   f74:  goto stop
   }


   stop: skip
}

active proctype p7(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e7=1;goto l2;
   l2: e7==0 -> goto l3;
   l3: goto f82;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f8
   // white states

   // black states
   atomic{skip;
   f81: goto f82;
   f82: e8=0;goto f83;
   f83: goto l5;
   f84:  goto stop
   }


   stop: skip
}

active proctype p8(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e8=1;goto l2;
   l2: e8==0 -> goto l3;
   l3: goto f92;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining f9
   // white states

   // black states
   atomic{skip;
   f91: goto f92;
   f92: e9=0;goto f93;
   f93: goto l5;
   f94:  goto stop
   }


   stop: skip
}

active proctype p9(){
   goto l1;

   // white states

   // black states
   atomic{skip;
   l1: e9=1;goto l2;
   l2: e9==0 -> goto l3;
   l3: goto fsink2;
   l4: goto l5;
   l5:  goto stop
   }


   // inlining fsink
   // white states
   fsink1: atomic{goto fsink2;}
   fsink4:  goto stop;

   // black states
   atomic{skip;
   fsink2: e=0;goto fsink3;
   fsink3: goto l5;
   }


   stop: skip
}

active proctype sink(){
   goto l1;

   // white states
   l1: atomic{e=1;goto l2;}
   l2: atomic{e==0 -> goto l3;}
   l3: atomic{printf("MSC: assert(0)\n");goto l4;}
   l4:  goto stop;

   // black states
   atomic{skip;
   }



   stop: skip
}

