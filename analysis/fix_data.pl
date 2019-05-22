#Perl script to fix original fixed-width data  where each observation was on three separate lines
#this combines the three lines into one and prints out data to input/sexharrass_fwf_fixed.txt

open (RAW, "<input/sexharasFWF1994/ICPSR_06893/DS0003/sexharassfwf.txt") || die ("cant open file");
open (FIXED, ">input/sexharrass_fwf_fixed.txt") || die ("cant open file");

$counter=0;
$fullline = "";
foreach $line (<RAW>) {
  chomp $line;
  $fullline = join("",$fullline,$line);
  $counter++;
  if($counter>=3) {
    print(FIXED "$fullline\n");
    $fullline = "";
    $counter=0;
  }
}