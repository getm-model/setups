/*
 * temp.c created Thu Feb  7 15:49:40 CET 2002
 *
 * Created using /home/kbk/scr/newdoc by kbk
 *
 * Description
*/

#include<stdio.h>
#include<stdlib.h>
#include<math.h>

void examine_args(int argc,char *argv[]);

int main(int argc,char *argv[])
{
	int k;
	double dz,z,t;

	dz=4500./KMAX;

	fprintf(stdout,"%d\n",KMAX);
	for(k=0; k<=KMAX; k++) {
		z=-k*dz;
		t=5.+15*exp(z/1000.);
		fprintf(stdout,"%7.1lf %8.3lf\n",z,t);
	}
  return 0;
}
