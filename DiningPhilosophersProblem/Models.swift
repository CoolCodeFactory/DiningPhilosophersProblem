//
//  Models.swift
//  DiningPhilosophersProblem
//
//  Created by Dima on 27/09/2016.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import Foundation


class Fork {
    let id: Int
    var philosopher: Philosopher?
    
    init(id: Int) {
        self.id = id
    }
}

class SpaghettiBowl {
    let id: Int
    let philosopher: Philosopher
    
    init(id: Int, philosopher: Philosopher) {
        self.id = id
        self.philosopher = philosopher
    }
}

class Philosopher {
    let id: Int
    
    enum State {
        case Eating
        case Thinking
    }
    
    var state = State.Thinking
    var onDiet = 0
    
    init(id: Int) {
        self.id = id
    }
}

class Table {
    let forks: [Fork]
    let spaghettiBowls: [SpaghettiBowl]
    let philosophers: [Philosopher]
    
    init(forks: [Fork], spaghettiBowls: [SpaghettiBowl], philosophers: [Philosopher]) {
        self.forks = forks
        self.spaghettiBowls = spaghettiBowls
        self.philosophers = philosophers
    }
    
    
    func leftForkForPhilosopher(philosopher: Philosopher) -> Fork {
        let id: Int = philosopher.id
        let fork = forks[id]
        return fork
    }
    
    func rightForkForPhilosopher(philosopher: Philosopher) -> Fork {
        var id: Int = philosopher.id - 1
        if id < 0 {
            id = 4
        }
        let fork = forks[id]
        
        return fork
    }
    
    func leftForkAvaliableForPhilosopher(philosopher: Philosopher) -> Bool {
        let fork = leftForkForPhilosopher(philosopher)
        if fork.philosopher == nil {
            return true
        } else {
            return false
        }
    }
    
    func rightForkAvaliableForPhilosopher(philosopher: Philosopher) -> Bool {
        let fork = rightForkForPhilosopher(philosopher)
        if fork.philosopher == nil {
            return true
        } else {
            return false
        }
    }
}
