//
//  ViewController.swift
//  DiningPhilosophersProblem
//
//  Created by Dima on 27/09/2016.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var table: Table!
    var pos = 0
    var timer: NSTimer!
    
    @IBOutlet var philosopherViews: [UIView]!
    @IBOutlet var forkViews: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let forks = [Fork(id: 0), Fork(id: 1), Fork(id: 2), Fork(id: 3), Fork(id: 4)]
        let philosophers = [Philosopher(id: 0), Philosopher(id: 1), Philosopher(id: 2), Philosopher(id: 3), Philosopher(id: 4)]
        let spaghettiBowls = [SpaghettiBowl(id: 0, philosopher: philosophers[0]), SpaghettiBowl(id: 1, philosopher: philosophers[1]), SpaghettiBowl(id: 2, philosopher: philosophers[2]), SpaghettiBowl(id: 3, philosopher: philosophers[3]), SpaghettiBowl(id: 4, philosopher: philosophers[4])]
        
        table = Table(forks: forks, spaghettiBowls: spaghettiBowls, philosophers: philosophers)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(start), userInfo: nil, repeats: true)
    }
    
    func start() {
        print("##### BEGIN #####")
        self.table.philosophers.forEach({ (philosopher) in
            if philosopher.state == .Eating {
                let leftFork = self.table.leftForkForPhilosopher(philosopher)
                let rightFork = self.table.rightForkForPhilosopher(philosopher)
                leftFork.philosopher = nil
                rightFork.philosopher = nil
                philosopher.state = .Thinking
                self.philosopherViews[philosopher.id].backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
                self.forkViews[leftFork.id].backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
                self.forkViews[rightFork.id].backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            }
        })
        
        for i in 0..<self.table.philosophers.count {
            var j = pos + i
            if j > self.table.philosophers.count - 1 {
                j = j % self.table.philosophers.count
            }
            // print(j)
            let philosopher = self.table.philosophers[j]
            
            let leftForkAvaliable = self.table.leftForkAvaliableForPhilosopher(philosopher)
            let rightForkAvaliable = self.table.rightForkAvaliableForPhilosopher(philosopher)
            if leftForkAvaliable && rightForkAvaliable {
                let leftFork = self.table.leftForkForPhilosopher(philosopher)
                let rightFork = self.table.rightForkForPhilosopher(philosopher)
                leftFork.philosopher = philosopher
                rightFork.philosopher = philosopher
                philosopher.state = .Eating
                self.philosopherViews[philosopher.id].backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.3)
                self.forkViews[leftFork.id].backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.3)
                self.forkViews[rightFork.id].backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.3)
            }
        }
        pos += 1
        if pos > self.table.philosophers.count - 1 {
            pos = 0
        }
        print("##### END #####")
        self.updateView()
    }
    
    func updateView() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

