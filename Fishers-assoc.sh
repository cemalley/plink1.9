# Test for association with case/control setup and Fisher's exact.
# Three groups: EH, AD, NA: severe case, case, control. EH v. AD would mean case v. control, respectively, and AD v. NA would mean AD is the case.

PLINK="/users/cmalley/apps/plink-1.90/./plink"

$PLINK --vcf R501X.EHNA.vcf.gz --out R501X.EHNA --biallelic-only ; rm *.log
$PLINK --vcf R501X.EHAD.vcf.gz --out R501X.EHAD --biallelic-only ; rm *.log
$PLINK --vcf R501X.ADNA.vcf.gz --out R501X.ADNA --biallelic-only ; rm *.log


# (I make fam files in R with case/control status)

$PLINK --bfile R501X.EHNA --assoc fisher --allow-no-sex ; mv plink.assoc.fisher EHNA.plink.assoc.fisher

$PLINK --bfile R501X.EHAD --assoc fisher --allow-no-sex ; mv plink.assoc.fisher EHAD.plink.assoc.fisher

$PLINK --bfile R501X.ADNA --assoc fisher --allow-no-sex ; mv plink.assoc.fisher ADNA.plink.assoc.fisher
