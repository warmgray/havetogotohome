//
//  PathItemViewCell.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2017. 1. 12..
//  Copyright © 2017년 유정우. All rights reserved.
//

import UIKit

class PathItemViewCell: UICollectionViewCell {
    
    @IBOutlet weak var departTime: UILabel!
    @IBOutlet weak var pathTime: UILabel!
    @IBOutlet weak var walkTime: UILabel!
    
    var item : PathItem! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        departTime.text! = item.departTime+" 출발"
        pathTime.text! = "총 소요시간 : "+item.pathTime
        walkTime.text! = "도보 거리 : "+item.walkTime
    }
    
}
