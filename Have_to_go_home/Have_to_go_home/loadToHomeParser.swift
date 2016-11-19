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
            datalist = try JSONSerialization.jsonObject(with: NSData(contentsOf: baseURL! as URL)! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        } catch {
            print("Error loading Data")
        }
        
        sessionSave()
    }
    func sessionSave(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var initTime = dateFormatter.date(from: datalist["first_start_time"] as! String)
        
        //세션 값 저장
        let nsuser = UserDefaults()
        nsuser.register(defaults: ["first_start_time": (initTime?.description)!])
        nsuser.synchronize()
    }
}
