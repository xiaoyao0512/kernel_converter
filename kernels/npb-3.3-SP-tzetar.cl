__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, __global double* e, __global double* f, __global double* g, int h, int i, int j) {
  int k, l, m;
  double n, o, p, q, r, s, t, u, v, w, x, y;
  double z, aa, ab;

  m = get_global_id(2) + 1;
  l = get_global_id(1) + 1;
  k = get_global_id(0) + 1;
  if (m > j || l > i || k > h)
    return;

  __global double(*ac)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;
  __global double(*ad)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])b;
  __global double(*ae)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])c;
  __global double(*af)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])d;
  __global double(*ag)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])e;
  __global double(*ah)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])f;
  __global double(*ai)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])g;

  r = ad[m][l][k];
  s = ae[m][l][k];
  t = af[m][l][k];
  q = ah[m][l][k];

  aa = q * q;

  u = ai[m][l][k][0];
  v = ai[m][l][k][1];
  w = ai[m][l][k][2];
  x = ai[m][l][k][3];
  y = ai[m][l][k][4];

  ab = ac[m][l][k][0];
  z = sqrt(0.5) * ab;

  n = z / q * (x + y);
  o = w + n;
  p = z * (x - y);

  ai[m][l][k][0] = o;
  ai[m][l][k][1] = -ab * v + r * o;
  ai[m][l][k][2] = ab * u + s * o;
  ai[m][l][k][3] = t * o + p;
  ai[m][l][k][4] = ab * (-r * v + s * u) + ag[m][l][k] * o + 2.5 * aa * n + t * p;
}
