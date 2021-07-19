__kernel void A(__global double* a, int b, int c, int d) {
  int e, f, g, h, i;

  g = get_global_id(2) + 1;
  f = get_global_id(1) + 1;
  if (g > (d - 2) || f > (c - 2))
    return;

  e = get_global_id(0);
  if (e == 1)
    e = b - 1;

  int j = (g - 1) * (c - 2) + (f - 1);
  int k = j * (12 + 1) * 3 * 5 * 5;
  __global double(*l)[3][5][5] = (__global double(*)[3][5][5]) & a[k];

  for (h = 0; h < 5; h++) {
    for (i = 0; i < 5; i++) {
      l[e][0][h][i] = 0.0;
      l[e][1][h][i] = 0.0;
      l[e][2][h][i] = 0.0;
    }
    l[e][1][h][h] = 1.0;
  }
}
