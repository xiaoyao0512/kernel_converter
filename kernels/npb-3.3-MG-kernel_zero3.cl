__kernel void A(__global double* a, int b, int c, int d, int e) {
  int f = get_global_id(2);
  int g = get_global_id(1);
  int h = get_global_id(0);
  if (h >= b)
    return;

  a[f * c * b + g * b + h + e] = 0.0;
}
