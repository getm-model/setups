#!/bin/sh

first_year=1990
first_month=1
last_year=1990
last_month=12

yy=$first_year
years=""
while [ $yy -le $last_year ]
do
   years="$years $yy"
   yy=$[$yy+1]
done

months="1 2 3 4 5 6 7 8 9 10 11 12"

out_base=./output

for year in $years; do
   echo $year
   for month in $months; do
      if [ $year == 1990 -a $month == 1 ]; then
         ln -sf Config/baltic_4x2.xml.init baltic_4x2.xml
#         start=`printf "%04i-%02i-01 00:00:00" 1990 1`
#         stop=`printf "%04i-%02i-05 00:00:00" 1990 1`
      else
         ln -sf Config/baltic_4x2.xml.hot baltic_4x2.xml
#         start=`printf "%04i-%02i-10 00:00:00" 1990 1`
#         stop=`printf "%04i-%02i-11 00:00:00" 1990 1`
      fi

      if [ $month == 12 ]; then
         hot_year=$[$year+1]
         hot_month=1
      else
         hot_year=$year
         hot_month=$[$month+1]
      fi

      start=`printf "%04i-%02i-01 00:00:00" $year $month`
      stop=`printf "%04i-%02i-01 00:00:00" $hot_year $hot_month`
#      echo $start $stop
      out_dir=`printf "$out_base/%04i/%02i" $year $month`
      hot_dir=`printf "$out_base/%04i/%02i" $hot_year $hot_month`
      mkdir -p $out_dir $hot_dir

      make namelist start="$start" stop="$stop" out_dir=$out_dir
      mpiexec -np 30 bin/getm_spherical_parallel 
      mv getm.inp $out_dir
      mv *.stderr $out_dir
      rm *.stdout
      mmv "$out_dir/*.out" "$hot_dir/#1.in"
   done
done
