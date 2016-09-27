//
//  DiningPhilosophersProblemTests.swift
//  DiningPhilosophersProblemTests
//
//  Created by Dima on 27/09/2016.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import XCTest
@testable import DiningPhilosophersProblem


class DiningPhilosophersProblemTests: XCTestCase {
    
    var table: Table!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        let forks = [Fork(id: 0), Fork(id: 1), Fork(id: 2), Fork(id: 3), Fork(id: 4)]
        let philosophers = [Philosopher(id: 0), Philosopher(id: 1), Philosopher(id: 2), Philosopher(id: 3), Philosopher(id: 4)]
        let spaghettiBowls = [SpaghettiBowl(id: 0, philosopher: philosophers[0]), SpaghettiBowl(id: 1, philosopher: philosophers[1]), SpaghettiBowl(id: 2, philosopher: philosophers[2]), SpaghettiBowl(id: 3, philosopher: philosophers[3]), SpaghettiBowl(id: 4, philosopher: philosophers[4])]
        
        table = Table(forks: forks, spaghettiBowls: spaghettiBowls, philosophers: philosophers)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        continueAfterFailure = true
    }
    
    func testPosition() {
        XCTAssert(table.leftForkForPhilosopher(table.philosophers[0]).id == 0)
        XCTAssert(table.rightForkForPhilosopher(table.philosophers[0]).id == 4)

        XCTAssert(table.leftForkForPhilosopher(table.philosophers[1]).id == 1)
        XCTAssert(table.rightForkForPhilosopher(table.philosophers[1]).id == 0)

        XCTAssert(table.leftForkForPhilosopher(table.philosophers[4]).id == 4)
        XCTAssert(table.rightForkForPhilosopher(table.philosophers[4]).id == 3)
    }
    
    func testDiningPhilosophersProblem() {
        var pos = 0
        for _ in 0..<1000 {
            // print("##### BEGIN #####")
            table.philosophers.forEach({ (philosopher) in
                if philosopher.state == .Eating {
                    let leftFork = table.leftForkForPhilosopher(philosopher)
                    let rightFork = table.rightForkForPhilosopher(philosopher)
                    leftFork.philosopher = nil
                    rightFork.philosopher = nil
                    philosopher.state = .Thinking
                }
            })
            
            for i in 0..<table.philosophers.count {
                var j = pos + i
                if j > table.philosophers.count - 1 {
                    j = j % table.philosophers.count
                }
                // print(j)
                let philosopher = table.philosophers[j]
                
                let leftForkAvaliable = table.leftForkAvaliableForPhilosopher(philosopher)
                let rightForkAvaliable = table.rightForkAvaliableForPhilosopher(philosopher)
                if leftForkAvaliable && rightForkAvaliable {
                    let leftFork = table.leftForkForPhilosopher(philosopher)
                    let rightFork = table.rightForkForPhilosopher(philosopher)
                    leftFork.philosopher = philosopher
                    rightFork.philosopher = philosopher
                    philosopher.state = .Eating
                } else {
                    philosopher.state = .Thinking
                }
            }
            pos += 1
            if pos > table.philosophers.count - 1 {
                pos = 0
            }
            // print("##### END #####")
            
            
            // Begin testing
            table.philosophers.forEach({ (philosopher) in
                if philosopher.state == .Thinking {
                   philosopher.onDiet += 1
                } else {
                    philosopher.onDiet = 0
                }
            })
            
            
            let onDietPhilosophers = table.philosophers.filter({ (philosopher) -> Bool in
                if philosopher.onDiet > 2 {
                    return true
                }
                return false
            })
            // print("##### OnDiet #####")
            // onDietPhilosophers.forEach({ (philosopher) in
            //     print(philosopher.id)
            // })
            // print("onDiet: \(onDietPhilosophers.count)")
            XCTAssert(onDietPhilosophers.count == 0)
            
            
            let eatingPhilosophers = table.philosophers.filter({ (philosopher) -> Bool in
                if philosopher.state == .Eating {
                    return true
                }
                return false
            })
            print("##### EatingPhilosophers #####")
            eatingPhilosophers.forEach({ (philosopher) in
                print(philosopher.id)
            })
            // print("Eating: \(eatingPhilosophers.count)")
            XCTAssert(eatingPhilosophers.count == 2)
            
            
            let thinkingPhilosophers = table.philosophers.filter({ (philosopher) -> Bool in
                if philosopher.state == .Thinking {
                    return true
                }
                return false
            })
            // print("##### ThinkingPhilosophers #####")
            // thinkingPhilosophers.forEach({ (philosopher) in
            //     print(philosopher.id)
            // })
            // print("Thinking: \(thinkingPhilosophers.count)")
            XCTAssert(thinkingPhilosophers.count == 3)
        }
    }
}




