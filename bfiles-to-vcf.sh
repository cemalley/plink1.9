#!/usr/bin/bash

#purpose here: convert the set of binary files (bed, bim, fam) to a vcf.


cd /dcl01/barnes/data/adrneh/OMNI

PLINK19='/users/cmalley/apps/plink-1.90/./plink'

$PLINK19 --bfile ADRN_OMNI_clean --recode --out ADRN_OMNI_clean_recode --keep-allele-order

$PLINK19 --file ADRN_OMNI_clean_recode --recode vcf --out ADRN_OMNI_clean_vcf --keep-allele-order
