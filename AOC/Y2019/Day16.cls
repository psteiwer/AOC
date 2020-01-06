Class AOC.Y2019.Day16 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 16;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day16).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day16).ParseString(l,,.l)
		
		set count=0
		for i=1:1:$length(l) {
			set vals(i)=$e(l,i)
			set vals=i
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set pattern=3
	set pattern(0)=0
	set pattern(1)=1
	set pattern(2)=0
	set pattern(3)=-1
	
	set numphases=100
	for phase=1:1:numphases {
		for pos=1:1:vals {
			k temppattern
			//compute temppattern
			for i=1:1:vals+1 {
				for j=0:1:pos-1 {
					continue:((i=1)&&(j=0))
					set temppattern($i(temppattern))=pattern((i-1)#(pattern+1))
					quit:temppattern>vals
				}
				quit:$G(temppattern)>vals
			}
			
			set tempout=0
			for pos2=1:1:vals {
				set tempout=tempout+(vals(pos2)*temppattern(pos2))
			}
			set vals(pos)=$zabs(tempout)#10
		}
		set res=""
		w:pDebug "after phase "_phase,!
		for i=1:1:8 {
			set res=res_vals(i)
		}
		w:pDebug res,!
	}
	
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day16).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day16).ParseString(l,,.l)
		
		for i=1:1:$length(l) {
			set tempvals(i)=$e(l,i)
			set tempvals=i
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	for i=1:1:10000 {
		for j=1:1:tempvals {
			set vals($i(vals))=tempvals(j)
		}
	}
	
	k tempvals
	
	set offset=vals(1)_vals(2)_vals(3)_vals(4)_vals(5)_vals(6)_vals(7)
	
	zw:pDebug offset
	
	set phases=100
	for i=1:1:phases {
		set pos=vals
		set sum=0
		while pos>=offset {
			set sum=sum+vals(pos)
			set vals(pos)=$zabs(sum)#10
			if (pos>6499997)&&pDebug {
				zw pos
				zw sum
				zw vals(pos)
				break
			}
			
			set pos=$i(pos,-1)
		}
		w:pDebug "PHASE "_i_" COMPLETE",!
	}
	
	for i=offset+1:1:offset+8 {
		set res=res_vals(i)
	}
	zw:pDebug res
	break:pDebug
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day16).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day16).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
