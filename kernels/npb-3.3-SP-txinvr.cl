__kernel void A(__global const double* a, __global const double* b, __global const double* c, __global const double* d, __global const double* e, __global const double* f, __global double* g, int h, int i, int j) {
  int k, l, m;
  double n, o, p, q, r, s, t, u, v, w, x, y, z, aa;

  m = get_global_id(2) + 1;
  l = get_global_id(1) + 1;
  k = get_global_id(0) + 1;
  if (m > j || l > i || k > h)
    return;

  __global double(*ab)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])a;
  __global double(*ac)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])b;
  __global double(*ad)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])c;
  __global double(*ae)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])d;
  __global double(*af)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])e;
  __global double(*ag)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])f;
  __global double(*ah)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])g;

  r = af[m][l][k];
  s = ab[m][l][k];
  t = ac[m][l][k];
  u = ad[m][l][k];
  q = ag[m][l][k];
  aa = q * q;

  v = ah[m][l][k][0];
  w = ah[m][l][k][1];
  x = ah[m][l][k][2];
  y = ah[m][l][k][3];
  z = ah[m][l][k][4];

  n = 0.4 / aa * (ae[m][l][k] * v - s * w - t * x - u * y + z);
  o = sqrt(0.5) * r * (s * v - w);
  p = (sqrt(0.5) * r * q) * n;

  ah[m][l][k][0] = v - n;
  ah[m][l][k][1] = -r * (u * v - y);
  ah[m][l][k][2] = r * (t * v - x);
  ah[m][l][k][3] = -o + p;
  ah[m][l][k][4] = o + p;
}
