__kernel void A(__global double* a, __global double* b, __local double* c, int d, int e) {
  int f, g, h;
  int size = get_local_size(0);
  int z = get_global_id(0);
  int i = z + 1;
  int j = z;

  if (i <= 1024) {
    f = i % 64;
    g = 3 * i % 64;
    h = 5 * i % 64;
    c[j] = a[h * e * (d + 1) + g * (d + 1) + f];
  } else {
    c[j] = (double)0.0;
  }

  //barrier(1);

  for (int k = size / 2; k > 0; k >>= 1) {
    if (j < k)
      c[j] = (double)j + j;
    //barrier(1);
  }
  if (j == 0)
    b[z] = c[0];
}
