//
//  parser.swift
//  location
//
//  Created by Christopher on 11/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation
struct circleValue {
    var method:String
    var portion:Double
    var color:String
    var trafficNum:String
}
class loadToHomeParser{
    var datalist = NSDictionary()
    var circleValueArray:Array<circleValue> = Array()
    var noLoad:Bool = false
    var baseURL:NSURL!
    var currentIndex:Int = 0
    
    //let parser = NSXMLParser(contentsOfURL: NSURL(string: baseURL)!)
    
    init(arr arrival_time :String, usr user_loc:String, home home_loc:String) {
        baseURL = NSURL(string:"http://app.havetogohome.tk/?arrival_time=" + arrival_time + "&user_loc=" + user_loc + "&home_loc=" + home_loc)
        print(baseURL)
        getDataList()
        if noLoad == false {
           sessionSave()
        }
    }

    func getDataList(){
        do {
            datalist = try JSONSerialization.jsonObject(with: NSData(contentsOf: baseURL! as URL)! as Data, options: .allowFragments) as! [String:AnyObject] as NSDictionary
        } catch {
            print("Error loading Data")
        }
        //print(datalist["result"]!)
        //print(( datalist["steps"] as! NSArray ).count)
    }

    func sessionSave(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let initTime = dateFormatter.date(from: datalist["first_start_time"] as! String)
        let lastTime = dateFormatter.date(from: datalist["last_end_time"] as! String)
        let result:String = datalist["result"]! as! String
        let resultType:String = datalist["result_type"]! as! String
        let nsuser = UserDefaults()
        
        nsuser.register(defaults: ["first_start_time": (initTime?.description)!])
        nsuser.register(defaults: ["last_end_time": (lastTime?.description)!])
        nsuser.register(defaults: ["result": result])
        nsuser.register(defaults: ["result_type": resultType])
        
        nsuser.synchronize()
    }

    func getCircleValueArray() -> Array<circleValue> {
        let arraySize:Int = (datalist["steps"] as! NSArray).count
        var totalTime:Double = Double((datalist["real_time_interval"]! as AnyObject).description)!
        for var index in 0..<arraySize {
            var color:String?
            var trafficNum:String?
            var type:String = ((datalist.value(forKey: "steps") as! NSArray)[index] as!NSDictionary).value(forKey: "type") as! String
            if type != "도보" {
                color = (((datalist.value(forKey: "steps") as! NSArray)[index] as!NSDictionary).value(forKey: "type_details") as!NSDictionary).value(forKey:"color") as! String
                trafficNum = (((datalist.value(forKey: "steps") as! NSArray)[index] as!NSDictionary).value(forKey: "type_details") as!NSDictionary).value(forKey:"name") as! String
            } else {
                color = ""
                trafficNum = ""
            }
            let portionString:String = ((datalist.value(forKey: "steps") as! NSArray)[index] as!NSDictionary).value(forKey: "interval_percentage") as! String
            var portion:Double = Double(portionString)!
            let cv = circleValue(method:type, portion:portion, color:color!, trafficNum: trafficNum!)
            circleValueArray.append(cv)
        }
        
        return circleValueArray
        //    var arrSize:Int = Int(getDataList["steps"].size)
        //  for var index in 0..<arrSize  {
        
        //}
    }

    func getCurrentRoute() -> Dictionary<String,String>{
        var now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let arraySize:Int = (datalist["steps"] as! NSArray).count
        for var index in 1..<arraySize {
            var indexDateString:String = ((datalist.value(forKey: "steps") as! NSArray)[index] as!NSDictionary).value(forKey: "start_time") as! String
            var indexDate:NSDate = dateFormatter.date(from: indexDateString)! as NSDate
            if  now.laterDate(indexDate as Date) == now as Date  { // now > indexDate
                currentIndex = index
            }else{ // now <indexDate
                break
            }
        }
    
        if currentIndex == arraySize - 1 {
            return [
                "next_mission": "false"
            ]
        }
        var intervalString:String = ((datalist.value(forKey: "steps") as! NSArray)[currentIndex] as!NSDictionary).value(forKey: "interval") as! String
        var interval:Int = Int(intervalString)!
        let startTimeString:String = ((datalist.value(forKey: "steps") as! NSArray)[currentIndex] as!NSDictionary).value(forKey: "start_time") as! String
        let beforeDate:NSDate = dateFormatter.date(from: startTimeString)! as NSDate
        beforeDate.addingTimeInterval(TimeInterval(interval))
        let beforeTime:String = dateFormatter.string(from: beforeDate as Date)
        let beforeMethod:String = ((datalist.value(forKey: "steps") as! NSArray)[currentIndex] as!NSDictionary).value(forKey: "type") as! String
        var beforeColor:String!
        if beforeMethod != "도보" {
            beforeColor = (((datalist.value(forKey: "steps") as! NSArray)[currentIndex] as!NSDictionary).value(forKey: "type_details") as!NSDictionary).value(forKey:"color") as! String
        }else{
            beforeColor = ""
        }
        let beforeLocName:String = (((datalist.value(forKey: "steps") as! NSArray)[currentIndex] as!NSDictionary).value(forKey: "end_loc") as! NSDictionary).value(forKey: "name") as! String
        
        let afterTime:String = ((datalist.value(forKey: "steps") as! NSArray)[currentIndex + 1] as!NSDictionary).value(forKey: "start_time") as! String
        let afterMethod:String = ((datalist.value(forKey: "steps") as! NSArray)[currentIndex + 1] as!NSDictionary).value(forKey: "type") as! String
        var afterColor:String!
        if afterMethod != "도보" {
            afterColor = (((datalist.value(forKey: "steps") as! NSArray)[currentIndex + 1] as!NSDictionary).value(forKey: "type_details") as!NSDictionary).value(forKey:"color") as! String
        }else{
            afterColor = ""
        }
        let afterLocName:String = (((datalist.value(forKey: "steps") as! NSArray)[currentIndex + 1] as!NSDictionary).value(forKey: "start_loc") as! NSDictionary ).value(forKey:"name") as! String
        
        return [
            "next_mission":"true",
            "before_time":beforeTime,
            "before_loc_name":beforeLocName,
            "before_color":beforeColor,
            "before_method":beforeMethod,
            "after_time":afterTime,
            "after_loc_name":afterLocName,
            "after_color":afterColor,
            "after_method":afterMethod
        ]
        
    }
}
