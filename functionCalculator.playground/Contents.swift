import UIKit


printTakeIn("Tina", 0)

func printTakeIn(_ str : String, _ intVal : Int?) -> Int{
    print("String takes in: \(str)")
    guard let test = intVal else {
        print ("Integer takes in is nil")
        return 0}
    print("Integer takes in: \(test)")
    return test * 5
}
print(printTakeIn("Tina", 4))
print(printTakeIn("Tina", nil))

