__kernel void A(__global unsigned short* a, int b, int c) {
  int d = get_local_id(1) & 1;
  int e = get_local_id(1) >> 1;

  int f = get_group_id(0);
  int g = get_group_id(1);

  int h = mul24(b, c);
  int i = (mul24(g, b) + f) * 1024;

  __global unsigned short* j;
  __global unsigned short *k, *l, *m;

  j = a + (mul24(h, 25) + (e * 8 + d * 2)) * 1024 + i * 16;

  k = a + ((h << 4) + h + (e * 4 + d * 2)) * 1024 + i * 8;

  if (e < 100) {
    l = a + ((h << 3) + h + (e * 4 + d)) * 1024 + i * 8;

    m = a + ((h << 2) + h + (e * 2 + d)) * 1024 + i * 4;
  }

  for (int n = get_local_id(0); n < (32 + 1) / 2; n += 32) {
       ushort2 o = (ushort2) (j(n)*2], j(n)*2+1]);
      ushort2 p = (ushort2) (j(n)*2], j(n)*2+1]);
      ushort2 q = (ushort2) (j(n/2)*2], j(n/2)*2+1]);
      ushort2 r = (ushort2) (j(n/2)*2], j(n/2)*2+1]);
      ((__global ushort2*)k)[n] = o + q;
      ((__global ushort2*)k)[n + 1024 / 2] = p + r;
      ((__global ushort2*)l)[n] = o + p;
      ((__global ushort2*)l)[n + 2 * 1024 / 2] = q + r;
      ((__global ushort2*)m)[n] = (o + p) + (q + r);
  }
}
