__kernel void A(__global double* a, int b, int c, int d) {
  int e, f, g;
  double h, i, j, k, l, m, n;

  g = get_global_id(2) + 1;
  f = get_global_id(1) + 1;
  e = get_global_id(0) + 1;
  if (g > d || f > c || e > b)
    return;

  __global double(*o)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

  h = o[g][f][e][0];
  i = o[g][f][e][1];
  j = o[g][f][e][2];
  k = o[g][f][e][3];
  l = o[g][f][e][4];

  m = sqrt(0.5) * h;
  n = 0.5 * (k + l);

  o[g][f][e][0] = sqrt(0.5) * (k - l);
  o[g][f][e][1] = -j;
  o[g][f][e][2] = i;
  o[g][f][e][3] = -m + n;
  o[g][f][e][4] = m + n;
}
