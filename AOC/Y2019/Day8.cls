Class AOC.Y2019.Day8 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 8;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set row=0
		set col=0
		set layer=0
		for i=0:1:$l(l)-1 {
			set image(layer,row,col)=$e(l,i+1)
			
			set vals(layer,$e(l,i+1))=$i(vals(layer,$e(l,i+1)))
			
			set col=(col+1)#25
			set:((i>0)&&(col=0)) row=(row+1)#6
			set:((i>0)&&(col=0)&&(row=0)) layer=layer+1
		}
		set pos=$o(pInput(pos),1,l)
	}
	
	set minzero=9999999
	set layer=$o(vals(""))
	set row=0
	while layer'="" {
		set numzero=vals(layer,0)
		if numzero<minzero {
			set minzero=numzero
			set res=vals(layer,1)*vals(layer,2)
		}		
		set layer=$o(vals(layer))
	}
	
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set row=0
		set col=0
		set layer=0
		for i=0:1:$l(l)-1 {
			set image(layer,row,col)=$e(l,i+1)
			
			set vals(layer,$e(l,i+1))=$i(vals(layer,$e(l,i+1)))
			
			set col=(col+1)#25
			set:((i>0)&&(col=0)) row=(row+1)#6
			set:((i>0)&&(col=0)&&(row=0)) layer=layer+1
		}
		set pos=$o(pInput(pos),1,l)
	}
	
	for row=0:1:5 {
		for col=0:1:24 {
			set layer=$o(image(""))
			while layer'="" {
				set temp=image(layer,row,col)
				if temp=2 {
					set layer=$o(image(layer))
				} else {
					set res(row,col)=temp
					quit
				}
			}
		}
	}
	
	do ##class(AOC.Y2019).Print2DArray(.res,1)
	
	quit ""
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day8).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day8).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
