Class AOC.Y2019.Day18 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 18;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day18).GetInput(..#Day,.pInput)
	
	set res=""
	set posy=""
	set posx=""
	set pos=$o(pInput(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set tempchar=$e(l,i)
			set map(map,i-1)=tempchar
			if tempchar="@" {
				set posy=map
				set posx=i-1
			}
			if (($ascii(tempchar)>96)&&($ascii(tempchar)<123)) {
				set keys(tempchar)=$lb(map,i-1)
			}
			if (($ascii(tempchar)>64)&&($ascii(tempchar)<91)) {
				set doors(tempchar)=$lb(map,i-1)
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				set isdoor=(($ascii(map(tempy,tempx))>=65)&&($ascii(map(tempy,tempx))<=90))
				if 'isfree&&'isdoor {
					// if it isnt a . or a door, skip
					continue
				}
				set wallcount=0
				set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
				if wallcount>2 {
					set map(tempy,tempx)="#"
					set modified=1
					set modifiedcount=$i(modifiedcount)
				}
			}
		}
	}
	
	set map(posy,posx)="."
	set res=##class(AOC.Y2019.Day18).Fill(pDebug,.map,.keys,0,5000,$lb("@"),,$lb(posx,posy))
	
	quit res
}

ClassMethod Fill(pDebug, ByRef pMap, ByRef pKeys, pSteps, pMinSteps, pPath, ByRef pKeystrings, pQ1="", pQ2="", pQ3="", pQ4="") As %Integer
{
	Quit:pSteps>=pMinSteps pMinSteps
	merge tMap=pMap
	merge tKeys=pKeys
	
	set done=0
	set part2=0
	
	set sizey=$o(tMap(""),-1)
	set sizex=$o(tMap(sizey,""),-1)
	set sizey=$system.SQL.CEILING(sizey/2)
	set sizex=$system.SQL.CEILING(sizex/2)
	
	if pQ1'="" {
		set tMap($lg(pQ1,2),$lg(pQ1,1))="!"
	}
	if pQ2'="" {
		set part2=1
		set tMap($lg(pQ2,2),$lg(pQ2,1))="!"
	}
	if pQ3'="" {
		set tMap($lg(pQ3,2),$lg(pQ3,1))="!"
	}
	if pQ4'="" {
		set tMap($lg(pQ4,2),$lg(pQ4,1))="!"
	}
	
	merge tempMap=tMap
	
	while 'done {
		set done=1
		set tempsteps=$i(tempsteps)
		Quit:(pSteps+tempsteps)>=pMinSteps
		set row=$o(tMap(""))
		while row'="" {
			set col=$o(tMap(row,""))
			while col'="" {
				if tMap(row,col)="!" {
					for tempcheck=1,2,3,4 {
						if tempcheck=1 {
							set y=row-1
							set x=col
						} elseif tempcheck=2 {
							set y=row+1
							set x=col
						} elseif tempcheck=3 {
							set y=row
							set x=col-1
						} elseif tempcheck=4 {
							set y=row
							set x=col+1
						}
						
						if tMap(y,x)="." {
							set tempMap(y,x)="!"
							set done=0
						} elseif (($ascii(tMap(y,x))>=65)&&($ascii(tMap(y,x))<=90)) {
							//this is a door, if the key doesnt exist, set to #
							if '$d(tKeys($$$LOWER(tMap(y,x)))) {
								set tempMap(y,x)="!"
								set done=0
							}
						} elseif (($ascii(tMap(y,x))>=97)&&($ascii(tMap(y,x))<=122)) {
							// this is a key
							set tempkey=tMap(y,x)
							if part2 {
								if (tempkey="y")&&($d(tKeys("m"))) {
									quit
								}
							} else {
								if (tempkey="l")&&($d(tKeys("e"))||$d(tKeys("y"))||$d(tKeys("m"))) {
									quit
								}
							}
							set pPath=pPath_$lb(tMap(y,x))
							k tKeys(tempkey)
							if $d(tKeys)=0 {
								zw pPath
								zw pSteps+tempsteps
								return pSteps+tempsteps
							}
							
							
							set pMap(y,x)="."
							k keylist
							for i=1:1:26 {
								set $list(keylist,i)=$data(tKeys($char(i+96)))
							}
							set keystring=$lts(keylist,,1)
							if $G(pKeystrings(tempkey,keystring),5000)>(pSteps+tempsteps) {
								set pKeystrings(tempkey,keystring)=pSteps+tempsteps
								
								set tQ1=""
								set tQ2=""
								set tQ3=""
								set tQ4=""
								if part2 {
									set tQ1=pQ1
									set tQ2=pQ2
									set tQ3=pQ3
									set tQ4=pQ4
									if ((x<sizex)&&(y<sizey)) {
										set tQ1=$lb(x,y)
									} elseif ((x>sizex)&&(y<sizey)) {
										set tQ2=$lb(x,y)
									} elseif ((x>sizex)&&(y>sizey)) {
										set tQ3=$lb(x,y)
									} elseif ((x<sizex)&&(y>sizey)) {
										set tQ4=$lb(x,y)
									}  
								} else {
									set tQ1=$lb(x,y)
								}
								set tempres=##class(AOC.Y2019.Day18).Fill(pDebug,.pMap,.tKeys,pSteps+tempsteps,pMinSteps,pPath,.pKeystrings,tQ1,tQ2,tQ3,tQ4)
								set:tempres<pMinSteps pMinSteps=tempres
							}
							
							set pMap(y,x)=tempkey
							set tempMap(y,x)="#"
							set done=0
							
							
								
							//do ##class(AOC.Y2019).Print2DArray(.tMap)
							//break
								
							set tKeys(tempkey)=1
							set pPath=$list(pPath,1,*-1)
						}
					}
				}
				set col=$o(tMap(row,col))
			}
			set row=$o(tMap(row))
		}
		k tMap
		merge tMap=tempMap
	}
	
	quit pMinSteps
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day18).GetInput(..#Day,.pInput)
	
	set res=""
	set posy=""
	set posx=""
	set pos=$o(pInput(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set tempchar=$e(l,i)
			set map(map,i-1)=tempchar
			if tempchar="@" {
				set posy=map
				set posx=i-1
			}
			if (($ascii(tempchar)>96)&&($ascii(tempchar)<123)) {
				set keys(tempchar)=$lb(map,i-1)
			}
			if (($ascii(tempchar)>64)&&($ascii(tempchar)<91)) {
				set doors(tempchar)=$lb(map,i-1)
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				set isdoor=(($ascii(map(tempy,tempx))>=65)&&($ascii(map(tempy,tempx))<=90))
				if 'isfree&&'isdoor {
					// if it isnt a . or a door, skip
					continue
				}
				set wallcount=0
				set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
				if wallcount>2 {
					set map(tempy,tempx)="#"
					set modified=1
					set modifiedcount=$i(modifiedcount)
				}
			}
		}
	}
	
	if '$G(istest,0) {
		set map(posy+1,posx)="#"
		set map(posy-1,posx)="#"
		set map(posy,posx+1)="#"
		set map(posy,posx-1)="#"
		set map(posy,posx)="#"
		
		set map(posy+1,posx+1)="."
		set map(posy-1,posx+1)="."
		set map(posy+1,posx-1)="."
		set map(posy-1,posx-1)="."
	} else {
		set posy=$o(map(""),-1)
		set posx=$o(map(posy,""),-1)
		set posy=$system.SQL.CEILING(posy/2)
		set posx=$system.SQL.CEILING(posx/2)
		do ##class(AOC.Y2019.Day18).Print2DArray(.map,,posx,posy)
	}
	
	set res=##class(AOC.Y2019.Day18).Fill(pDebug,.map,.keys,0,5000,$lb("@"),,$lb(posx-1,posy-1),$lb(posx+1,posy-1),$lb(posx+1,posy+1),$lb(posx-1,posy+1))
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day18).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day18).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
