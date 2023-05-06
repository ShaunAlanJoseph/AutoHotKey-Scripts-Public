posnsinstr(haystack, needle){
	array := []
	Loop{
		counter += 1
		posn := InStr(haystack, needle,,, counter)
		if !posn{
			break
		}
		array.push(posn)
	}
	return array
}

arraytostr(array, delimiter){
	length := array.length()
	Loop %length%{
		counter += 1
		string := string delimiter array[counter]
	}
	length := StrLen(delimiter) + 1
	string := SubStr(string, length)
	return string
}

removestrinbw(haystack, str1, str2){
	str1pos := InStr(haystack, str1)
	str2pos := InStr(haystack, str2)
	str1len := StrLen(str1)
	if (SubStr(haystack, str1pos + str1len, 1) == "`n"){
		string := SubStr(haystack, 1, str1pos + str1len) SubStr(haystack, str2pos)
	}
	else{
		string := SubStr(haystack, 1, str1pos + str1len - 1) SubStr(haystack, str2pos)
	}
	return string
}

getstrinbw(haystack, str1, str2){
	str1pos := InStr(haystack, str1)
	if (str1 == str2){
		str2pos := InStr(haystack, str2,,, 2)
	}
	else{
		str2pos := InStr(haystack, str2)
	}
	str1len := StrLen(str1)
	if (SubStr(haystack, str1pos + str1len, 1) == "`n"){
		string := SubStr(haystack, str1pos + str1len + 1, str2pos - str1pos - str1len - 1)
	}
	else{
		string := SubStr(haystack, str1pos + str1len, str2pos - str1pos - str1len)
	}
	return string
}

insertstr(haystack, string, posn){
	string := SubStr(haystack, 1, posn - 1) string SubStr(haystack, posn)
	return string
}

arrayofstrinbw(haystack, start1, start2, end1, end2, ByRef namearray := ""){
	namearray := []
	dataarray := []
	Loop{
		if (!InStr(haystack, start1) or !InStr(haystack, start2) or !InStr(haystack, end1) or !InStr(haystack, end2)){
			break
		}
		var1 := getstrinbw(haystack, start1, start2)
		namearray.push(var1)
		var2 := end1 var1 end2
		var1 := start1 var1 start2
		dataarray.push(getstrinbw(haystack, var1, var2))
		haystack := SubStr(haystack, InStr(haystack, var2) + StrLen(var2))
	}
	return dataarray
}

;arrayofstrinbw(haystack, startpt1, start2 := "", end1 := "", endpt2 := "", sectionnameformat := "both", ByRef namearray := ""){
	;dataarray := []
	;namearray := []
	;if (sectionnameformat == "single" and startpt1 != ""){
		;StrReplace(haystack, startpt1, startpt1, occurrences)
		;occurrences -= 1
		;Loop %occurrences%{
			;dataarray.push(getstrinbw(haystack, startpt1, startpt1))
			;haystack := SubStr(haystack, InStr(haystack, startpt1) + StrLen(startpt1))
		;}
	;}
	;else if (sectionnameformat == "none" and startpt1 != "" and end1 != "" and startpt1 != end1){
		;StrReplace(haystack, startpt1, startpt1, occurrences)
		;Loop %occurrences%{
			;dataarray.push(getstrinbw(haystack, startpt1, end1))
			;haystack := SubStr(haystack, InStr(haystack, end1) + StrLen(end1))
		;}
	;}
	;else if (sectionnameformat == "start" and start2 != ""){
		;Loop{
			;if (!InStr(haystack, startpt1) or !InStr(haystack, start2) or !InStr(haystack, end1)){
				;break
			;}
			;namearray.push(getstrinbw(haystack, startpt1, start2))
			;haystack := SubStr(haystack, InStr(haystack, start2))
			;dataarray.push(getstrinbw(haystack, start2, end1))
			;haystack := SubStr(haystack, InStr(haystack, end1) + StrLen(end1))
		;}
	;}
	;else if (sectionnameformat == "end" and endpt2 != ""){
		;Loop{
			;if (!InStr(haystack, startpt1) or !InStr(haystack, end1) or !InStr(haystack, endpt2)){
				;break
			;}
			;dataarray.push(getstrinbw(haystack, startpt1, end1))
			;MsgBox % getstrinbw(haystack, startpt1, end1)
			;haystack := SubStr(haystack, InStr(haystack, end1))
			;namearray.push(getstrinbw(haystack, end1, endpt2))
			;MsgBox % getstrinbw(haystack, end1, endpt2)
			;haystack := SubStr(haystack, InStr(haystack, endpt2) + StrLen(endpt2))
		;}
	;}
	;else if (sectionnameformat == "both" and start2 != "" and endpt2 != ""){
		;Loop{
			;var1 := getstrinbw(haystack, startpt1, start2)
			;namearray.push(var1)
			;var2 := end1 var1 endpt2
			;var1 := startpt1 var1 start2
			;dataarray.push(getstrinbw(haystack, var1, var2))
			;haystack := SubStr(haystack, InStr(haystack, var2) + StrLen(var2))
			;if (!InStr(haystack, startpt1) or !InStr(haystack, start2) or !InStr(haystack, end1) or !InStr(haystack, endpt2)){
				;break
			;}
		;}
	;}	
	;else{
		;MsgBox, arrayofstrinbw: error!! check parameters
	;}
	;return dataarray
;}