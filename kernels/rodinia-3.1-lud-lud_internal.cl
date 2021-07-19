__kernel void A(__global float* a, __local float* b, __local float* c, int d, int e) {
  
  int j;
  float k;
  int l;
  int m;
  int i = get_local_id(1);
  int h = get_local_id(0);
  int f = get_group_id(0);
  int g = get_group_id(1);

  


  l = e + (g + 1) * 64;
  m = e + (f + 1) * 64; 
  

  b[i * 64 + h] = a[(e + i) * d + m + h];
  c[i * 64 + h] = a[(l + i) * d + e + h];

  barrier(1);

  k = 0;
  for (j = 0; j < 64; j++)
    k += c[i * 64 + j] * b[j * 64 + h];
  a[(l + i) * d + m + h] -= k;
}
