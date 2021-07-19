__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, i;
  double j, k, l, m[5];

  int h = get_global_id(1);
  int g = get_global_id(0);
  if (h >= e || g >= d)
    return;

  __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  l = (double)h * (1.0 / (double)(12 - 1));
  k = (double)g * (1.0 / (double)(12 - 1));

  f = 0;
  j = 0.0;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }

  f = c - 1;
  j = 1.0;
  A(j, k, l, m, b);
  for (i = 0; i < 5; i++) {
    n[h][g][f][i] = m[i];
  }
}
