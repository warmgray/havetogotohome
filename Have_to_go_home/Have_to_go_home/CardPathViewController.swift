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
    
    func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float(cardCollectionView.contentOffset.x + (self.cardCollectionView!.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = FLT_MAX
        for i in 0..<cardCollectionView.visibleCells.count {
            let cell = cardCollectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = cardCollectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.cardCollectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

}

extension CardPathViewController : UICollectionViewDataSource, UIScrollViewDelegate {
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
    
}
