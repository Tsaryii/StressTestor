using { /Verse.org/Random }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
CreateID<public>(Length:int)<decides><transacts>:string={
        Coords:string=("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        ID := for:
            I := 0..Length
            R:=GetRandomInt(0,35)
        do{Coords[R]}; ID   
}
