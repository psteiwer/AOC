Class AOC.Y2019.Day20 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 20;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day20).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				if isfree {
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
	}
	
	do:pDebug ##class(AOC.Y2019).Print2DArray(.map)
	
	// find all paths
	set tempy=$o(map(0))
	while tempy'="" {
		set tempx=$o(map(tempy,0))
		while tempx'="" {
			if map(tempy,tempx)'="." {
				set tempx=$o(map(tempy,tempx))
				continue
			}
			set isend=0
			set:(map(tempy+1,tempx)'="#")&&(map(tempy+1,tempx)'=".") isend=1
			set:(map(tempy-1,tempx)'="#")&&(map(tempy-1,tempx)'=".") isend=2
			set:(map(tempy,tempx+1)'="#")&&(map(tempy,tempx+1)'=".") isend=3
			set:(map(tempy,tempx-1)'="#")&&(map(tempy,tempx-1)'=".") isend=4
			if isend=1 {
				set pathname=map(tempy+1,tempx)_map(tempy+2,tempx)
				set map(tempy+1,tempx)="#"
			} elseif isend=2 {
				set pathname=map(tempy-2,tempx)_map(tempy-1,tempx)
				set map(tempy-1,tempx)="#"
			} elseif isend=3 {
				set pathname=map(tempy,tempx+1)_map(tempy,tempx+2)
				set map(tempy,tempx+1)="#"
			} elseif isend=4 {
				set pathname=map(tempy,tempx-2)_map(tempy,tempx-1)
				set map(tempy,tempx-1)="#"
			}
			if isend {
				// if wall count is not >2, we will come back to this.
				set tempy2=tempy
				set tempx2=tempx
				set path=""
				set isout=0
				while 'isout {
					set wallcount=0
					set tempmovey=tempy2
					set tempmovex=tempx2
					//set tempdir=""
					set tempval=map(tempy2,tempx2)
					
					if tempval="." {
						if map(tempy2+1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2+1
							set tempmovex=tempx2
							set tempdir="D"
						}
						if map(tempy2-1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2-1
							set tempmovex=tempx2
							set tempdir="U"
						}
						if map(tempy2,tempx2+1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2+1
							set tempdir="R"
						}
						if map(tempy2,tempx2-1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2-1
							set tempdir="L"
						}
					}
					
					if ((wallcount=3)||(wallcount=4)) {
						set path=path_tempdir
						set map(tempy2,tempx2)="#"
						set tempy2=tempmovey
						set tempx2=tempmovex
						if $d(pathsplit(tempy2,tempx2)) {
							set isend=-1
							set tempval=pathsplit(tempy2,tempx2)
							set paths(pathname)=path
							set newpath=tempval_pathname
							zw:pDebug tempval
							zw:pDebug pathname
							zw:pDebug newpath
							//store current path, start logging new path
							set links(pathname,newpath)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,pathname)=invertpath
							
							set path=paths(pathsplit(tempy2,tempx2))
							set links(tempval,newpath)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(tempval)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,tempval)=invertpath
							set path=""
							set pathname=tempval_pathname
						}
					} else {
						set isout=1
						if tempdir="U" {
							set tempval=map(tempy2-1,tempx2)_map(tempy2,tempx2)
						} elseif tempdir="D" {
							set tempval=map(tempy2,tempx2)_map(tempy2+1,tempx2)
						} elseif tempdir="L" {
							set tempval=map(tempy2,tempx2-1)_map(tempy2,tempx2)
						} elseif tempdir="R" {
							set tempval=map(tempy2,tempx2)_map(tempy2,tempx2+1)
						}
						set paths(pathname)=path
						if ((tempval[".")||(tempval["#")) {
							set pathsplit(tempy2,tempx2)=pathname
						} else {
							set links(pathname,tempval)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set:i'=$length(path) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(tempval,pathname)=invertpath
							
						}
						set tempy=0
						set tempx=0
					}
				}
			}
			quit:tempx=0
			set tempx=$o(map(tempy,tempx))
		}
		set tempy=$o(map(tempy))
	}
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	set currentpath="AA"
	set nextpath=$o(links(currentpath,""))
	set steps=$length(links(currentpath,nextpath))
	set path=$lb("AA",nextpath)
	set minsteps=3000
	set res=##class(AOC.Y2019.Day20).Move(pDebug,.map,.paths,.links,nextpath,path,steps,minsteps)
	
	quit res
}
ClassMethod Move(pDebug, ByRef pMap, ByRef pPaths, ByRef pLinks, pCurrentPath, pPath, pSteps, pMinSteps, pDay=1, pLevel=0, ByRef pLevels) As %Integer
{
	Quit:pLevel<0 pMinSteps
	Quit:pSteps>pMinSteps pSteps
	
	set nextpath=$o(pLinks(pCurrentPath,""))
	while nextpath'="" {
		if (nextpath'=$lg(pPath,*-1)) {
			set pSteps=pSteps+$length(pLinks(pCurrentPath,nextpath))
			set pPath=pPath_$lb(nextpath)
			if ((nextpath="ZZ")&&(pLevel=0)) {
				//break:pDebug
				zw:pDebug pCurrentPath
				zw:pDebug pPath
				zw:pDebug pSteps
				zw:pDebug pMinSteps
				return pSteps-1
			} else {
				if ((pDay=2)&&($length(nextpath)=2)) {
					set pLevel=pLevel+pLevels(pCurrentPath,nextpath)
					if pLevel<-1 {
						zw pLevel
						break
					}
				}
				set temp=##class(AOC.Y2019.Day20).Move(pDebug,.pMap,.pPaths,.pLinks,nextpath,pPath,pSteps,pMinSteps,pDay,pLevel,.pLevels)
				if ((temp=489)&&(pMinSteps'=temp)) {
					zw pPath
					zw pLevel
					break
				}
				set:temp<pMinSteps pMinSteps=temp
				if ((pDay=2)&&($length(nextpath)=2)) {
					set pLevel=pLevel-pLevels(pCurrentPath,nextpath)
				}
			}
			set pSteps=pSteps-$length(pLinks(pCurrentPath,nextpath))
			set pPath=$list(pPath,1,*-1)
		}
		
		set nextpath=$o(pLinks(pCurrentPath,nextpath))
	}
	
	Quit pMinSteps
}


ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day20).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set map=-1
	set maxx=0
	set maxy=0
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
			set:maxx<i maxx=i
		}
		set:maxy<map maxy=map
		set pos=$o(pInput(pos),1,l)
	}
	set maxx=maxx/2
	set maxy=maxy/2
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				if isfree {
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
	}
	
	do:pDebug ##class(AOC.Y2019).Print2DArray(.map)
	
	// find all paths
	set tempy=$o(map(0))
	while tempy'="" {
		set tempx=$o(map(tempy,0))
		while tempx'="" {
			if map(tempy,tempx)'="." {
				set tempx=$o(map(tempy,tempx))
				continue
			}
			set startx=tempx
			set starty=tempy
			set isend=0
			set:(map(tempy+1,tempx)'="#")&&(map(tempy+1,tempx)'=".") isend=1
			set:(map(tempy-1,tempx)'="#")&&(map(tempy-1,tempx)'=".") isend=2
			set:(map(tempy,tempx+1)'="#")&&(map(tempy,tempx+1)'=".") isend=3
			set:(map(tempy,tempx-1)'="#")&&(map(tempy,tempx-1)'=".") isend=4
			if isend=1 {
				set pathname=map(tempy+1,tempx)_map(tempy+2,tempx)
				set map(tempy+1,tempx)="#"
			} elseif isend=2 {
				set pathname=map(tempy-2,tempx)_map(tempy-1,tempx)
				set map(tempy-1,tempx)="#"
			} elseif isend=3 {
				set pathname=map(tempy,tempx+1)_map(tempy,tempx+2)
				set map(tempy,tempx+1)="#"
			} elseif isend=4 {
				set pathname=map(tempy,tempx-2)_map(tempy,tempx-1)
				set map(tempy,tempx-1)="#"
			}
			if isend {
				// if wall count is not >2, we will come back to this.
				set tempy2=tempy
				set tempx2=tempx
				set path=""
				set isout=0
				while 'isout {
					set wallcount=0
					set tempmovey=tempy2
					set tempmovex=tempx2
					//set tempdir=""
					set tempval=map(tempy2,tempx2)
					
					if tempval="." {
						if map(tempy2+1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2+1
							set tempmovex=tempx2
							set tempdir="D"
							set leveldir=$case(tempy2<maxy,1:+1,:-1)
						}
						if map(tempy2-1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2-1
							set tempmovex=tempx2
							set tempdir="U"
							set leveldir=$case(tempy2<maxy,1:-1,:+1)
						}
						if map(tempy2,tempx2+1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2+1
							set tempdir="R"
							set leveldir=$case(tempx2<maxx,1:+1,:-1)
						}
						if map(tempy2,tempx2-1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2-1
							set tempdir="L"
							set leveldir=$case(tempx2<maxx,1:-1,:+1)
						}
					}
					
					if ((wallcount=3)||(wallcount=4)) {
						set path=path_tempdir
						set map(tempy2,tempx2)="#"
						set tempy2=tempmovey
						set tempx2=tempmovex
						if $d(pathsplit(tempy2,tempx2)) {
							set isend=-1
							set tempval=pathsplit(tempy2,tempx2)
							set paths(pathname)=path
							set pathend=$e(path,*)
							set newpath=tempval_pathname
							//store current path, start logging new path
							set links(pathname,newpath)=path
							set levels(pathname,newpath)=leveldir
							set leveldir=$e(path,*)
							if leveldir="U" {
								set leveldir=$case(tempy2<maxy,1:-1,:+1)
							} elseif leveldir="D" {
								set leveldir=$case(tempy2<maxy,1:+1,:-1)
							} elseif leveldir="L" {
								set leveldir=$case(tempx2<maxx,1:-1,:+1)
							} elseif leveldir="R" {
								set leveldir=$case(tempx2<maxx,1:+1,:-1)
							}
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,pathname)=invertpath
							set levels(newpath,pathname)=-leveldir
							set path=paths(pathsplit(tempy2,tempx2))
							set links(tempval,newpath)=path
							set leveldir=$e(path,1)
							if leveldir="U" {
								set leveldir=$case(tempy2<maxy,1:-1,:+1)
							} elseif leveldir="D" {
								set leveldir=$case(tempy2<maxy,1:+1,:-1)
							} elseif leveldir="L" {
								set leveldir=$case(tempx2<maxx,1:-1,:+1)
							} elseif leveldir="R" {
								set leveldir=$case(tempx2<maxx,1:+1,:-1)
							}
							set levels(tempval,newpath)=leveldir
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(tempval)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,tempval)=invertpath
							set levels(newpath,tempval)=-leveldir
							set path=""
							set pathname=tempval_pathname
						}
					} else {
						set isout=1
						if tempdir="U" {
							set tempval=map(tempy2-1,tempx2)_map(tempy2,tempx2)
						} elseif tempdir="D" {
							set tempval=map(tempy2,tempx2)_map(tempy2+1,tempx2)
						} elseif tempdir="L" {
							set tempval=map(tempy2,tempx2-1)_map(tempy2,tempx2)
						} elseif tempdir="R" {
							set tempval=map(tempy2,tempx2)_map(tempy2,tempx2+1)
						}
						set paths(pathname)=path
						if ((tempval[".")||(tempval["#")) {
							set pathsplit(tempy2,tempx2)=pathname
							set pathsplit(tempy2,tempx2,"startx")=startx
							set pathsplit(tempy2,tempx2,"starty")=starty
						} else {
							set links(pathname,tempval)=path
							set levels(pathname,tempval)=leveldir
							set invertpath=""
							for i=$length(path):-1:1 {
								set:i'=$length(path) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(tempval,pathname)=invertpath
							set levels(tempval,pathname)=-leveldir
							
						}
						set tempy=0
						set tempx=0
					}
				}
			}
			quit:tempx=0
			set tempx=$o(map(tempy,tempx))
		}
		set tempy=$o(map(tempy))
	}
	
	set currentpath="AA"
	set nextpath=$o(links(currentpath,""))
	set steps=$length(links(currentpath,nextpath))
	set path=$lb("AA",nextpath)
	set minsteps=7000
	set res=##class(AOC.Y2019.Day20).Move(pDebug,.map,.paths,.links,nextpath,path,steps,minsteps,2,0,.levels)
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day20).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day20).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
