__kernel void A(__global double* a, __global const double* b, int c, int d, int e) {
  double f;
  int g;

  int h = get_global_id(0);
  if (h >= e)
    return;

  f = b[h];
  int i = h * d * (c + 1);
  for (g = 0; g < d; g++) {
    D(2 * 64, &f, 1220703125.0, (__global double*)&a[i + g * (c + 1) + 0]);
  }
}
