import Foundation

func compressing(_ s: String) -> String {
    if s.isEmpty {
        return ""
    }
    
    var count = 1
    var compS = ""
    let chars = Array(s)
    
    for i in 1...chars.count {
        if i < chars.count && chars[i] == chars[i - 1] {
            count += 1
        } else {
            compS.append(chars[i - 1])
            compS.append(String(count))
            count = 1
        }
    }
    
    return compS
}

print("Write a String for compressing...")
if let input = readLine() {
    let S = input
    let compS = compressing(S)
    
    if compS.count >= S.count {
        print("String S doesn't need compressing...")
        print(S)
    } else {
        print(compS)
    }
}