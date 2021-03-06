__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, __global double* e, int f, int g, int h) {
  int i, j, k;
  double l, m, n;
  double o[5];

  j = get_global_id(2) + 1;
  i = get_global_id(1) + 1;
  k = get_global_id(0);
  if (j > (g - 2) || i > (f - 2) || k >= h)
    return;

  __global double(*p)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])a;
  __global double(*q)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])b;
  __global double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])c;

  int s = (j - 1) * (f - 2) + (i - 1);
  int t = s * (12 + 1) * 5 * 5;
  __global double(*u)[5][5] = (__global double(*)[5][5]) & d[t];
  __global double(*v)[5][5] = (__global double(*)[5][5]) & e[t];

  l = 1.0 / r[k][j][i][0];
  m = l * l;
  n = l * m;
  o[0] = r[k][j][i][0];
  o[1] = r[k][j][i][1];
  o[2] = r[k][j][i][2];
  o[3] = r[k][j][i][3];
  o[4] = r[k][j][i][4];

  u[k][0][0] = 0.0;
  u[k][1][0] = 0.0;
  u[k][2][0] = 0.0;
  u[k][3][0] = 1.0;
  u[k][4][0] = 0.0;

  u[k][0][1] = -(o[1] * o[3]) * m;
  u[k][1][1] = o[3] * l;
  u[k][2][1] = 0.0;
  u[k][3][1] = o[1] * l;
  u[k][4][1] = 0.0;

  u[k][0][2] = -(o[2] * o[3]) * m;
  u[k][1][2] = 0.0;
  u[k][2][2] = o[3] * l;
  u[k][3][2] = o[2] * l;
  u[k][4][2] = 0.0;

  u[k][0][3] = -(o[3] * o[3] * m) + 0.4 * p[k][j][i];
  u[k][1][3] = -0.4 * o[1] * l;
  u[k][2][3] = -0.4 * o[2] * l;
  u[k][3][3] = (2.0 - 0.4) * o[3] * l;
  u[k][4][3] = 0.4;

  u[k][0][4] = (0.4 * 2.0 * q[k][j][i] - 1.4 * o[4]) * o[3] * m;
  u[k][1][4] = -0.4 * (o[1] * o[3]) * m;
  u[k][2][4] = -0.4 * (o[2] * o[3]) * m;
  u[k][3][4] = 1.4 * (o[4] * l) - 0.4 * (p[k][j][i] + o[3] * o[3] * m);
  u[k][4][4] = 1.4 * o[3] * l;

  v[k][0][0] = 0.0;
  v[k][1][0] = 0.0;
  v[k][2][0] = 0.0;
  v[k][3][0] = 0.0;
  v[k][4][0] = 0.0;

  v[k][0][1] = -(0.1 * 1.0) * m * o[1];
  v[k][1][1] = (0.1 * 1.0) * l;
  v[k][2][1] = 0.0;
  v[k][3][1] = 0.0;
  v[k][4][1] = 0.0;

  v[k][0][2] = -(0.1 * 1.0) * m * o[2];
  v[k][1][2] = 0.0;
  v[k][2][2] = (0.1 * 1.0) * l;
  v[k][3][2] = 0.0;
  v[k][4][2] = 0.0;

  v[k][0][3] = -(4.0 / 3.0) * (0.1 * 1.0) * m * o[3];
  v[k][1][3] = 0.0;
  v[k][2][3] = 0.0;
  v[k][3][3] = (4.0 / 3.0) * 0.1 * 1.0 * l;
  v[k][4][3] = 0.0;

  v[k][0][4] = -((0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * n * (o[1] * o[1]) - ((0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * n * (o[2] * o[2]) - ((4.0 / 3.0) * (0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * n * (o[3] * o[3]) - ((1.4 * 1.4) * (0.1 * 1.0)) * m * o[4];

  v[k][1][4] = ((0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * m * o[1];
  v[k][2][4] = ((0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * m * o[2];
  v[k][3][4] = ((4.0 / 3.0) * (0.1 * 1.0) - ((1.4 * 1.4) * (0.1 * 1.0))) * m * o[3];
  v[k][4][4] = (((1.4 * 1.4) * (0.1 * 1.0))) * l;
}
