__kernel void A(__global double* a, int b, int c, int d, int e) {
  int f = get_global_id(1);
  int g = get_global_id(0);
  if (g >= b)
    return;

  a[0 * c * b + f * b + g + e] = a[(d - 2) * c * b + f * b + g + e];
  a[(d - 1) * c * b + f * b + g + e] = a[1 * c * b + f * b + g + e];
}
