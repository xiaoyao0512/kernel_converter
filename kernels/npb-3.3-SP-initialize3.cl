__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i;
  double j, k, l, m[5];

  h = get_global_id(1);
  g = get_global_id(0);
  if (h >= e || g >= d)
    return;

  __global double(*n)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

  l = (double)h * (1.0 / (double)(12 - 1));
  k = (double)g * (1.0 / (double)(12 - 1));

  j = 0.0;
  f = 0;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }

  j = 1.0;
  f = c - 1;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }
}
