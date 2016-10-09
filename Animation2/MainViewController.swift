//
//  MainViewController.swift
//  Animation2
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

protocol MenuProtocol {
    func configureMenu(menu:MenuItem)
}

class MainViewController: UIViewController, MenuProtocol, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var logoL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    
    var menuItem: MenuItem? {
        didSet{
            navView.backgroundColor = menuItem!.color
            titleL.text = menuItem!.title
            titleL.textColor = menuItem!.color
            logoL.text = menuItem!.logo
            logoL.textColor = menuItem!.color
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuItem = MenuItem.shareItems.last
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        menuVC.delegate = self
        menuVC.transitioningDelegate = self
        self.presentViewController(menuVC, animated: true, completion: nil)
        //            MoveTransition(type: MoveTransitionType.MoveTransitionTypePresent).animationEnded
    }

    func configureMenu(menu: MenuItem) {
        
        self.menuItem = menu
    }
    
    // MARK: - Animation Delegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MoveTransition(type: MoveTransitionType.MoveTransitionTypePresent)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MoveTransition(type: MoveTransitionType.MoveTransitionTypeDismiss)
    }
    
}