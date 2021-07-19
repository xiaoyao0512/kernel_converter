#include <stdio.h>

#include <stdbool.h>

#include <math.h>

#include "type.h"
 void A(  int* a,  int* b,  int* c,  int* d,  int* e, int f, int g, int h, int i, int j, int k, int l) {
for (int m = 0; m < 16; m++) {

  int n = m;

  int o = k * f + l;

  int p = m + i - h;
  int q = i - m - 1;

  int r = o + f * 64 * q + 64 * p + n + (f + 1);
  int s = o + f * 64 * q + 64 * p + n + (1);
  int t = o + f * 64 * q + 64 * p + (f);
  int u = o + f * 64 * q + 64 * p;

  if (n == 0)
    d[(0 + n * (64 + 1))%16] = b[(u)%16];

  for (int v = 0; v < 64; v++)
    e[(n + v * 1)%16] = a[(r + f * v)%16];

  //barrier(1);
  //barrier(1);

  d[(0 + (n + 1) * (64 + 1))%16] = b[(t + f * n)%16];

  //barrier(1);
  //barrier(1);

  d[((n + 1) + 0 * (64 + 1))%16] = b[(s)%16];

  //barrier(1);
  //barrier(1);

  for (int w = 0; w < 64; w++) {
    if (n <= w) {
      int x = n + 1;
      int y = w - n + 1;

      d[(x + y * (1 + 1))%16] = A(d[(x - 1) + (y - 1) * (1 + 1)] + e[(x - 1) + (y - 1) * 1], d[(x - 1) + (y) * (1 + 1)] - (g), d[(x) + (y - 1) * (1 + 1)] - (g));
    }
    //barrier(1);
    //barrier(1);
  }

  for (int w = 64 - 2; w >= 0; w--) {
    if (n <= w) {
      int x = n + 64 - w;
      int y = 64 - n;

      d[(x + y * (1 + 1))%16] = A(d[(x - 1) + (y - 1) * (1 + 1)] + e[(x - 1) + (y - 1) * 1], d[(x - 1) + (y) * (1 + 1)] - (g), d[(x) + (y - 1) * (1 + 1)] - (g));
    }

    //barrier(1);
    //barrier(1);
  }

  for (int v = 0; v < 64; v++)
    b[(r + v * f)%1] = d[((n + 1) + (v + 1) * (1 + 1))%16];

  continue;
}
}


void main() {

int a[16] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int b[16] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int c[16] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int d[16] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int e[16] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int f = 8;
int g = 8;
int h = 8;
int i = 8;
int j = 8;
int k = 8;
int l = 8;

A (a, b, c, d, e, f, g, h, i, j, k, l);


}
