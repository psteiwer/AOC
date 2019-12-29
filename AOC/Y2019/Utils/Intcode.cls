Class AOC.Y2019.Utils.Intcode Extends %RegisteredObject
{

Property Instructions As %List;

Property Position As %Integer [ InitialExpression = -1 ];

Property RelativeBase As %Integer [ InitialExpression = 0 ];

Property Input As %List;

Property Output As %List;

Property Paused As %Boolean [ InitialExpression = 0 ];

Property Finished As %Boolean [ InitialExpression = 0 ];

Method %OnNew(pDay,ByRef pInput="") As %Status
{
	Set tSC=$$$OK
	
	Set tSC=..LoadInstructions(pDay,.pInput)
	
	Quit tSC
}

Method LoadInstructions(pDay,ByRef pInput="") As %Status
{
	Set tSC=$$$OK
	
	If pInput="" {
		Do ##class(AOC.Y2019).GetInput(pDay,.pInput)
	}
	
	Set tPos=$o(pInput(""),1,tLine)
	Set tMaxlen=0
	While tPos'="" {
		Set tMaxlen=$l(tLine,",")
		For i=0:1:$l(tLine,",")-1 {
			Do ..SetInstruction($p(tLine,",",i+1))
		}
		Set tPos=$o(pInput(tPos),1,l)
	}
	
	Quit tSC
}

Method Run(debug=0,pPauseOnOutput=0) As %Status
{
	Set tSC=$$$OK
	Set ..Paused=0
	While '..Paused {
		Set tInst=..GetInstruction()
		quit:tInst=99
		set tMode1=+$e($replace($j(tInst#100000,5)," ",0),3)
		set tMode2=+$e($replace($j(tInst#100000,5)," ",0),2)
		set tMode3=+$e($replace($j(tInst#100000,5)," ",0),1)
		set tInst=tInst#100
		// ??? inst=4
		zw:debug tInst
		zw:debug tMode1
		zw:debug ..RelativeBase
		zw:debug ..Position
		break:debug
		if tMode1=2 {
			set offset=0
			set offset=..RelativeBase
			if (tInst=3) {
				//set val1=$g(..Instructions($i(..Position)),0)+offset
				set val1=..GetInstruction()+offset
			} else {
				//set val1=$g(..Instructions($g(..Instructions($i(..Position)),0)+offset),0)
				set val1=..GetInstruction(..GetInstruction()+offset)
			}	
		} elseif ((tMode1) || (tInst=3) || (tInst=4)) {
			//set val1=$g(..Instructions($i(..Position)),0)
			set val1=..GetInstruction()
		} else {
			//set val1=$g(..Instructions($g(..Instructions($i(..Position)))),0)
			set val1=..GetInstruction(..GetInstruction())
		}
		zw:debug val1
		if ((tInst=1) || (tInst=2) || (tInst=5) || (tInst=6) || (tInst=7) || (tInst=8)) {
			if tMode2=2 {
				set offset=0
				set offset=..RelativeBase
				//set val2=$g(..Instructions($g(..Instructions($i(..Position)),0)+offset),0)
				set val2=..GetInstruction(..GetInstruction()+offset)
			} elseif tMode2 {
				//set val2=$g(..Instructions($i(..Position)),0)
				set val2=..GetInstruction()
			} else {
				//set val2=$g(..Instructions($g(..Instructions($i(..Position)),0)),0)
				set val2=..GetInstruction(..GetInstruction())
			}
			zw:debug val2
			if ((tInst=1) || (tInst=2) || (tInst=7) || (tInst=8)) {
				if tMode3=2 {
					set offset=0
					set offset=..RelativeBase
					//set storeloc=$g(..Instructions($i(..Position)),0)+offset
					set storeloc=..GetInstruction()+offset
				} elseif (tMode3) {
					//set storeloc=$g(..Instructions($i(..Position)),0)
					set storeloc=..GetInstruction()
				} else {
					// ???
					//set storeloc=$g(..Instructions($i(..Position)),0)
					set storeloc=..GetInstruction()
				}
				zw:debug storeloc
			}
		}
		if tInst=1 {
			Do ..SetInstruction(val1+val2,storeloc)
		} elseif tInst=2 {
			Do ..SetInstruction(val1*val2,storeloc)
		} elseif tInst=3 {
			Do ..SetInstruction(..GetInput(),val1)
		} elseif tInst=4 {
			if tMode1 {
				set res=val1
			} else {
				set res=..GetInstruction(val1)
			}
			w:debug res,!
			d ..AddOutput(res)
			Set:pPauseOnOutput ..Paused=1
		} elseif tInst=5 {
			if val1'=0 {
				set ..Position=val2-1
			}
		} elseif tInst=6 {
			if val1=0 {
				set ..Position=val2-1
			}
		} elseif tInst=7 {
			if val1<val2 {
				Do ..SetInstruction(1,storeloc)
			} else {
				Do ..SetInstruction(0,storeloc)
			}
		} elseif tInst=8 {
			if val1=val2 {
				Do ..SetInstruction(1,storeloc)
			} else {
				Do ..SetInstruction(0,storeloc)
			}
		} elseif tInst=9 {
			set ..RelativeBase=..RelativeBase+val1
		}
	}
	
	If '..Paused {
		Set ..Finished=1
	}
	
	Quit tSC
}

Method GetInstruction(pPosition=-1) As %String
{
	If pPosition=-1 {
		Set ..Position=..Position+1
		Set tInstruction=$LG(..Instructions,..Position+1)
	} Else {
		Set tInstruction=$LG(..Instructions,pPosition+1)
	}
	
	Quit tInstruction
}

Method SetInstruction(pValue,pPosition=-1) As %Status
{
	Set tSC=$$$OK
	
	If pPosition=-1 {
		Set ..Instructions=..Instructions_$LB(pValue)
	} Else {
		Set tList=..Instructions
		Set $List(tList,pPosition+1)=pValue
		Set ..Instructions=tList
	}
	
	Quit tSC
}

Method GetInput() As %String
{
	Set tRes=$LG(..Input,1,-1)
	Set ..Input=$List(..Input,2,*)
	
	Quit tRes
}

Method AddInput(pValue) As %Status
{
	Set tSC=$$$OK
	
	Set ..Input=..Input_$LB(pValue)
	
	Quit tSC
}

Method GetOutput() As %String
{
	Set tRes=$LG(..Output,1,"")
	Set ..Output=$List(..Output,2,*)
	
	Quit tRes
}

Method AddOutput(pValue) As %Status
{
	Set tSC=$$$OK
	
	Set ..Output=..Output_$LB(pValue)
	
	Quit tSC
}

}