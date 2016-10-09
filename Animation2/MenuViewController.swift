//
//  MenuViewController.swift
//  Animation2
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var menuView: UICollectionView!
    
    var delegate: MenuProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customInterface()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func customInterface() {
        
        let width = self.menuView.frame.size.width
        let height = self.menuView.frame.size.height / CGFloat(MenuItem.shareItems.count)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSizeMake(width, height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        menuView.setCollectionViewLayout(layout, animated: true)
    }
    
    // MARK: - collectionView Delegate and DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem.shareItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MenuCell
        
        cell.configureCell(MenuItem.shareItems[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        delegate?.configureMenu(MenuItem.shareItems[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
