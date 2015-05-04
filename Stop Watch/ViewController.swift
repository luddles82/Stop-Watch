//
//  ViewController.swift
//  Stop Watch
//
//  Created by Nick Ludlow on 02/05/2015.
//  Copyright (c) 2015 Nick Ludlow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var laps: [String] = []
    
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    var stopwatchString: String = ""
    
    var startstopWatch: Bool = true
    var addLap: Bool = false
    
    
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!

    @IBOutlet weak var startstopButton: UIButton!
    
    @IBOutlet weak var lapresetButton: UIButton!
    
    
    @IBAction func startstop(sender: AnyObject) {
        
        if startstopWatch == true{
        
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopwatch"), userInfo: nil , repeats: true)
            startstopWatch = false
            
            startstopButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            lapresetButton  .setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
            
            addLap = true
            
        }else {
        
        timer.invalidate()
        startstopWatch = true
            startstopButton.setImage(UIImage(named: "start.png"), forState: .Normal)
            lapresetButton.setImage(UIImage(named: "reset.png"), forState: .Normal)
            
            addLap = false
            
        }
        
    }
    
    
    @IBAction func lapreset(sender: AnyObject) {
        
        if addLap == true{
            
            laps.insert(stopwatchString, atIndex: 0)
            lapsTableView.reloadData()
        
        }else {
        
        addLap == false
            
            lapresetButton.setImage(UIImage(named: "lap.png"), forState: .Normal)
            
            laps.removeAll(keepCapacity: false)
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopwatchLabel.text = "00:00.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateStopwatch() {
    
        fractions += 1
        if fractions == 100 {
            
            seconds += 1
            fractions = 0
            
        }
        
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
            
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopwatchLabel.text = stopwatchString
    }


    //Table View Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel!.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return laps.count
        
    }
    
}

