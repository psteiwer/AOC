Class AOC.Y2020.Day9 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 9;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day9).GetInput(..#Day,.pInput)
	
	set res=""
	set nums=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day9).ParseString(l,,.l)
		
		set nums($i(nums))=l
		
		set pos=$o(pInput(pos),1,l)
	}

	while res="" {
		for i=26:1:nums {
			set valid=0
			for j=i-25:1:i+24 {
				for k=j+1:1:i+25 {
					if (nums(j)+nums(k))=nums(i) {
						set valid=1
					}
				}
			}
			if valid=0 {
				set res=nums(i)
				return res
			}
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day9).GetInput(..#Day,.pInput)
	
	set res=""
	set nums=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day9).ParseString(l,,.l)
		
		set nums($i(nums))=l
		
		set pos=$o(pInput(pos),1,l)
	}

	while res="" {
		for i=26:1:nums {
			set valid=0
			for j=i-25:1:i+24 {
				for k=j+1:1:i+25 {
					if (nums(j)+nums(k))=nums(i) {
						set valid=1
					}
				}
			}
			if valid=0 {
				set res=nums(i)
				quit
			}
		}
	}

	// part 2 is to find string of numbers that = res
	for i=1:1:nums {
		set total=nums(i)
		for j=i+1:1:nums {
			set total=total+nums(j)
			if total=res {
				set min=res+1
				set max=0
				for k=i:1:j {
					if nums(k)<min {
						set min=nums(k)
					}
					if nums(k)>max {
						set max=nums(k)
					}
				}
				set res=min+max
				return res
			} elseif total>res {
				quit
			}
		}
	}

	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day9).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day9).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
