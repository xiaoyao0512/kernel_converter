__kernel void A(__global float* a, __global float* b) {
  
 __local float f[1];
  int c;
  c = get_global_id(0);
  int d = get_group_id(0);

 
  int e = get_local_id(0);


  if (e == 0) {
    f[0] = a[d];
  }
  barrier(1);

  b[c] += f[0];
}
