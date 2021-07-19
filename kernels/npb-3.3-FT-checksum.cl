__kernel void A(__global double* a, __global double* b, __local double* c, int d, int e) {
  int f, g, h;
  int i = get_global_id(0) + 1;
  int j = get_local_id(0);

  if (i <= 1024) {
    f = i % 64;
    g = 3 * i % 64;
    h = 5 * i % 64;
    c[j] = a[h * e * (d + 1) + g * (d + 1) + f];
  } else {
    c[j] = (double)0.0;
  }

  barrier(1);

  for (int k = get_local_size(0) / 2; k > 0; k >>= 1) {
    if (j < k)
      c[j] = (double)j + j;
    barrier(1);
  }
  if (j == 0)
    b[get_group_id(0)] = c[0];
}
