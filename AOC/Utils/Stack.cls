Class AOC.Utils.Stack Extends %RegisteredObject
{

Property Stack [ MultiDimensional ];

Property Level As %Integer [ InitialExpression = 0 ];

Method Push(pItem) As %Status
{
    Set tSC=$$$OK

    Set tLevel=..Level
    Set tLevel=$I(tLevel)
    Set ..Level=tLevel
    Set ..Stack(..Level)=pItem

    Quit tSC
}

Method Pop()
{
    Set tItem=..Stack(..Level)
    Kill ..Stack(..Level)
    Set tLevel=..Level
    Set tLevel=$I(tLevel,-1)
    Set ..Level=tLevel
    Quit tItem
}

Method Peak()
{
    Quit ..Stack(..Level)
}

Method GetItems() As %Integer
{
    Quit ..Level
}

}
