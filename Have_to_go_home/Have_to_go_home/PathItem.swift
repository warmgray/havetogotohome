//
//  PathItem.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2017. 1. 12..
//  Copyright © 2017년 유정우. All rights reserved.
//

import UIKit

class PathItem {
    var departTime: String!
    var pathTime: String!
    var walkTime: String!
    var selected: Bool!
    
    init(departTime: String, pathTime: String, walkTime: String, selected: Bool) {
        self.departTime = departTime
        self.pathTime = pathTime
        self.walkTime = walkTime
        self.selected = selected
    }
    
    static func createPathCards () -> [PathItem] {
        return [
            PathItem(departTime: "23시 30분", pathTime: "00시 42분", walkTime: "00시 19분", selected: true),
            PathItem(departTime: "23시 45분", pathTime: "00시 41분", walkTime: "00시 19분", selected: false),
            PathItem(departTime: "23시 15분", pathTime: "00시 40분", walkTime: "00시 19분", selected: false)
        ]
    }
    
}
