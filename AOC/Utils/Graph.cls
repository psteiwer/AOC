Class AOC.Utils.Graph Extends %RegisteredObject
{

Property Nodes [ MultiDimensional ];

Property Edges [ MultiDimensional ];

Method AddNode(pName="",pValue="") As %Status
{
	Set tSC=$$$OK
	
	If pName="" {
		Set tSC=$$$ERROR("Node name cannot be empty")
	} ElseIf $Data(..Nodes(pName)) {
		Set tSC=$$$ERROR("Node name must be unique")
	} Else {
		Set ..Nodes(pName)=pValue
	}
	
	Quit tSC
}

Method RemoveNode(pName="") As %Status
{
	Set tSC=$$$OK
	
	Set tEdge=$o(..Edges(pName,""))
	While tEdge'="" {
		Do ..RemoveEdge(pName,tEdge)
		Set tEdge=$o(..Edges(pName,tEdge))
	}
	
	Quit tSC
}

Method AddEdge(pNode1="", pNode2="", pDistance=0) As %Status
{
	Set tSC=$$$OK
	
	Set ..Edges(pNode1,pNode2)=pDistance
	Set ..Edges(pNode2,pNode1)=pDistance
	
	Quit tSC
}

Method RemoveEdge(pNode1, pNode2) As %Status
{
	Set tSC=$$$OK
	
	Kill ..Edges(pNode1,pNode2)
	Kill ..Edges(pNode2,pNode1)
	
	Quit tSC
}

}