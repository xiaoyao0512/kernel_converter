__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, int e, int f, int g, int h) {
  int i = get_global_id(1) + 1;
  int j = get_group_id(0) + 1;
  int k = get_local_id(0);
  __local double l[1024], m[1024];

  int n;
  for (n = k; n < e; n += get_local_size(0)) {
    l[n] = b[i * f * e + (j - 1) * e + n + h] + b[i * f * e + (j + 1) * e + n + h] + b[(i - 1) * f * e + j * e + n + h] + b[(i + 1) * f * e + j * e + n + h];
    m[n] = b[(i - 1) * f * e + (j - 1) * e + n + h] + b[(i - 1) * f * e + (j + 1) * e + n + h] + b[(i + 1) * f * e + (j - 1) * e + n + h] + b[(i + 1) * f * e + (j + 1) * e + n + h];
  }

  barrier(1);

  for (n = k + 1; n < e - 1; n += get_local_size(0)) {
    a[i * f * e + j * e + n + h] = c[i * f * e + j * e + n + h] - d[0] * b[i * f * e + j * e + n + h] - d[2] * (m[n] + l[n - 1] + l[n + 1]) - d[3] * (m[n - 1] + m[n + 1]);
  }
}
