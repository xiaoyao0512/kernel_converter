__kernel void A(__global float* a, __global unsigned int* b, __global unsigned int* c, __global unsigned int* d, __global unsigned int* e, int f) {
  int g = get_global_id(0);

  int h, i, j, k;
  unsigned int l, m, n, o;
  unsigned int p[19], q, r, s;

  q = b[g];
  r = c[g];
  s = d[g];

  p[0] = e[g];
  for (h = 1; h < 19; h++)
    p[h] = (1812433253U * (p[h - 1] ^ (p[h - 1] >> 30)) + h) & 0xFFFFFFFFU;

  h = 0;
  m = p[0];
  for (k = 0; k < f; k++) {
    i = h + 1;
    j = h + 9;
    if (i >= 19)
      i -= 19;
    if (j >= 19)
      j -= 19;
    l = m;
    m = p[i];
    n = p[j];

    o = (l & 0xFFFFFFFEU) | (m & 0x1U);
    o = n ^ (o >> 1) ^ ((o & 1) ? q : 0);

    p[h] = o;
    h = i;

    o ^= (o >> 12);
    o ^= (o << 7) & r;
    o ^= (o << 15) & s;
    o ^= (o >> 18);

    a[g + k * 4096] = ((float)o + 1.0f) / 4294967296.0f;
  }
}
