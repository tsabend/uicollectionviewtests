//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Thomas Abend on 11/18/15.
//  Copyright © 2015 com.hopscotch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var keyboard = KeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        self.addChildViewController(keyboard)
        let quartY = self.view.bounds.height / 4
        self.view.addSubview(keyboard.view)
        keyboard.view.frame = CGRect(origin: CGPoint(x: 0, y: self.view.bounds.height - quartY), size: CGSize(width: self.view.frame.width, height: quartY))
        keyboard.didMoveToParentViewController(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let layout: UICollectionViewFlowLayout = KeyboardCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.scrollDirection = .Horizontal

        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = true
        self.view.addSubview(collectionView)
        self.collectionView.reloadData()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 30)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! KeyboardCollectionViewCell

        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.orangeColor()
        case 1:
            cell.backgroundColor = UIColor.blueColor()
        case 2:
            cell.backgroundColor = UIColor.blackColor()
        case 3:
            cell.backgroundColor = UIColor.purpleColor()
        case 4:
            cell.backgroundColor = UIColor.greenColor()
        default:
            cell.backgroundColor = UIColor.grayColor()
        }
        cell.label.text = indexPath.row.description
        return cell
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = self.view.bounds
    }


}


class KeyboardCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func collectionViewContentSize() -> CGSize {

        return CGSize(width: 5000, height: 20)
    }

}


class KeyboardCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.blueColor()
        self.contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
        self.label.frame.origin = self.contentView.center
    }
    
    
}
