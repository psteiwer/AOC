Class AOC.Y2015.Day10 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 10;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set l=pInput
	set:l="" l="1113122113"
	
	for i=1:1:40 {
		set lastchar=$e(l,1)
		set counter=1
		set newl=""
		for j=2:1:$length(l)+1 {
			set char=$e(l,j)
			if lastchar=char {
				set counter=$i(counter)
			} else {
				set newl=newl_counter_lastchar
				set counter=1
			}
			set lastchar=char
		}
		set l=newl
		set newl=""
		zw:pDebug l
		break:pDebug
	}

	Quit $length(l)
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	set res=""
	Set temp=pInput
	set:temp="" temp="1113122113"
	set l=##class(%Stream.FileCharacter).%New()
	do l.Write(temp)
	
	for i=1:1:50 {
		set lastchar=l.Read(1)
		set counter=1
		set newl=##class(%Stream.FileCharacter).%New()
		while 'l.AtEnd {
			set char=l.Read(1)
			if lastchar=char {
				set counter=$i(counter)
			} else {
				d newl.Write(counter_lastchar)
				set counter=1
			}
			set lastchar=char
		}
		d newl.Write(counter_lastchar)
		d l.CopyFrom(newl)
		w:pDebug newl.Read(),!
		break:pDebug
	}
	
	set templine=l.Read()
	while templine'="" {
		zw:pDebug templine
		set res=res+$length(templine)
		set templine=l.Read()
	}

	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day10).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day10).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
