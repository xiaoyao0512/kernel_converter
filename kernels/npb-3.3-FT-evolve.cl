__kernel void A(__global double* a, __global double* b, __global const double* c, int d, int e, int f) {
  int g = get_global_id(2);
  int h = get_global_id(1);
  int i = get_global_id(0);
  if (g >= f || h >= e || i >= d)
    return;

  int j = g * e * (d + 1) + h * (d + 1) + i;
  a[j] = (double)j;
  b[j] = a[j];
}
