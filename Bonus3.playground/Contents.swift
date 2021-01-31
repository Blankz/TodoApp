import Foundation

var firstArray = [17,2,3,5,7,8,11,13,17,19,20]
let secArray = [19,3,5,7,10,12,15]
var sum: [Int] = []

outer: for first in firstArray {
    inner: for sec in secArray {
        if first == sec {
            sum.append(first)
            continue outer
        }
    }
}
firstArray = sum
