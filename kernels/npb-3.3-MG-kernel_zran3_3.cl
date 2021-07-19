__kernel void A(__global double* a, int b, int c, int d, int e) {
  int h = get_global_id(0);
  int g = get_global_id(1);
  int f = get_global_id(2);
  if (h < d && g < c && f < b)
    a[h * c * b + g * b + f + e] = 0.0;
}
