#include <stdio.h>

#include <stdbool.h>

#include <math.h>

#include "type.h"
 void A(  double* a,  double* b,  double* c,  double* d,  double* e,  double* f,  double* g, int h, int i, int j) {
  int k, l, m;
  double n;
  double o[4];
  double p;

for (m = 0; m < 64; m++) {
for (l = 0; l < 64; l++) {
for (k = 0; k < 64; k++) {
  if (m >= j || l >= i || k >= h)
    continue;

  double(*q)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])b;
  double(*s)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])c;
  double(*t)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])d;
  double(*u)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])e;
  double(*v)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])f;
  double(*w)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])g;

  o[0] = q[m][l][k][0];
  o[1] = q[m][l][k][1];
  o[2] = q[m][l][k][2];
  o[3] = q[m][l][k][3];

  n = 1.0 / o[0];
  v[m][l][k] = n;
  r[m][l][k] = o[1] * n;
  s[m][l][k] = o[2] * n;
  t[m][l][k] = o[3] * n;
  p = 0.5 * (o[1] * o[1] + o[2] * o[2] + o[3] * o[3]) * n;
  w[m][l][k] = p;
  u[m][l][k] = p * n;
}

}
}
}


void main() {

double a[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double b[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double c[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double d[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double e[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double f[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
double g[64] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
int h = 8;
int i = 8;
int j = 8;

A (a, b, c, d, e, f, g, h, i, j);


}
