//
//  Bellard.swift
//  ToThePi
//
//  Created by Mark Wong on 15/2/19.
//  Copyright © 2019 Mark Wong. All rights reserved.
//

import Foundation
import UIKit

class Bellard {
    
    init() {
        //
    }
    
    func getDecimal(n: Int) -> Int {
        
        var av: Int = 0
        var a: Int = 0
        var vmax: Int  = 0
        var num: Int  = 0
        var N: Int  = 0
        var den: Int = 0
        var k: Int  = 0
        var kq: Int  = 0
        var kq2: Int  = 0
        var t: Int = 0
        var v: Int  = 0
        var s: Int  = 0
        var i: Int = 0
        
        var sum: Double = 0.0
        
        let a1 = Double(n + 20)
        let a2 = log(10.0)
        let a3 = log(2.0)
        N = Int(a1 * a2 / a3)
        
        sum = 0
        
        a = 3
        while (a <= (2 * N)) {
            vmax = Int((log(2.0 * Double(N)) / log(Double(a))))
//            print("vmax \(vmax)")
            av = 1
            for i in stride(from: 0, to: vmax, by: 1) {
                av = av * a
            }
//            print("av \(av)")
            s = 0
            num = 1
            den = 1
            v = 0
            kq = 1
            kq2 = 1
            
            for k in stride(from: 1, through: N, by: 1) {
                t = k
                if (kq >= a) {
                    repeat {
                        t = t / a
                        v = v - 1
                    } while ((t % a) == 0)
                    kq = 0
                }
                kq = kq + 1
                num = mulMod(numA: num, numB: t, numC: av)
                
                t = 2 * k - 1
                if (kq2 >= a) {
                    if (kq2 == a) {
                        repeat {
                            t = t / a
                            v = v + 1
                        } while ((t % a) == 0)
                    }
                    kq2 = kq2 - a
                }
                den = mulMod(numA: den, numB: t, numC: av)
                //print(den)
                kq2 = kq2 + 2
                
                if (v > 0) {
                    t = modInverse(den: den, av: av)
                    t = mulMod(numA: t, numB: num, numC: av)

                    t = mulMod(numA: t, numB: k, numC: av)

                    for i in stride(from: v, to: vmax, by: 1) {
                        t = mulMod(numA: t, numB: a, numC: av)
                    }

                    s = s + t
                    if (s >= av) {
                        s = s - av
                    }
                }
            }
//            print(av)

            t = powMod(numA: 10, numB: n - 1, numC: av)
            print(t)
            s = mulMod(numA: s, numB: t, numC: av)
            sum = (sum +  (Double(s) / Double(av))).truncatingRemainder(dividingBy: 1.0)
            a = nextPrime(n: a)
        }
        let numberOfDecimalPlacesToShow = 10.0
        return Int(sum * pow(10, numberOfDecimalPlacesToShow))
    }
    
    private func powMod(numA: Int, numB: Int, numC: Int) -> Int {
        print("a \(numA) b \(numB) numc \(numC)")
        var tempo: Int = 0
        if (numB == 0) {
            tempo = 1
        } else if (numB == 1) {
            tempo = numA
        } else {
            let temp: Int = powMod(numA: numA, numB: numB / 2, numC: numC)
            if (numB % 2 == 0) {
                tempo = (temp * temp) % numC
            } else {
                tempo = ((temp * temp) % numC) * (numA % numC)
            }
        }
        return tempo
    }
    
    private func modInverse(den: Int, av: Int) -> Int {
        var i = av
        var v = 0
        var d = 1
        var tempDen = den
        while (tempDen > 0) {
            let t = i / tempDen
            var x = tempDen
            tempDen = i % x
            i = x
            x = d
            d = v - t * x
            v = x
        }
        v = v % av
        if (v < 0) {
            v = (v + av) % av
        }
        return v
    }
    
    private func mulMod(numA: Int, numB: Int, numC: Int) -> Int {
        return (numA * numB) % numC
    }
    
    private func isPrime(n: Int) -> Bool {
        if (n == 2 || n == 3) {
            return true
        }
        if (n % 2 == 0 || n % 3 == 0 || n < 2) {
            return false
        }
        
        let squareRoot: Int = Int(sqrt(Double(n)) + 1) //not convinced..
        for i in stride(from: 6, through: squareRoot, by: 6) {
            if (n % (i - 1) == 0) {
                return false
            } else if (n % (i + 1) == 0) {
                return false
            }
        }
        return true
    }
    
    private func nextPrime(n: Int) -> Int {
        if (n < 2) {
            return 2
        }
        if (n == 9223372036854775783) {
            print("Next prime number exceeds max \(Int.max)")
            return -1
        }
        
        for i in stride(from: n + 1, through: 9223372036854775783, by: 1) {
            if (isPrime(n: i)) {
                return i
            }
        }
        
        return -1
    }
    

}
//18446744073709551615
