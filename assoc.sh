# Running association tests with case/control pairwise comparisons for three groups, and using Fisher's exact test and a logistic regression.

cd /dcl01/mathias1/data/ADRN_804/platypus_edc/assoc
PLINK="/users/cmalley/apps/plink-1.90/./plink"

parallel "bgzip -c {} > {}.gz; tabix -p vcf {}.gz" :::: vcfs.txt

parallel -j 4 "$PLINK --vcf ADRN_{}_799_platypus_maxvar8_minreads5.QC.vcf.gz --out {}.plink --biallelic-only ; rm *.log" ::: EDC ifng il4ra stat6

# ADNA is column 4, column 5 is EHAD, column 6 is EHNA.
parallel -j 4 "$PLINK --bfile {}.plink --assoc fisher --allow-no-sex --pheno allpheno.csv --mpheno 4 --out {}.ADNA" ::: EDC ifng il4ra stat6

parallel -j 4 "$PLINK --bfile {}.plink --assoc fisher --allow-no-sex --pheno allpheno.csv --mpheno 5 --out {}.EHAD"  ::: EDC ifng il4ra stat6

parallel -j 4 "$PLINK --bfile {}.plink --assoc fisher --allow-no-sex --pheno allpheno.csv --mpheno 6 --out {}.EHNA" ::: EDC ifng il4ra stat6

rm *.log; rm *.nosex

#
# GLM:
parallel -j 4 "$PLINK --bfile {}.plink --logistic --allow-no-sex --pheno allpheno.csv --mpheno 4 --out {}.ADNA" ::: EDC ifng il4ra stat6

parallel -j 4 "$PLINK --bfile {}.plink --logistic --allow-no-sex --pheno allpheno.csv --mpheno 5 --out {}.EHAD" ::: EDC ifng il4ra stat6

parallel -j 4 "$PLINK --bfile {}.plink --logistic --allow-no-sex --pheno allpheno.csv --mpheno 6 --out {}.EHNA" ::: EDC ifng il4ra stat6

rm *.log; rm *.nosex
#

# To peek at p-values less than or equal to 1x10^-7:
# awk ' $8 <= 0.000001 ' EDC.EHNA.assoc.fisher
