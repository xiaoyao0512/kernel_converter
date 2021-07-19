__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i;
  double j, k, l, m[5];

  h = get_global_id(1);
  f = get_global_id(0);
  if (h >= e || f >= c)
    return;

  __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  l = (double)h * (1.0 / (double)(12 - 1));
  j = (double)f * (1.0 / (double)(12 - 1));

  g = 0;
  k = 0.0;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }

  g = d - 1;
  k = 1.0;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }
}
