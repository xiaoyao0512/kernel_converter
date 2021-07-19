__kernel void A(__global double* a, __global double* b, __global double* c, int d, int e, int f, int g) {
  int h = get_global_id(1) + 1;
  int i = get_group_id(0) + 1;
  int j = get_local_id(0);
  __local double k[1024], l[1024];

  int m;
  for (m = j; m < d; m += get_local_size(0)) {
    k[m] = a[h * e * d + (i - 1) * e + m + g] + a[h * e * d + (i + 1) * d + m + g] + a[(h - 1) * e * d + i * d + m + g] + a[(h + 1) * e * d + i * d + m + g];
    l[m] = a[(h - 1) * e * d + (i - 1) * d + m + g] + a[(h - 1) * e * d + (i + 1) * d + m + g] + a[(h + 1) * e * d + (i - 1) * d + m + g] + a[(h + 1) * e * d + (i + 1) * d + m + g];
  }

  barrier(1);

  for (m = j + 1; m < d - 1; m += get_local_size(0)) {
    b[h * e * d + i * d + m + g] = b[h * e * d + i * d + m + g] + c[0] * a[h * e * d + i * d + m + g] + c[1] * (a[h * e * d + i * d + m - 1 + g] + a[h * e * d + i * d + m + 1 + g] + k[m]) + c[2] * (l[m] + k[m - 1] + k[m + 1]);
  }
}
