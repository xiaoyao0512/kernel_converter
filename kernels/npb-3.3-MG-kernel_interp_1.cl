__kernel void A(__global double* a, int b, int c, int d, int e, int f, int g, int h, int i) {
  int j, k, l;
  __local double m[1024], n[1024], o[1024];

  __global double* p = a + h;
  __global double* q = a + i;

  j = get_global_id(1);
  k = get_group_id(0);
  l = get_local_id(0);
  m[l] = p[j * c * b + (k + 1) * b + l] + p[j * c * b + k * b + l];
  n[l] = p[(j + 1) * c * b + k * b + l] + p[j * c * b + k * b + l];
  o[l] = p[(j + 1) * c * b + (k + 1) * b + l] + p[(j + 1) * c * b + k * b + l] + m[l];

  barrier(1);

  if (l < b - 1) {
    double r = p[j * c * b + k * b + l];
    q[2 * j * f * e + 2 * k * e + 2 * l] += r;
    q[2 * j * f * e + 2 * k * e + 2 * l + 1] += 0.5 * (p[j * c * b + k * b + l + 1] + r);

    q[2 * j * f * e + (2 * k + 1) * e + 2 * l] += 0.5 * m[l];
    q[2 * j * f * e + (2 * k + 1) * e + 2 * l + 1] += 0.25 * (m[l] + m[l + 1]);

    q[(2 * j + 1) * f * e + 2 * k * e + 2 * l] += 0.5 * n[l];
    q[(2 * j + 1) * f * e + 2 * k * e + 2 * l + 1] += 0.25 * (n[l] + n[l + 1]);

    q[(2 * j + 1) * f * e + (2 * k + 1) * e + 2 * l] += 0.25 * o[l];
    q[(2 * j + 1) * f * e + (2 * k + 1) * e + 2 * l + 1] += 0.125 * (o[l] + o[l + 1]);
  }
}
