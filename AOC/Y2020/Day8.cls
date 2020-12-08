Class AOC.Y2020.Day8 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 8;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set program=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day8).ParseString(l," ",.op,.arg)
		
		set program($i(program))=$lb(op,+arg)
		
		set pos=$o(pInput(pos),1,l)
	}

	
	set acc=0
	set line=1
	while line<program {
		if $d(executed(line)) {
			return acc
		} else {
			set executed(line)=""
		}
		set op=$LG(program(line),1)
		set arg=$LG(program(line),2)

		if op="nop" {
			// do nothing
		} elseif op="acc" {
			set acc=acc+arg
		} elseif op="jmp" {
			// -1 to account for line+ later
			set line=line+arg-1
		}

		set line=line+1
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set program=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day8).ParseString(l," ",.op,.arg)
		
		set program($i(program))=$lb(op,+arg)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	for i=1:1:program {
		set loop=0
		set acc=0
		set line=1
		k executed
		k tempprogram
		merge tempprogram=program
		if $LG(program(i),1)="jmp" {
			w "swapping jmp to nop in line "_i,!
			set $LIST(tempprogram(i),1)="nop"
			zw program(i)
			zw tempprogram(i)
		} elseif $LG(program(i),1)="nop" {
			w "swapping nop to jmp in line "_i,!
			set $LIST(tempprogram(i),1)="jmp"
			zw program(i)
			zw tempprogram(i)
		}
		while ((line>0)&&(line<program)&&('loop)) {
			if $d(executed(line)) {
				set loop=1
			} else {
				set executed(line)=""
			}
			set op=$LG(tempprogram(line),1)
			set arg=$LG(tempprogram(line),2)

			if op="nop" {
				// do nothing
			} elseif op="acc" {
				set acc=acc+arg
			} elseif op="jmp" {
				// -1 to account for line+ later
				set line=line+arg-1
			}

			set line=line+1
		}

		if loop=0 {
			return acc
		}
	}
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day8).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day8).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
