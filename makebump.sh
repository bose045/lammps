cp pair_lj_cut.cpp pair_lj_cut_bump.cpp
cp pair_lj_cut.h pair_lj_cut_bump.h
sed -i 's/lj\/cut/lj\/cut\/bump/g' pair_lj_cut_bump.h
sed -i 's/PairLJCut/PairLJCutBump/g' pair_lj_cut_bump.h
sed -i 's/LMP_PAIR_LJ_CUT_H/LMP_PAIR_LJ_CUT_BUMP_H/g' pair_lj_cut_bump.h
sed -i '/cut_respa;/a \ \ double **start_bump;' pair_lj_cut_bump.h
sed -i '/cut_respa;/a \ \ double **end_bump;' pair_lj_cut_bump.h
sed -i '/cut_respa;/a \ \ double **energy_bump;' pair_lj_cut_bump.h

sed -i 's/PairLJCut/PairLJCutBump/g' pair_lj_cut_bump.cpp
sed -i 's/pair_lj_cut.h/pair_lj_cut_bump.h/g' pair_lj_cut_bump.cpp
sed -i '/memory->destroy(offset);/a \ \ memory->destroy(start_bump);' pair_lj_cut_bump.cpp
sed -i '/memory->destroy(offset);/a \ \ memory->destroy(end_bump);' pair_lj_cut_bump.cpp
sed -i '/memory->destroy(offset);/a \ \ memory->destroy(energy_bump);' pair_lj_cut_bump.cpp
sed -i '0,/evdwl = 0.0;/s/evdwl = 0.0;/double rtmp, btmp;\n\ \ evdwl = 0.0;/' pair_lj_cut_bump.cpp
sed -i '0,/fpair = factor_lj\*forcelj\*r2inv;/s/fpair = factor_lj\*forcelj\*r2inv;/fpair = factor_lj\*forcelj\*r2inv;\n        rtmp = sqrt(rsq); \n        if(rtmp >= start_bump[itype][jtype] \&\& rtmp <= end_bump[itype][jtype]) { \n          fpair += -energy_bump[itype][jtype]\*MY_PI\*sin(MY_PI\*(end_bump[itype][jtype]+start_bump[itype][jtype]-rtmp-rtmp)\/(end_bump[itype][jtype]-start_bump[itype][jtype]))\/(end_bump[itype][jtype]-start_bump[itype][jtype])\/rtmp; \n }/' pair_lj_cut_bump.cpp

sed -i '0,/evdwl\ \*=\ factor_lj;/s/evdwl\ \*=\ factor_lj;/if(rtmp >= start_bump[itype][jtype] \&\& rtmp <= end_bump[itype][jtype]) {\n            btmp =sin(MY_PI\*(end_bump[itype][jtype]-rtmp)\/(end_bump[itype][jtype]-start_bump[itype][jtype]));\n            evdwl += energy_bump[itype][jtype]\*btmp\*btmp;\n          }\n\nevdwl\ \*=\ factor_lj;/' pair_lj_cut_bump.cpp

sed -i '/memory->create(offset,n+1,n+1,\"pair:offset\");/a \ \ memory->create(start_bump,n+1,n+1,\"pair:startbump\");' pair_lj_cut_bump.cpp
sed -i '/memory->create(offset,n+1,n+1,\"pair:offset\");/a \ \ memory->create(end_bump,n+1,n+1,\"pair:endbump\");' pair_lj_cut_bump.cpp
sed -i '/memory->create(offset,n+1,n+1,\"pair:offset\");/a \ \ memory->create(energy_bump,n+1,n+1,\"pair:energybump\");' pair_lj_cut_bump.cpp

sed -i '/\ =\ cut_one;/a \ \ start_bump[j][i]  = start_bump[i][j];' pair_lj_cut_bump.cpp
sed -i '/\ =\ cut_one;/a \ \ end_bump[j][i]    = end_bump[i][j];' pair_lj_cut_bump.cpp
sed -i '/\ =\ cut_one;/a \ \ energy_bump[j][i] = energy_bump[i][j];' pair_lj_cut_bump.cpp
sed -i '/\ =\ cut_one;/a \ \ start_bump[i][j]  = re_start  \* sigma[i][j];' pair_lj_cut_bump.cpp
sed -i '/\ =\ cut_one;/a \ \ end_bump[i][j]    = re_end   \* cut[i][j];' pair_lj_cut_bump.cpp
sed -i '/\ =\ cut_one;/a \ \ energy_bump[i][j] = re_energy \* epsilon[i][j];' pair_lj_cut_bump.cpp

sed -i '0,/return\ factor_lj\*philj;/s/return\ factor_lj\*philj;/double       rtmp = sqrt(rsq), btmp;\n          if(rtmp >= start_bump[itype][jtype] \&\& rtmp <= end_bump[itype][jtype]) {\n            btmp = sin(MY_PI\*(end_bump[itype][jtype]-rtmp)\/(end_bump[itype][jtype]-start_bump[itype][jtype]));\n            philj += energy_bump[itype][jtype]\*btmp*btmp;          }\n return\ factor_lj\*philj;/' pair_lj_cut_bump.cpp

sed -i 's/narg < 4/narg < 7/g' pair_lj_cut_bump.cpp
sed -i 's/narg > 5/narg > 8/g' pair_lj_cut_bump.cpp
sed -i 's/narg == 5/narg == 8/g' pair_lj_cut_bump.cpp
sed -i 's/arg\[4\]/arg\[7\]/g' pair_lj_cut_bump.cpp
sed -i '/double\ cut_one\ =\ cut_global;/a \ \ double re_start = atof(arg[4]);' pair_lj_cut_bump.cpp
sed -i '/double\ cut_one\ =\ cut_global;/a \ \ double re_end = atof(arg[5]);' pair_lj_cut_bump.cpp
sed -i '/double\ cut_one\ =\ cut_global;/a \ \ double re_energy = atof(arg[6]);' pair_lj_cut_bump.cpp

