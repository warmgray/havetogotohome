//
//  parser.swift
//  location
//
//  Created by Christopher on 11/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation
class loadToHomeParser{
    var datalist = NSDictionary()
    var baseURL:NSURL!
    //let parser = NSXMLParser(contentsOfURL: NSURL(string: baseURL)!)
    
    init(arr arrival_time :String, usr user_loc:String, home home_loc:String) {
        baseURL = NSURL(string:"http://app.havetogohome.tk/?arrival_time=" + user_loc + "&user_loc=" + user_loc + "&home_loc=" + home_loc)
    }
    func getDataList(){
        do {
            datalist = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: baseURL!)!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        } catch {
            print("Error loading Data")
        }
        
        sessionSave()
    }
    func sessionSave(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var initTime = dateFormatter.dateFromString(datalist["first_start_time"] as! String)
        
        let nsuser = NSUserDefaults()
        nsuser.registerDefaults(["first_start_time": (initTime?.description)!])
        nsuser.synchronize()
    }
}