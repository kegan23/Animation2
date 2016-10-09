//
//  MenuCell.swift
//  Animation2
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    

    @IBOutlet weak var logo: UIButton!
    
    func configureCell(item:MenuItem) {
        
        logo!.setTitle(item.title, forState: .Normal)
        logo!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        logo!.titleLabel?.textAlignment = .Center
        logo!.backgroundColor = UIColor.clearColor()
        
//        title.text = item.title
//        title.textColor = UIColor.whiteColor()
//        title.textAlignment = .Center
//        title.backgroundColor = UIColor.clearColor()
        
        self.backgroundColor = item.color
        
    }
    
}
