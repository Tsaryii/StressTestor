using{/Fortnite.com/Devices}
using { /Verse.org/Simulation }
using { /Verse.org/Random }
#Tests the latency of the game
ServerTester:=class<concrete>(creative_device){

    @editable var ThreadsToTest:int = 0
    var EndLatencyTest : logic = false

    var LatencyResult: event(tuple(float, string)) = event(tuple(float, string)){}

    var CompScore : float = 0.0

    LatencyManager()<suspends>:void=
        spawn{LatencyQue()}
        spawn{LatencyForce()}
        
            loop:
                TestResult := LatencyResult.Await()
                Print("Latency score for thread-{TestResult(1)} is: {TestResult(0)}")
                set CompScore += TestResult(0)

    LatencyForce()<suspends>:void=
        loop:
            Sleep(0.9)
            if(EndLatencyTest = true):
                Print("Overall Multithreaded score is {CompScore}")
                set CompScore = 0.0


    LatencyQue()<suspends>:void=
        var TimeElapsed:float = 0.0
        #Every 15 seconds do a 10 second latency test
        loop:
            Print("!== BEGUN THREAD STRESS TEST ==!")
            for(I := 0..ThreadsToTest){if(ID := CreateID[7]){Print("stimulating thread: {ID}");spawn{StartLatencyTest(ID)}}}
            loop:
                if(TimeElapsed < 10.0):
                    Sleep(0.1)
                    set TimeElapsed += 0.1
                else:
                    set EndLatencyTest = true
                    set TimeElapsed = 0.0
                    break
            Sleep(1.0)
            set EndLatencyTest = false
            Sleep(5.0)
            

    StartLatencyTest(ID:string)<suspends>:void=
        var TotalCalculations:float = 0.0
        var Margin: int = 100
        loop:
            Sleep(0.0)
            if(EndLatencyTest = true):
                LatencyResult.Signal(TotalCalculations, ID)
                break
            for(I := 0..Margin){set TotalCalculations +=GetRandomFloat(1.0, 1.1)/(Margin*1.0)}
            if(GetRandomFloat(1.0, 2245677.0) / 2245677.0 >= 0.5){}
            set TotalCalculations += (0.005)
}
