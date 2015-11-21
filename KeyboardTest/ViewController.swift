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
        let quartY = self.view.bounds.height / 3
        self.view.addSubview(keyboard.view)
        keyboard.view.frame = CGRect(origin: CGPoint(x: 0, y: self.view.bounds.height - quartY), size: CGSize(width: self.view.frame.width, height: quartY))
        keyboard.didMoveToParentViewController(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {

    
    var collectionView: UICollectionView!
    let picker = UISegmentedControl(items: [
        "zero", "one", "two", "three", "four", "five"
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.addTarget(self, action: "goToSection", forControlEvents: UIControlEvents.ValueChanged)
        picker.selectedSegmentIndex = 0
        picker.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(picker)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
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
    
    func goToSection() {
        let section = self.picker.selectedSegmentIndex
        let indexPath = NSIndexPath(forItem: 0, inSection: section)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! KeyboardCollectionViewCell

        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.orangeColor()
        case 1:
            cell.backgroundColor = UIColor.redColor()
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
        self.collectionView.frame.size.height *= 0.75
        
        self.picker.frame.origin.y = self.collectionView.frame.height
        self.picker.frame.size.height = self.view.bounds.height * 0.25
        self.picker.frame.size.width = self.view.bounds.width
    }

	func scrollViewDidScroll(scrollView: UIScrollView) {
		let visibleCells = self.collectionView.visibleCells()
		if let firstCell = visibleCells.first, indexPath = self.collectionView.indexPathForCell(firstCell) {
			self.picker.selectedSegmentIndex = indexPath.section
		}
	}

}


class KeyboardCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
	let holdGestureRecognizer = UILongPressGestureRecognizer()
    
	var xFromCenter = CGFloat()
	var yFromCenter = CGFloat()

	var originalPoint: CGPoint = CGPoint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.blueColor()
        self.contentView.addSubview(label)

		holdGestureRecognizer.addTarget(self, action: "wasHeld:")
		self.addGestureRecognizer(holdGestureRecognizer)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
        self.label.frame.origin = self.contentView.center
    }

	var doubledView: KeyboardCollectionViewCell?

	func wasHeld(gestureRecognizer: UILongPressGestureRecognizer) {
		let appLocation = gestureRecognizer.locationInView(self.superview)

		switch (gestureRecognizer.state) {
		case .Began:
			self.doubledView = KeyboardCollectionViewCell()
			self.doubledView?.frame = self.frame
			self.doubledView?.backgroundColor = UIColor.brownColor()
			self.superview?.addSubview(doubledView!)

		case .Changed:
			print(appLocation)
			self.doubledView?.frame.origin = appLocation

		case .Ended:
			self.doubledView?.removeFromSuperview()
		default:
			break
		}

	}
}
