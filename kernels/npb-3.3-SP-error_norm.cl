__kernel void A(__global double* a, __constant double* b, __global double* c, __local double* d, int e, int f, int g) {
  int h, i, j, k, l;
  double m, n, o, p[5], q;
  __local double* r;

  j = get_global_id(0) + 1;
  l = get_local_id(0);
  r = &d[l * 5];

  for (k = 0; k < 5; k++) {
    r[k] = 0.0;
  }

  if (j < g) {
    __global double(*s)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

    o = (double)j * (1.0 / (double)(12 - 1));
    for (i = 0; i < f; i++) {
      n = (double)i * (1.0 / (double)(12 - 1));
      for (h = 0; h < e; h++) {
        m = (double)h * (1.0 / (double)(12 - 1));
        //A(m, n, o, p, b);

        for (k = 0; k < 5; k++) {
          q = s[j][i][h][k] - p[k];
          r[k] = r[k] + q * q;
        }
      }
    }
  }

  barrier(1);

  if (l == 0) {
    for (h = 1; h < get_local_size(0); h++) {
      __local double* t = &d[h * 5];
      for (k = 0; k < 5; k++) {
        r[k] += t[k];
      }
    }

    __global double* u = &c[get_group_id(0) * 5];
    for (k = 0; k < 5; k++) {
      u[k] = r[k];
    }
  }
}
