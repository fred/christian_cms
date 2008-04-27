/*  
 *  Author: Daniel Parker
 *
 *  SmartForms is freely distributable under the terms of an MIT-style license.
 *  Please contribute! I am not an avid javascript programmer - if you have an
 *  enhancement, please email it to smart_forms+enhancement@yanno.org
 *
/*--------------------------------------------------------------------------*/

function numbersonly(e){
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8 && unicode!=9 && unicode!=16 && unicode!=17 && unicode!=35 && unicode!=36 && unicode!=37 && unicode!=39 && unicode!=45 && unicode!=46 && unicode!=114 && unicode!=116 && unicode!=190 && unicode!=63232 && unicode!=63233 && unicode!=63234 && unicode!=63235 && unicode!=46 && unicode!=63272) { //allow all these keys: 8=backspace; 9=tab; 16=shift; 17=ctrl; 35=end; 36=home; 37=left; 39=right; 190=period; 63232+=safari-arrowkeys;
		if (unicode<48||unicode>57) //if not a number
			return false //disable key press
	}
}

/* I'd like to have this default to blank, but fill in the parenthesis and dashes as the numbers are filled in (only allowing numbers to be entered). */
function telephonenumbercorrect(e){
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8 && unicode!=9 && unicode!=16 && unicode!=17 && unicode!=32 && unicode!=35 && unicode!=36 && unicode!=37 && unicode!=39 && unicode!=40 && unicode!=41 && unicode!=45 && unicode!=46 && unicode!=114 && unicode!=116 && unicode!=190 && unicode!=63232 && unicode!=63233 && unicode!=63234 && unicode!=63235 && unicode!=46 && unicode!=63272) { //allow all these keys: 8=backspace; 9=tab; 16=shift; 17=ctrl; 35=end; 36=home; 37=left; 39=right; 190=period; 63232+=safari-arrowkeys;
		if(unicode<48||unicode>57){ //if not a number
			return false; //disable key press
		}
	}
}

/* I'd like to have this default to blank, but fill in the dashes as the numbers are filled in (only allowing numbers to be entered). */
function socialsecuritycorrect(e){
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8 && unicode!=9 && unicode!=16 && unicode!=17 && unicode!=35 && unicode!=36 && unicode!=37 && unicode!=39 && unicode!=45 && unicode!=46 && unicode!=114 && unicode!=116 && unicode!=190 && unicode!=63232 && unicode!=63233 && unicode!=63234 && unicode!=63235 && unicode!=46 && unicode!=63272) { //allow all these keys: 8=backspace; 9=tab; 16=shift; 17=ctrl; 35=end; 36=home; 37=left; 39=right; 190=period; 63232+=safari-arrowkeys;
		if (unicode<48||unicode>57){ //if not a number
			return false //disable key press
		}
	}
}

/* I'd like to have this default to 0.00 and fill in from the right to the left like a cash register, keeping the decimal only two places from the right, perhaps inserting commas as well. (Perhaps somehow take the commas out when the form is submitted, or keep a mirrored no-comma version in a hidden field?) */
function currencycorrect(e){
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8 && unicode!=9 && unicode!=16 && unicode!=17 && unicode!=35 && unicode!=36 && unicode!=37 && unicode!=39 && unicode!=46 && unicode!=114 && unicode!=116 && unicode!=190 && unicode!=63232 && unicode!=63233 && unicode!=63234 && unicode!=63235 && unicode!=46 && unicode!=63272) { //allow all these keys: 8=backspace; 9=tab; 16=shift; 17=ctrl; 35=end; 36=home; 37=left; 39=right; 190=period; 63232+=safari-arrowkeys;
		if (unicode<48||unicode>57) //if not a number
			return false //disable key press
	}
}

function values_toggle(linkel, input_id, values, labels){
	var elem = $(input_id);
	var position = values.indexOf(elem.value);
	position = position + 1;
	if(position == values.length){
		position = 0;
	}
	elem.value = values[position];
	linkel.firstChild.nodeValue = labels[position];
	true;
}
