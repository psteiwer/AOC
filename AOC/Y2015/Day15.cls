Class AOC.Y2015.Day15 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 15;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day15).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day15).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,": capacity ",.item,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", durability ",.capacity,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", flavor ",.durability,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", texture ",.flavor,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", calories ",.texture,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,,.calories,.l)

		set items(item)=$lb(capacity,durability,flavor,texture,calories)
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=100:-1:0 {
		for j=100-i:-1:0 {
			for k=100-i-j:-1:0 {
				for l=100-i-j-k:-1:0 {
					set tcapacity=($lg(items("Sugar"),1)*i)+($lg(items("Sprinkles"),1)*j)+($lg(items("Candy"),1)*k)+($lg(items("Chocolate"),1)*l)
					set tdurability=($lg(items("Sugar"),2)*i)+($lg(items("Sprinkles"),2)*j)+($lg(items("Candy"),2)*k)+($lg(items("Chocolate"),2)*l)
					set tflavor=($lg(items("Sugar"),3)*i)+($lg(items("Sprinkles"),3)*j)+($lg(items("Candy"),3)*k)+($lg(items("Chocolate"),3)*l)
					set ttexture=($lg(items("Sugar"),4)*i)+($lg(items("Sprinkles"),4)*j)+($lg(items("Candy"),4)*k)+($lg(items("Chocolate"),4)*l)
					set tcalories=($lg(items("Sugar"),5)*i)+($lg(items("Sprinkles"),5)*j)+($lg(items("Candy"),5)*k)+($lg(items("Chocolate"),5)*l)

					set:tcapacity<0 tcapacity=0
					set:tdurability<0 tdurability=0
					set:tflavor<0 tflavor=0
					set:ttexture<0 ttexture=0
					set:tcalories<0 tcalories=0

					set ttotal=tcapacity*tdurability*tflavor*ttexture
					set:ttotal>res res=ttotal
				}
			}
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day15).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day15).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,": capacity ",.item,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", durability ",.capacity,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", flavor ",.durability,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", texture ",.flavor,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,", calories ",.texture,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l,,.calories,.l)

		set items(item)=$lb(capacity,durability,flavor,texture,calories)
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=100:-1:0 {
		for j=100-i:-1:0 {
			for k=100-i-j:-1:0 {
				for l=100-i-j-k:-1:0 {
					set tcalories=($lg(items("Sugar"),5)*i)+($lg(items("Sprinkles"),5)*j)+($lg(items("Candy"),5)*k)+($lg(items("Chocolate"),5)*l)
					continue:tcalories'=500
					set tcapacity=($lg(items("Sugar"),1)*i)+($lg(items("Sprinkles"),1)*j)+($lg(items("Candy"),1)*k)+($lg(items("Chocolate"),1)*l)
					set tdurability=($lg(items("Sugar"),2)*i)+($lg(items("Sprinkles"),2)*j)+($lg(items("Candy"),2)*k)+($lg(items("Chocolate"),2)*l)
					set tflavor=($lg(items("Sugar"),3)*i)+($lg(items("Sprinkles"),3)*j)+($lg(items("Candy"),3)*k)+($lg(items("Chocolate"),3)*l)
					set ttexture=($lg(items("Sugar"),4)*i)+($lg(items("Sprinkles"),4)*j)+($lg(items("Candy"),4)*k)+($lg(items("Chocolate"),4)*l)
					
					set:tcapacity<0 tcapacity=0
					set:tdurability<0 tdurability=0
					set:tflavor<0 tflavor=0
					set:ttexture<0 ttexture=0
					set:tcalories<0 tcalories=0

					set ttotal=tcapacity*tdurability*tflavor*ttexture
					set:ttotal>res res=ttotal
				}
			}
		}
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day15).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day15).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
