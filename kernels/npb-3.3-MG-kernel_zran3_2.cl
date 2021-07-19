__kernel void A(__global double* a, __global double* b, __global int* c, __global int* d, __global int* e, int f, int g, int h, int i) {
  int j, k, l;
  int m;
  __global double* n = a + i;
  l = get_global_id(0);
  if (l >= h)
    return;

  __global double(*o)[10][2] = (__global double(*)[10][2])b;
  __global int(*p)[10][2] = (__global int(*)[10][2])c;
  __global int(*q)[10][2] = (__global int(*)[10][2])d;
  __global int(*r)[10][2] = (__global int(*)[10][2])e;

  for (m = 0; m < 10; m++) {
    o[l][m][1] = 0.0;
    p[l][m][1] = 0;
    q[l][m][1] = 0;
    r[l][m][1] = 0;
    o[l][m][0] = 1.0;
    p[l][m][0] = 0;
    q[l][m][0] = 0;
    r[l][m][0] = 0;
  }

  l = l + 1;
  for (k = 1; k < g - 1; k++)
    for (j = 1; j < f - 1; j++)
      if (l >= 1 && l < h - 1) {
        __global double* s = n + l * g * f;

        if (s[k * f + j] > o[l - 1][0][1]) {
          o[l - 1][0][1] = s[k * f + j];
          p[l - 1][0][1] = j;
          q[l - 1][0][1] = k;
          r[l - 1][0][1] = l;
          C(o[l - 1], p[l - 1], q[l - 1], r[l - 1], 10, 1);
        }
        if (s[k * f + j] < o[l - 1][0][0]) {
          o[l - 1][0][0] = s[k * f + j];
          p[l - 1][0][0] = j;
          q[l - 1][0][0] = k;
          r[l - 1][0][0] = l;
          C(o[l - 1], p[l - 1], q[l - 1], r[l - 1], 10, 0);
        }
      }
}
