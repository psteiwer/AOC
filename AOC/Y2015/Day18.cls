Class AOC.Y2015.Day18 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 18;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day18).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set grid=-1
	while pos'="" {
		do ##class(AOC.Y2015.Day18).ParseString(l,,.l)
		set grid=$i(grid)
		for i=0:1:$length(l)-1 {
			set grid(grid,i)=$e(l,i+1)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	for count=1:1:100 {
		for row=0:1:99 {
			for col=0:1:99 {
				set ison=$G(grid(row,col))="#"
				set adjon=0
				for adjrow=-1:1:1 {
					for adjcol=-1:1:1 {
						continue:((adjrow=0)&&(adjcol=0))
						if $G(grid(row+adjrow,col+adjcol))="#" {
							set adjon=$i(adjon)
						}
					}
				}
				if ison&&((adjon=2)||(adjon=3)) {
					set nextgrid(col,row)="#"
				} elseif 'ison&&(adjon=3) {
					set nextgrid(col,row)="#"
				} else {
					set nextgrid(col,row)="."
				}
			}
		}
		k grid
		merge grid=nextgrid
		k nextgrid
	}

	for col=0:1:99 {
		for row=0:1:99 {
			if grid(col,row)="#" {
				set res=$i(res)
			}
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day18).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set grid=-1
	while pos'="" {
		do ##class(AOC.Y2015.Day18).ParseString(l,,.l)
		set grid=$i(grid)
		for i=0:1:$length(l)-1 {
			set grid(grid,i)=$e(l,i+1)
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	set grid(0,0)="#"
	set grid(0,99)="#"
	set grid(99,0)="#"
	set grid(99,99)="#"
	
	for count=1:1:100 {
		for row=0:1:99 {
			for col=0:1:99 {
				set ison=$G(grid(row,col))="#"
				set adjon=0
				for adjrow=-1:1:1 {
					for adjcol=-1:1:1 {
						continue:((adjrow=0)&&(adjcol=0))
						if $G(grid(row+adjrow,col+adjcol))="#" {
							set adjon=$i(adjon)
						}
					}
				}
				if ison&&((adjon=2)||(adjon=3)) {
					set nextgrid(col,row)="#"
				} elseif 'ison&&(adjon=3) {
					set nextgrid(col,row)="#"
				} else {
					set nextgrid(col,row)="."
				}
			}
		}
		k grid
		merge grid=nextgrid
		set grid(0,0)="#"
		set grid(0,99)="#"
		set grid(99,0)="#"
		set grid(99,99)="#"
		k nextgrid
	}

	for col=0:1:99 {
		for row=0:1:99 {
			if grid(col,row)="#" {
				set res=$i(res)
			}
		}
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day18).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day18).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
