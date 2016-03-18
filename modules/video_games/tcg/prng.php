<?php
$carry_flag = $old_carry = $zero_flag = $caca = $cacb = $cacc = $prnA = $prnB = $reg_a = $reg_b = $reg_c = $reg_d = $reg_e = $reg_h = $reg_l = 0;
// Replace with the desired starting iteration and number of iterations
$starting_iteration = 0x00;
$iterations = 0x1000;

echo '<span style="font-family:Courier New">';
for($i=1;$i<$iterations;$i++){
	$reg_a = $caca;
	$reg_d = $cacb;
	$reg_e = $reg_a;
	$reg_a = $reg_d;
	
	$carry_flag = $reg_a << 1;
	$reg_a = ($carry_flag|$carry_flag>>8)&0xFF;
	$carry_flag = $reg_a << 1;
	$reg_a = ($carry_flag|$carry_flag>>8)&0xFF;
	$reg_a ^= $reg_e;
	$old_carry = $carry_flag&0x100;
	$carry_flag = $reg_a << 8;
	$reg_a = ($reg_a | $old_carry) >> 1;
	$zero_flag = 1;
	$prnA = $reg_a;
	
	$reg_a = $reg_d;
	$reg_a ^= $reg_e;
	$reg_d = $reg_a;
	$reg_a = $cacc;
	$reg_a ^= $reg_e;
	$reg_e = $reg_a;
	$reg_a = $prnA;
	$old_carry = $carry_flag >> 8 & 1;
	$carry_flag = $reg_e << 1;
	$zero_flag = $carry_flag | $old_carry;
	$reg_e = $zero_flag&0xFF;
	$old_carry = $carry_flag >> 8 & 1;
	$carry_flag = $reg_d << 1;
	$zero_flag = $carry_flag | $old_carry;
	$reg_d = $zero_flag&0xFF;
	$reg_a = $reg_d;
	$reg_a ^= $reg_e;
	$prnB = $reg_a;
	
	$cacc++;
	$cacc &= 0xFF;
	$cacb = $reg_d;
	$caca = $reg_e;
	
	if($i>=$starting_iteration){
		if($i<0x100){
		echo "0";
		}
		if($i<0x10){
			echo "0";
		}
		echo strtoupper(dechex($i)).": ";
		if($caca<0x10){
			echo "0";
		}
		echo strtoupper(dechex($caca));
		if($cacb<0x10){
			echo "0";
		}
		echo strtoupper(dechex($cacb));
		// if($cacc<0x10){
			// echo "0";
		// }
		// echo strtoupper(dechex($cacc));
		echo "<br>";
	}
}
echo '</span>';
