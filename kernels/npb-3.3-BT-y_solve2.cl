__kernel void A(__global double* a, int b, int c, int d) {
  int e, f, g, h, i;

  g = get_global_id(2) + 1;
  e = get_global_id(1) + 1;
  if (g > (d - 2) || e > (b - 2))
    return;

  f = get_global_id(0);
  if (f == 1)
    f = c - 1;

  int j = (g - 1) * (b - 2) + (e - 1);
  int k = j * (12 + 1) * 3 * 5 * 5;
  __global double(*l)[3][5][5] = (__global double(*)[3][5][5]) & a[k];

  for (h = 0; h < 5; h++) {
    for (i = 0; i < 5; i++) {
      l[f][0][h][i] = 0.0;
      l[f][1][h][i] = 0.0;
      l[f][2][h][i] = 0.0;
    }
    l[f][1][h][h] = 1.0;
  }
}
