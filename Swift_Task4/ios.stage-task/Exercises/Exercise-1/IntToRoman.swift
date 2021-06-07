import Foundation

public extension Int {
    
    var roman: String? {
        let romanToInt: [Int : String] = [1: "I", 4: "IV", 5: "V", 9: "IX", 10: "X", 40: "XL", 50: "L", 90: "XC", 100: "C", 400: "CD", 500: "D", 900: "CM", 1000: "M"]
        var intNumbers = [Int](romanToInt.keys)
        intNumbers.sort(by: {$0 > $1})
        
        var outputString = String()
        var value = self
        if (self <= 0 || self > 3999) {
            return nil
        }
        for i in 0 ..< intNumbers.count {
            while value >= intNumbers[i] {
                value -= intNumbers[i]
                outputString += romanToInt[intNumbers[i]]!
            }
        }
       return outputString
    }
}
