/*
 * topo.c created Thu Feb  7 15:49:40 CET 2002
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
	int i,j;
	double h[IMAX][JMAX];
	double r,x,y;
	double dx=8000.,dy=8000.;
	double x0=dx/2.,y0=dy/2.;


	for(i=0;i<IMAX; i++)
		for(j=0;j<JMAX; j++)
			h[i][j] = -10.;

	for(i=1;i<IMAX-1; i++)
		for(j=1;j<JMAX-1; j++) {
			x = dx*(i-IMAX/2);
			y = dy*(j-JMAX/2);
			r = -(x*x+y*y)/(L*L); 
			h[i][j]=HMAX*(1. - A*exp(r));
		}

	fprintf(stdout,"grid_type = 1 ;\n\n");

	fprintf(stdout,"x = \n");
	for(i=0;i<IMAX; i++)
		if(i == IMAX-1) {
			fprintf(stdout,"%lf ;\n",x0+i*dx);
		} else {
		fprintf(stdout,"%lf ,\n",x0+i*dx);
		}

	fprintf(stdout,"y = \n");
	for(j=0;j<JMAX; j++)
		if(j == JMAX-1) {
			fprintf(stdout,"%lf ;\n",y0+j*dy);
		} else {
			fprintf(stdout,"%lf ,\n",y0+j*dy);
		}

	fprintf(stdout,"bathymetry = \n");
	for(i=0;i<IMAX; i++)
		for(j=0;j<JMAX; j++)
			if(i == IMAX-1 && j == JMAX-1) {
				fprintf(stdout,"%12.5f ;\n",h[i][j]);
			} else {
				fprintf(stdout,"%12.5f ,\n",h[i][j]);
			}


	fprintf(stdout,"\n}\n");
	return 0;
}
