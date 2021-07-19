__kernel void A(__global double* a, int b, int c, int d, double e) {
  int f, g, h, i, j;

  int k = get_global_id(2);
  int l = get_global_id(1);
  int m = get_global_id(0);
  if (k >= d || l >= c || m >= b)
    return;
  f = ((k + 64 / 2) % 64) - 64 / 2;
  g = f * f;
  h = ((l + 64 / 2) % 64) - 64 / 2;
  i = h * h + g;
  j = ((m + 64 / 2) % 64) - 64 / 2;
  a[k * c * (b + 1) + l * (b + 1) + m] = exp(e * (double)(j * j + i));
}
