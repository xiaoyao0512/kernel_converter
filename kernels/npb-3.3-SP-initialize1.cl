__kernel void A(__global double* a, int b, int c, int d) {
  int e = get_global_id(1);
  int f = get_global_id(0);
  if (e >= d || f >= c)
    return;

  int g;
  __global double(*h)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

  for (g = 0; g < b; g++) {
    h[e][f][g][0] = 1.0;
    h[e][f][g][1] = 0.0;
    h[e][f][g][2] = 0.0;
    h[e][f][g][3] = 0.0;
    h[e][f][g][4] = 1.0;
  }
}
