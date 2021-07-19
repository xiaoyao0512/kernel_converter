__kernel void A(__global double* a, int b, int c, int d, int e) {
  int f = get_global_id(1) + 1;
  int g = get_global_id(0) + 1;
  if (g >= c - 1)
    return;

  a[f * c * b + g * b + 0 + e] = a[f * c * b + g * b + b - 2 + e];
  a[f * c * b + g * b + b - 1 + e] = a[f * c * b + g * b + 1 + e];
}
