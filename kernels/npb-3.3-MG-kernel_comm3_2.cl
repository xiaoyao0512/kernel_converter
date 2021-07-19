__kernel void A(__global double* a, int b, int c, int d, int e) {
  int f = get_global_id(1) + 1;
  int g = get_global_id(0);
  if (g >= b)
    return;

  a[f * c * b + 0 * b + g + e] = a[f * c * b + (c - 2) * b + g + e];
  a[f * c * b + (c - 1) * b + g + e] = a[f * c * b + 1 * b + g + e];
}
