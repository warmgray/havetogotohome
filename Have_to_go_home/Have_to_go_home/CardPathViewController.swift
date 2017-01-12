//
//  CardPathViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2017. 1. 12..
//  Copyright © 2017년 유정우. All rights reserved.
//

import UIKit

class CardPathViewController: UIViewController {
    
    @IBOutlet weak var finalDepartClock: UILabel!
    @IBOutlet weak var finalRemainTimeMessage: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    @IBOutlet weak var cardDepartTime: UILabel!
    @IBOutlet weak var cardPathTime: UILabel!
    @IBOutlet weak var cardWalkTIme: UILabel!
    
    var pathItems = PathItem.createPathCards()
    
    struct Storyboard {
        static let CellIdentifier = "Path Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CardPathViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pathItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! PathItemViewCell
        
        cell.item = self.pathItems[indexPath.item]
        
        return cell
    }
    
}
