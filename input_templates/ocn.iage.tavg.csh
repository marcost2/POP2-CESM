#!/usr/bin/env csh -f

#------------------------------------------------------------------------------------
# For now, set streams manually. You must only set as many streams as are declared
#  in the tavg_nml section. For example, if there are three streams:
#  @ s1 = $my_stream
#  @ s2 = $s1 + 1
#  @ s3 = $s2 + 1
#------------------------------------------------------------------------------------

@ my_stream = $1
if ($my_stream < 1) then
   echo invalid my_stream number $my_stream
   exit 5
endif

@ s1 = 1   # use base-model stream 1

cat >! $CASEROOT/Buildconf/popconf/iage_tavg_contents << EOF
$s1  IAGE
EOF

#-------------------------------------------------------------------------------------
# Add optional tracer budget terms
#-------------------------------------------------------------------------------------
if ($OCN_TAVG_TRACER_BUDGET == TRUE) then
cat >> $CASEROOT/Buildconf/popconf/iage_tavg_contents << EOF
$s1  IAGE_RESET_TEND
$s1  DIA_IMPVF_IAGE
$s1  HDIFE_IAGE
$s1  HDIFN_IAGE
$s1  HDIFB_IAGE
$s1  UE_IAGE
$s1  VN_IAGE
$s1  WT_IAGE
$s1  TEND_IAGE
$s1  ADV_3D_IAGE
EOF
#  disable the following until they can be added based on model settings
#  RF_TEND_IAGE
#  Redi_TEND_IAGE
#  IAGE_FLUX_EXCH_INTRF
#  ISOP_ADV_TEND_IAGE
#  SUBM_ADV_TEND_IAGE
endif

#  disable the following until they are computed correctly
#  IAGE_SQR
#  UE_IAGE
#  VN_IAGE
#  WT_IAGE
#  ADV_IAGE
#  J_IAGE
#  Jint_IAGE
#  STF_IAGE
#  RESID_IAGE
#  FvPER_IAGE
#  FvICE_IAGE
