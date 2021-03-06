Class AOC.Base
{

Parameter Year As %Integer;

ClassMethod GetInput(day, Output out) As %Status
{
	set st=$$$OK
	try {
		set path="C:\Users\psteiwer\Documents\AOC\Y"_..#Year_"\day"_day_".txt"
		set file=##class(%Stream.FileCharacter).%New()
		do file.LinkToFile(path)
		while 'file.AtEnd {
			set str=file.ReadLine()
			set out($i(out))=str
		}
	} catch ex {
		set st=ex.AsStatus()
	}
	
	quit st
}

ClassMethod ParseString(pString As %String = "", pDelimiter As %String = "", ByRef pVariables...)
{
	If ((pDelimiter="") || (pString="")) {
		Set pVariables(1)=pString
	} Else {
		For i=1:1:pVariables {
			If i=pVariables {
				Set pVariables(i)=$Piece(pString,pDelimiter,i,*)
			} Else {
				Set pVariables(i)=$Piece(pString,pDelimiter,i)
			}
		}
	}
}

ClassMethod Print2DArray(ByRef pArray, pPrintChar = "", highlightx = 0, highlighty = 0)
{
	set minX=99999
	set minY=99999
	set maxX=0
	set maxY=0
	set tempY=$o(pArray(""))
	while tempY'="" {
		set tempX=$o(pArray(tempY,""))
		while tempX'="" {
			set:maxX<tempX maxX=tempX
			set:maxY<tempY maxY=tempY
			set:minX>tempX minX=tempX
			set:minY>tempY minY=tempY
			
			set tempX=$o(pArray(tempY,tempX))
		}
		
		set tempY=$o(pArray(tempY))
	}
	
	for row=minY:1:maxY {
		for col=minX:1:maxX {
			if (pPrintChar="")||(pPrintChar[$g(pArray(row,col))) {
				if ((col=0)&&(row=0)) {
					w *27,"[41m"
				}
				if ((highlightx=col)&&(highlighty=row)) {
					w *27,"[42m"
				}
				w $g(pArray(row,col)," ")
				if ((highlightx=col)&&(highlighty=row)) {
					w *27,"[47m"
				}
				if ((col=0)&&(row=0)) {
					w *27,"[47m"
				}
			} else {
				w " "
			}
		}
		w !
	}
}

ClassMethod LCM(pFactors...) As %Integer
{
	Set tRes=1
	Set tMax=0
	
	For i=1:1:pFactors-1 {
		If pFactors(i)>tMax {
			Set tMax=pFactors(i)
		}
	}
	
	For i=2:1:tMax {
		Set tReset=0
		For j=1:1:pFactors {
			If ((pFactors(j)/i)=(pFactors(j)\i)) {
				Set pFactors(j)=pFactors(j)/i
				Set:'tReset tFactors=$i(tFactors)
				Set tFactors(tFactors)=i
				Set tReset=1
			}
		}
		Set:tReset i=1
	}
	
	For i=1:1:tFactors {
		set tRes=tRes*tFactors(i)
	}
	
	Quit tRes
}

ClassMethod CheckAllDays() As %Status
{
	Do $classmethod($classname(),"GetInput","RESULTS",.tResults)
	For tDay=1:1:25 {
		Set tClass="AOC.Y"_..#Year_".Day"_tDay
		Try {
			For tPart=1:1:2 {
				Set tMethod="Part"_tPart
				Set tExpected=$G(tResults(((tDay-1)*2)+tPart),"")
				If tExpected["//skip" {
					Write tClass_"."_tMethod_" skipped",!
				} ElseIf tExpected="" {
					Write $SYSTEM.Status.GetErrorText($$$ERROR(5001,tClass_"."_tMethod_" results not defined.")),!
				} Else {
					Set tRes=$classmethod(tClass,tMethod)
					If tRes'=tExpected {
						Write $SYSTEM.Status.GetErrorText($$$ERROR(5001,tClass_"."_tMethod_" not correct. Was: "_tRes_". Expected: "_tExpected)),!
					} Else {
						Write tClass_"."_tMethod_" OK",!
					}
				}
			}
		} Catch ex {
			// Add handling later, but this should mean that the day is not yet implemented
			Write $SYSTEM.Status.GetErrorText(ex.AsStatus()),!
		}
	}
	
	Quit $$$OK
}

}
