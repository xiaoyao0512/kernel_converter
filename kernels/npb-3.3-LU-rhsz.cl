__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, int e, int f, int g) {
  int h, i, j, k, l, m;
  double n;
  double o;
  double p;
  double q, r, s, t;
  double u, v, w, x;
  double y[3][5], z[2][5];
  double aa[5][5], ab[5];
  __global double(*ac)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*ad)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*ae)[12 / 2 * 2 + 1][12 / 2 * 2 + 1];
  __global double(*af)[12 / 2 * 2 + 1][12 / 2 * 2 + 1];

  i = get_global_id(1) + 1;
  h = get_global_id(0) + 1;
  if (i >= (f - 1) || h >= (e - 1))
    return;

  ac = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  ad = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])b;
  ae = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])c;
  af = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])d;
  k = 0;
  aa[3][0] = ac[0][i][h][0];
  aa[3][1] = ac[0][i][h][1];
  aa[3][2] = ac[0][i][h][2];
  aa[3][3] = ac[0][i][h][3];
  aa[3][4] = ac[0][i][h][4];
  y[1][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[1][1] = aa[3][1] * p;
  y[1][2] = aa[3][2] * p;
  y[1][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[1][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;

  j = 0;
  k = 1;
  for (m = 0; m < 5; m++)
    aa[2][m] = aa[3][m];
  aa[3][0] = ac[1][i][h][0];
  aa[3][1] = ac[1][i][h][1];
  aa[3][2] = ac[1][i][h][2];
  aa[3][3] = ac[1][i][h][3];
  aa[3][4] = ac[1][i][h][4];
  y[2][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[2][1] = aa[3][1] * p;
  y[2][2] = aa[3][2] * p;
  y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
  o = af[k][i][h];
  q = o * aa[3][1];
  r = o * aa[3][2];
  s = o * aa[3][3];
  t = o * aa[3][4];
  o = af[j][i][h];
  u = o * aa[2][1];
  v = o * aa[2][2];
  w = o * aa[2][3];
  x = o * aa[2][4];
  z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
  z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
  z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
  z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
  aa[4][0] = ac[2][i][h][0];
  aa[4][1] = ac[2][i][h][1];
  aa[4][2] = ac[2][i][h][2];
  aa[4][3] = ac[2][i][h][3];
  aa[4][4] = ac[2][i][h][4];

  j = 1;
  k = 2;
  l = 3;
  for (m = 0; m < 5; m++) {
    aa[0][m] = aa[1][m];
    aa[1][m] = aa[2][m];
    aa[2][m] = aa[3][m];
    aa[3][m] = aa[4][m];
    y[0][m] = y[1][m];
    y[1][m] = y[2][m];
    z[0][m] = z[1][m];
  }
  aa[4][0] = ac[l][i][h][0];
  aa[4][1] = ac[l][i][h][1];
  aa[4][2] = ac[l][i][h][2];
  aa[4][3] = ac[l][i][h][3];
  aa[4][4] = ac[l][i][h][4];
  y[2][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[2][1] = aa[3][1] * p;
  y[2][2] = aa[3][2] * p;
  y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
  o = af[k][i][h];
  q = o * aa[3][1];
  r = o * aa[3][2];
  s = o * aa[3][3];
  t = o * aa[3][4];
  o = af[j][i][h];
  u = o * aa[2][1];
  v = o * aa[2][2];
  w = o * aa[2][3];
  x = o * aa[2][4];
  z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
  z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
  z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
  z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
  for (m = 0; m < 5; m++) {
    ab[m] = ad[j][i][h][m] - (1.0 / (2.0 * (1.0 / (12 - 1)))) * (y[2][m] - y[0][m]);
  }
  ab[0] = ab[0] + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][0] - 2.0 * aa[2][0] + aa[3][0]);
  ab[1] = ab[1] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][1] - z[0][1]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][1] - 2.0 * aa[2][1] + aa[3][1]);
  ab[2] = ab[2] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][2] - z[0][2]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][2] - 2.0 * aa[2][2] + aa[3][2]);
  ab[3] = ab[3] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][3] - z[0][3]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][3] - 2.0 * aa[2][3] + aa[3][3]);
  ab[4] = ab[4] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][4] - z[0][4]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][4] - 2.0 * aa[2][4] + aa[3][4]);
  for (m = 0; m < 5; m++) {
    ad[1][i][h][m] = ab[m] - ((max(max(0.75, 0.75), 1.00)) / 4.0) * (+5.0 * aa[2][m] - 4.0 * aa[3][m] + aa[4][m]);
  }

  j = 2;
  k = 3;
  l = 4;
  for (m = 0; m < 5; m++) {
    aa[0][m] = aa[1][m];
    aa[1][m] = aa[2][m];
    aa[2][m] = aa[3][m];
    aa[3][m] = aa[4][m];
    y[0][m] = y[1][m];
    y[1][m] = y[2][m];
    z[0][m] = z[1][m];
  }
  aa[4][0] = ac[l][i][h][0];
  aa[4][1] = ac[l][i][h][1];
  aa[4][2] = ac[l][i][h][2];
  aa[4][3] = ac[l][i][h][3];
  aa[4][4] = ac[l][i][h][4];
  y[2][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[2][1] = aa[3][1] * p;
  y[2][2] = aa[3][2] * p;
  y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
  o = af[k][i][h];
  q = o * aa[3][1];
  r = o * aa[3][2];
  s = o * aa[3][3];
  t = o * aa[3][4];
  o = af[j][i][h];
  u = o * aa[2][1];
  v = o * aa[2][2];
  w = o * aa[2][3];
  x = o * aa[2][4];
  z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
  z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
  z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
  z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
  for (m = 0; m < 5; m++) {
    ab[m] = ad[j][i][h][m] - (1.0 / (2.0 * (1.0 / (12 - 1)))) * (y[2][m] - y[0][m]);
  }
  ab[0] = ab[0] + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][0] - 2.0 * aa[2][0] + aa[3][0]);
  ab[1] = ab[1] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][1] - z[0][1]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][1] - 2.0 * aa[2][1] + aa[3][1]);
  ab[2] = ab[2] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][2] - z[0][2]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][2] - 2.0 * aa[2][2] + aa[3][2]);
  ab[3] = ab[3] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][3] - z[0][3]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][3] - 2.0 * aa[2][3] + aa[3][3]);
  ab[4] = ab[4] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][4] - z[0][4]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][4] - 2.0 * aa[2][4] + aa[3][4]);
  for (m = 0; m < 5; m++) {
    ad[2][i][h][m] = ab[m] - ((max(max(0.75, 0.75), 1.00)) / 4.0) * (-4.0 * aa[1][m] + 6.0 * aa[2][m] - 4.0 * aa[3][m] + aa[4][m]);
  }

  for (j = 3; j < g - 3; j++) {
    k = j + 1;
    l = j + 2;
    for (m = 0; m < 5; m++) {
      aa[0][m] = aa[1][m];
      aa[1][m] = aa[2][m];
      aa[2][m] = aa[3][m];
      aa[3][m] = aa[4][m];
      y[0][m] = y[1][m];
      y[1][m] = y[2][m];
      z[0][m] = z[1][m];
    }
    aa[4][0] = ac[l][i][h][0];
    aa[4][1] = ac[l][i][h][1];
    aa[4][2] = ac[l][i][h][2];
    aa[4][3] = ac[l][i][h][3];
    aa[4][4] = ac[l][i][h][4];
    y[2][0] = aa[3][3];
    p = aa[3][3] * af[k][i][h];
    n = ae[k][i][h];
    y[2][1] = aa[3][1] * p;
    y[2][2] = aa[3][2] * p;
    y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
    y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
    o = af[k][i][h];
    q = o * aa[3][1];
    r = o * aa[3][2];
    s = o * aa[3][3];
    t = o * aa[3][4];
    o = af[j][i][h];
    u = o * aa[2][1];
    v = o * aa[2][2];
    w = o * aa[2][3];
    x = o * aa[2][4];
    z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
    z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
    z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
    z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
    for (m = 0; m < 5; m++) {
      ab[m] = ad[j][i][h][m] - (1.0 / (2.0 * (1.0 / (12 - 1)))) * (y[2][m] - y[0][m]);
    }
    ab[0] = ab[0] + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][0] - 2.0 * aa[2][0] + aa[3][0]);
    ab[1] = ab[1] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][1] - z[0][1]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][1] - 2.0 * aa[2][1] + aa[3][1]);
    ab[2] = ab[2] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][2] - z[0][2]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][2] - 2.0 * aa[2][2] + aa[3][2]);
    ab[3] = ab[3] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][3] - z[0][3]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][3] - 2.0 * aa[2][3] + aa[3][3]);
    ab[4] = ab[4] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][4] - z[0][4]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][4] - 2.0 * aa[2][4] + aa[3][4]);
    for (m = 0; m < 5; m++) {
      ad[j][i][h][m] = ab[m] - ((max(max(0.75, 0.75), 1.00)) / 4.0) * (aa[0][m] - 4.0 * aa[1][m] + 6.0 * aa[2][m] - 4.0 * aa[3][m] + aa[4][m]);
    }
  }

  j = g - 3;
  k = g - 2;
  l = g - 1;
  for (m = 0; m < 5; m++) {
    aa[0][m] = aa[1][m];
    aa[1][m] = aa[2][m];
    aa[2][m] = aa[3][m];
    aa[3][m] = aa[4][m];
    y[0][m] = y[1][m];
    y[1][m] = y[2][m];
    z[0][m] = z[1][m];
  }
  aa[4][0] = ac[l][i][h][0];
  aa[4][1] = ac[l][i][h][1];
  aa[4][2] = ac[l][i][h][2];
  aa[4][3] = ac[l][i][h][3];
  aa[4][4] = ac[l][i][h][4];
  y[2][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[2][1] = aa[3][1] * p;
  y[2][2] = aa[3][2] * p;
  y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
  o = af[k][i][h];
  q = o * aa[3][1];
  r = o * aa[3][2];
  s = o * aa[3][3];
  t = o * aa[3][4];
  o = af[j][i][h];
  u = o * aa[2][1];
  v = o * aa[2][2];
  w = o * aa[2][3];
  x = o * aa[2][4];
  z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
  z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
  z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
  z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
  for (m = 0; m < 5; m++) {
    ab[m] = ad[j][i][h][m] - (1.0 / (2.0 * (1.0 / (12 - 1)))) * (y[2][m] - y[0][m]);
  }
  ab[0] = ab[0] + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][0] - 2.0 * aa[2][0] + aa[3][0]);
  ab[1] = ab[1] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][1] - z[0][1]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][1] - 2.0 * aa[2][1] + aa[3][1]);
  ab[2] = ab[2] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][2] - z[0][2]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][2] - 2.0 * aa[2][2] + aa[3][2]);
  ab[3] = ab[3] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][3] - z[0][3]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][3] - 2.0 * aa[2][3] + aa[3][3]);
  ab[4] = ab[4] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][4] - z[0][4]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][4] - 2.0 * aa[2][4] + aa[3][4]);
  for (m = 0; m < 5; m++) {
    ad[g - 3][i][h][m] = ab[m] - ((max(max(0.75, 0.75), 1.00)) / 4.0) * (aa[0][m] - 4.0 * aa[1][m] + 6.0 * aa[2][m] - 4.0 * aa[3][m]);
  }

  j = g - 2;
  k = g - 1;
  for (m = 0; m < 5; m++) {
    aa[0][m] = aa[1][m];
    aa[1][m] = aa[2][m];
    aa[2][m] = aa[3][m];
    aa[3][m] = aa[4][m];
    y[0][m] = y[1][m];
    y[1][m] = y[2][m];
    z[0][m] = z[1][m];
  }
  y[2][0] = aa[3][3];
  p = aa[3][3] * af[k][i][h];
  n = ae[k][i][h];
  y[2][1] = aa[3][1] * p;
  y[2][2] = aa[3][2] * p;
  y[2][3] = aa[3][3] * p + 0.40e+00 * (aa[3][4] - n);
  y[2][4] = (1.40e+00 * aa[3][4] - 0.40e+00 * n) * p;
  o = af[k][i][h];
  q = o * aa[3][1];
  r = o * aa[3][2];
  s = o * aa[3][3];
  t = o * aa[3][4];
  o = af[j][i][h];
  u = o * aa[2][1];
  v = o * aa[2][2];
  w = o * aa[2][3];
  x = o * aa[2][4];
  z[1][1] = (1.0 / (1.0 / (12 - 1))) * (q - u);
  z[1][2] = (1.0 / (1.0 / (12 - 1))) * (r - v);
  z[1][3] = (4.0 / 3.0) * (1.0 / (1.0 / (12 - 1))) * (s - w);
  z[1][4] = 0.50 * (1.0 - 1.40e+00 * 1.40e+00) * (1.0 / (1.0 / (12 - 1))) * ((q * q + r * r + s * s) - (u * u + v * v + w * w)) + (1.0 / 6.0) * (1.0 / (1.0 / (12 - 1))) * (s * s - w * w) + 1.40e+00 * 1.40e+00 * (1.0 / (1.0 / (12 - 1))) * (t - x);
  for (m = 0; m < 5; m++) {
    ab[m] = ad[j][i][h][m] - (1.0 / (2.0 * (1.0 / (12 - 1)))) * (y[2][m] - y[0][m]);
  }
  ab[0] = ab[0] + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][0] - 2.0 * aa[2][0] + aa[3][0]);
  ab[1] = ab[1] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][1] - z[0][1]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][1] - 2.0 * aa[2][1] + aa[3][1]);
  ab[2] = ab[2] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][2] - z[0][2]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][2] - 2.0 * aa[2][2] + aa[3][2]);
  ab[3] = ab[3] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][3] - z[0][3]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][3] - 2.0 * aa[2][3] + aa[3][3]);
  ab[4] = ab[4] + (1.0 / (1.0 / (12 - 1))) * 1.00e-01 * 1.00e+00 * (z[1][4] - z[0][4]) + 1.00 * (1.0 / ((1.0 / (12 - 1)) * (1.0 / (12 - 1)))) * (aa[1][4] - 2.0 * aa[2][4] + aa[3][4]);
  for (m = 0; m < 5; m++) {
    ad[g - 2][i][h][m] = ab[m] - ((max(max(0.75, 0.75), 1.00)) / 4.0) * (aa[0][m] - 4.0 * aa[1][m] + 5.0 * aa[2][m]);
  }
}
