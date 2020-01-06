Class AOC.Y2019.Day14 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 14;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day14).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day14).ParseString(l,"=>",.a,.b)
		set a=$lfs(a)
		set tempb=$zstrip(b,"<>W")
		set tempbamount=$p(tempb," ",1)
		set tempbmat=$p(tempb," ",2)
		set materials(tempbmat)=tempbamount
		for i=1:1:$ll(a) {
			set tempa=$zstrip($lg(a,i),"<>W")
			set tempaamount=$p(tempa," ",1)
			set tempamat=$p(tempa," ",2)
			set materials(tempbmat,tempamat)=tempaamount
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	zw:pDebug materials
	
	set noupdates=0
	set resources("FUEL")=1
	while 'noupdates {
		set noupdates=1
		set resource=$o(resources(""))
		while resource'="" {
			set tempresourceval=$G(resources(resource))
			set val=$G(materials(resource))
			set multiplier=0
			set:val>0 multiplier=$SYSTEM.SQL.CEILING(tempresourceval/val)
			//zw tempresource
			if resource'="ORE" {
				set tempresource=$o(materials(resource,""))
				while tempresource'="" {
					set val2=materials(resource,tempresource)
					set newresources(tempresource)=val2*multiplier
					
					set tempresource=$o(materials(resource,tempresource))
				}
			}
			zw:pDebug resources
			zw:pDebug newresources
			zw:pDebug resource
			zw:pDebug multiplier
			if multiplier>0 {
				set noupdates=0
				set resources(resource)=$i(resources(resource),-materials(resource)*multiplier)
			}
			set tempresource=$o(newresources(""))
			while tempresource'="" {
				set resources(tempresource)=$i(resources(tempresource),newresources(tempresource))
				
				set tempresource=$o(newresources(tempresource))
			}
			zw:pDebug resources
			
			k newresources
			
			set resource=$o(resources(resource))
		}
	}
	
	zw:pDebug resources
	
	
	quit resources("ORE")
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day14).GetInput(..#Day,.pInput)
	set fuelbase=##class(AOC.Y2019.Day14).Part1(.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day14).ParseString(l,"=>",.a,.b)
		set a=$lfs(a)
		set tempb=$zstrip(b,"<>W")
		set tempbamount=$p(tempb," ",1)
		set tempbmat=$p(tempb," ",2)
		set materials(tempbmat)=tempbamount
		for i=1:1:$ll(a) {
			set tempa=$zstrip($lg(a,i),"<>W")
			set tempaamount=$p(tempa," ",1)
			set tempamat=$p(tempa," ",2)
			set materials(tempbmat,tempamat)=tempaamount
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set done=0
	set min=0
	set max=1000000000000
	set fueltest=1000000000000
	while 'done {
		set res=$i(res)
		set noupdates=0
		k resources
		set resources("FUEL")=fueltest
		while 'noupdates {
			set noupdates=1
			set resource=$o(resources(""))
			while resource'="" {
				set tempresourceval=$G(resources(resource))
				set val=$G(materials(resource))
				set multiplier=0
				set:val>0 multiplier=$SYSTEM.SQL.CEILING(tempresourceval/val)
				//zw tempresource
				if resource'="ORE" {
					set tempresource=$o(materials(resource,""))
					while tempresource'="" {
						set val2=materials(resource,tempresource)
						set newresources(tempresource)=val2*multiplier
						
						set tempresource=$o(materials(resource,tempresource))
					}
				}
				if multiplier>0 {
					set noupdates=0
					set resources(resource)=$i(resources(resource),-materials(resource)*multiplier)
				}
				set tempresource=$o(newresources(""))
				while tempresource'="" {
					set resources(tempresource)=$i(resources(tempresource),newresources(tempresource))
					
					set tempresource=$o(newresources(tempresource))
				}
				
				k newresources
				
				set resource=$o(resources(resource))
			}
		}
		
		if $g(resources("ORE"))<1000000000000 {
			if ($g(resources("ORE"))+fuelbase)>1000000000000 {
				set res=fueltest
				set done=1
				quit
			}
			zw:pDebug fueltest
			w:pDebug "too low",!
			set min=fueltest
			//break
			set fueltest=(((max-min)*.5)\1)+min
		} else {
			if ($g(resources("ORE"))-fuelbase)<1000000000000 {
				set res=fueltest-1
				set done=1
				quit
			}
			zw:pDebug fueltest
			w:pDebug "too high",!
			set max=fueltest
			//break
			set fueltest=fueltest-((max-min)\2)
		}
	}
	
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day14).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day14).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
