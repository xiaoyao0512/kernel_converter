__kernel void A(__global double* a, int b, int c, int d) {
  int e, f, g, h, i;

  f = get_global_id(2) + 1;
  e = get_global_id(1) + 1;
  if (f > (c - 2) || e > (b - 2))
    return;

  g = get_global_id(0);
  if (g == 1)
    g = d - 1;

  int j = (f - 1) * (b - 2) + (e - 1);
  int k = j * (12 + 1) * 3 * 5 * 5;
  __global double(*l)[3][5][5] = (__global double(*)[3][5][5]) & a[k];

  for (h = 0; h < 5; h++) {
    for (i = 0; i < 5; i++) {
      l[g][0][h][i] = 0.0;
      l[g][1][h][i] = 0.0;
      l[g][2][h][i] = 0.0;
    }
    l[g][1][h][h] = 1.0;
  }
}
