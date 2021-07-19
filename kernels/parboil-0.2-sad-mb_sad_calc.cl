__kernel void A(__global unsigned short* a, __global unsigned short* b, int c, int d) {
  //const sampler_t f;

  int g = (get_local_id(0) / 32) % 128;
  int h = (get_local_id(0) / 32) / 128;
  int i = get_group_id(0);
  int j = get_group_id(1);
  int k = c * 16;

  int l = (g + i * 128) >> 2;
  int m = (h + j * 16) >> 2;
  int n = (g + i * 128) & 0x03;
  int o = (h + j * 16) & 0x03;

  if ((l < c) && (m < d)) {
    int p = ((l << 2) + n) << 2;
    int q = ((m << 2) + o) << 2;

    int r = p - 16;
    int s = q - 16;

    int t = q * k + p;

    int u;
    int v = (get_local_id(0) % 32) * 8;
    int w = v + 8;

    a += c * d * 1024 * (9 + 16) + (m * c + l) * 1024 * 16 + (4 * o + n) * 1024;

    if (w > 32)
      w = 32;

    for (u = v; u < w; u++) {
      unsigned short x = 0;
      int y = r + (u % 4);
      int z = s + (u / 4);

      for (int aa = 0; aa < 4; aa++) {
        for (int ab = 0; ab < 4; ab++) {
          x += b[t + aa * k + ab];
        }
      }

      a[u] = x;
    }
  }
}
