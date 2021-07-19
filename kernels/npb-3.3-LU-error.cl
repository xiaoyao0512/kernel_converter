__kernel void A(__global double* a, __global double* b, __global double* c, __local double* d, int e, int f, int g) {
  int h, i, j, k, l;
  double m;
  double n[5];
  __local double* o;

  j = get_global_id(0) + 1;
  l = get_local_id(0);
  o = &d[l * 5];

  for (k = 0; k < 5; k++) {
    o[k] = 0.0;
  }

  if (j < g - 1) {
    __global double(*p)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

    for (i = 1; i < (f - 1); i++) {
      for (h = 1; h < (e - 1); h++) {
        A(h, i, j, n, b);
        for (k = 0; k < 5; k++) {
          m = (n[k] - p[j][i][h][k]);
          o[k] = o[k] + m * m;
        }
      }
    }
  }

  barrier(1);

  if (l == 0) {
    for (h = 1; h < get_local_size(0); h++) {
      __local double* q = &d[h * 5];
      for (k = 0; k < 5; k++) {
        o[k] += q[k];
      }
    }

    __global double* r = &c[get_group_id(0) * 5];
    for (k = 0; k < 5; k++) {
      r[k] = o[k];
    }
  }
}
