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
        let halfY = self.view.bounds.height / 2
        self.view.addSubview(keyboard.view)
        keyboard.view.frame = CGRect(origin: CGPoint(x: 0, y: halfY), size: CGSize(width: self.view.frame.width, height: halfY))
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

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 20)
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
        return 4000
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 30)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! KeyboardCollectionViewCell
        cell.backgroundColor = UIColor.orangeColor()
        cell.label.text = indexPath.row.description
        return cell
    }    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
     
    }


}

class KeyboardCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
    }
}
