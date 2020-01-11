Class AOC.Utils.Graph Extends %RegisteredObject
{

Property Vertices [ MultiDimensional ];

Property Edges [ MultiDimensional ];

Property ShortestDistances [ MultiDimensional ];

Method AddVertex(pName = "", pValue = "") As %Status
{
	Set tSC=$$$OK
	
	If pName="" {
		Set tSC=$$$ERROR("Vertex name cannot be empty")
	} ElseIf $Data(..Vertices(pName)) {
		Set tSC=$$$ERROR("Vertex name must be unique")
	} Else {
		Set ..Vertices(pName)=pValue
	}
	
	Quit tSC
}

Method RemoveVertex(pName = "") As %Status
{
	Set tSC=$$$OK
	
	Set tEdge=$o(..Edges(pName,""))
	While tEdge'="" {
		Do ..RemoveEdge(pName,tEdge)
		Set tEdge=$o(..Edges(pName,tEdge))
	}
	
	Kill ..Vertices(pName)
	
	Quit tSC
}

Method AddEdge(pVertex1 = "", pVertex2 = "", pDistance = 0) As %Status
{
	Set tSC=$$$OK
	
	Set ..Edges(pVertex1,pVertex2)=pDistance
	Set ..Edges(pVertex2,pVertex1)=pDistance
	
	Quit tSC
}

Method RemoveEdge(pVertex1, pVertex2) As %Status
{
	Set tSC=$$$OK
	
	Kill ..Edges(pVertex1,pVertex2)
	Kill ..Edges(pVertex2,pVertex1)
	
	Quit tSC
}

Method GetDistance(pVertex1, pVertex2) As %Integer
{
	Set tRes=""
	If '$Data(..Edges(pVertex1,pVertex2)) {
		$$$ThrowStatus($$$ERROR($$$GeneralError,"No Edge from "_pVertex1_" to "_pVertex2))
	}
	Quit ..Edges(pVertex1,pVertex2)
}

Method ShortestDistance(pVertex1, pVertex2) As %Integer
{
	Quit:$Data(..ShortestDistances(pVertex1,pVertex2)) ..ShortestDistances(pVertex1,pVertex2)
	
	Set tRes=1E18
	Set tCurrentVertex=pVertex1
	Set tLastDistance=0
	Set tTempGraph(pVertex1)=0
	
	While 1 {
		Set tVertex=$o(..Edges(tCurrentVertex,""))
		While tVertex'="" {
			If '$Data(tTempGraph(tVertex)) {
				Set tTempGraph(tVertex)=..Edges(tCurrentVertex,tVertex)+tLastDistance
			}
			Set tVertex=$o(..Edges(tCurrentVertex,tVertex))
		}
		
		If $Data(tTempGraph(pVertex2)) {
			Set tRes=tTempGraph(pVertex2)
			Set ..ShortestDistances(pVertex1,pVertex2)=tRes
			Set ..ShortestDistances(pVertex2,pVertex1)=tRes
			Quit
		}
		
		Set tShortestVertexName=""
		Set tShortestVertexDistance=1E18
		Set tVertex=$o(tTempGraph(""))
		While tVertex'="" {
			If (tTempGraph(tVertex)<tShortestVertexDistance)&&('$Data(tShortestGraph(tVertex))) {
				Set tShortestVertexDistance=tTempGraph(tVertex)
				Set tShortestVertexName=tVertex
			}
			Set tVertex=$o(tTempGraph(tVertex))
		}
		
		Set tShortestGraph(tShortestVertexName)=tShortestVertexDistance
		Set ..ShortestDistances(pVertex1,tShortestVertexName)=tShortestVertexDistance
		Set ..ShortestDistances(tShortestVertexName,pVertex1)=tShortestVertexDistance
		
		Set tLastDistance=tShortestVertexDistance
		Set tCurrentVertex=tShortestVertexName
	}
	
	Quit tRes
}

Method ComputeAllShortestDistances() As %Status
{
	Set tSC=$$$OK
	
	Set tVertices=..GetListOfVertices()
	For tPos=1:1:$LL(tVertices)-1 {
		For tPos2=tPos+1:1:$LL(tVertices) {
			Do ..ShortestDistance($LG(tVertices,tPos),$LG(tVertices,tPos2))
		}
	}
	
	Quit tSC
}

Method ShortestTraverse() As %Integer
{
	Set tRes=1E18
	
	Set tRoute=""
	Set tVertices=..GetListOfVertices()
	For tVertex=1:1:$Listlength(tVertices) {
		For tTempVertex=1:1:$Listlength(tVertices) {
			Set tUnvisited($LG(tVertices,tTempVertex))=1
		}
		Set tDistance=0
		Set tVertexName=$LG(tVertices,tVertex)
		Set tRoute=$LB(tVertexName)
		Set tNextVertex=$O(..Edges(tVertexName,""))
		While tNextVertex'="" {
			While tNextVertex'="" {
				While ((tNextVertex'="")&&($listfind(tRoute,tNextVertex)>0)) {
					Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
				}
				If tNextVertex="" {
					Quit
				}
				If tDistance>tRes {
					Set tNextVertex=""
					Quit
				}
				
				Set tDistance=tDistance+..ShortestDistance(tVertexName,tNextVertex)
				Set tVertexName=tNextVertex
				Set tNextVertex=""
				Set tRoute=tRoute_$LB(tVertexName)
				
				If $LL(tRoute)=$LL(tVertices) {
					If tRes>tDistance {
						Set tRes=tDistance
					}
				}
				
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
			// Roll back last move and try next
			While ((tNextVertex="")&&($Listlength(tRoute)>1)) {
				Set tNextVertex=$List(tRoute,*)
				Set tRoute=$List(tRoute,1,*-1)
				Set tVertexName=$List(tRoute,*)
				Set tDistance=tDistance-..ShortestDistance(tVertexName,tNextVertex)
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
		}
	}

	Quit tRes
}

Method LongestTraverse() As %Integer
{
	Set tRes=0
	
	Set tRoute=""
	Set tVertices=..GetListOfVertices()
	For tVertex=1:1:$Listlength(tVertices) {
		For tTempVertex=1:1:$Listlength(tVertices) {
			Set tUnvisited($LG(tVertices,tTempVertex))=1
		}
		Set tDistance=0
		Set tVertexName=$LG(tVertices,tVertex)
		Set tRoute=$LB(tVertexName)
		Set tNextVertex=$O(..Edges(tVertexName,""))
		While tNextVertex'="" {
			While tNextVertex'="" {
				While ((tNextVertex'="")&&($listfind(tRoute,tNextVertex)>0)) {
					Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
				}
				If tNextVertex="" {
					Quit
				}
				
				Set tDistance=tDistance+..ShortestDistance(tVertexName,tNextVertex)
				Set tVertexName=tNextVertex
				Set tNextVertex=""
				Set tRoute=tRoute_$LB(tVertexName)
				
				If $LL(tRoute)=$LL(tVertices) {
					If tRes<tDistance {
						Set tRes=tDistance
					}
				}
				
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
			// Roll back last move and try next
			While ((tNextVertex="")&&($Listlength(tRoute)>1)) {
				Set tNextVertex=$List(tRoute,*)
				Set tRoute=$List(tRoute,1,*-1)
				Set tVertexName=$List(tRoute,*)
				Set tDistance=tDistance-..ShortestDistance(tVertexName,tNextVertex)
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
		}
	}

	Quit tRes
}

Method LongestCycle() As %Integer
{
	Set tRes=0
	
	Set tRoute=""
	Set tVertices=..GetListOfVertices()
	For tVertex=1:1:$Listlength(tVertices) {
		Set tDistance=0
		Set tVertexName=$LG(tVertices,tVertex)
		Set tStartVertex=tVertexName
		Set tRoute=$LB(tVertexName)
		Set tNextVertex=$O(..Edges(tVertexName,""))
		While tNextVertex'="" {
			While tNextVertex'="" {
				Set tNextIsStart=(tNextVertex=tStartVertex)
				While ((tNextVertex'="")&&(('tNextIsStart&&(##class(AOC.Utils.Utils).ListCount(tRoute,tNextVertex)>tNextIsStart))||(tNextIsStart&&($LL(tRoute)'=($LL(tVertices)))))) {
					Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
					Set tNextIsStart=(tNextVertex=tStartVertex)
				}
				If tNextVertex="" {
					Quit
				}
				
				Set tDistance=tDistance+..GetDistance(tVertexName,tNextVertex)
				Set tVertexName=tNextVertex
				Set tNextVertex=""
				Set tRoute=tRoute_$LB(tVertexName)
				
				If $LL(tRoute)=$LL(tVertices)+1 {
					If tRes<tDistance {
						Set tRes=tDistance
					}
				}
				
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
			// Roll back last move and try next
			While ((tNextVertex="")&&($Listlength(tRoute)>1)) {
				Set tNextVertex=$List(tRoute,*)
				Set tRoute=$List(tRoute,1,*-1)
				Set tVertexName=$List(tRoute,*)
				Set tDistance=tDistance-..GetDistance(tVertexName,tNextVertex)
				Set tNextVertex=$O(..Edges(tVertexName,tNextVertex))
			}
		}
	}

	Quit tRes
}

Method GetListOfVertices() As %List
{
	Set tRes=""
	
	Set tVertex=$o(..Vertices(""))
	While tVertex'="" {
		Set tRes=tRes_$lb(tVertex)
		Set tVertex=$o(..Vertices(tVertex))
	}
	
	Quit tRes
}

}
