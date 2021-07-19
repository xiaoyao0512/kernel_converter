__kernel void A(__global double* a, __global double* b, __local double* c, int d, int e, int f) {
  int g, h, i, j, k;
  double l;
  __local double* m;

  i = get_global_id(0) + 1;
  k = get_local_id(0);
  m = &c[k * 5];

  for (j = 0; j < 5; j++) {
    m[j] = 0.0;
  }

  if (i <= (f - 2)) {
    __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

    for (h = 1; h <= (e - 2); h++) {
      for (g = 1; g <= (d - 2); g++) {
        for (j = 0; j < 5; j++) {
          l = n[i][h][g][j];
          m[j] = m[j] + l * l;
        }
      }
    }
  }

  barrier(1);

  if (k == 0) {
    for (g = 1; g < get_local_size(0); g++) {
      __local double* o = &c[g * 5];
      for (j = 0; j < 5; j++) {
        m[j] += o[j];
      }
    }

    __global double* p = &b[get_group_id(0) * 5];
    for (j = 0; j < 5; j++) {
      p[j] = m[j];
    }
  }
}
