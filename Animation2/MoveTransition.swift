//
//  MoveTransition.swift
//  Animation2
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

enum MoveTransitionType {
    case MoveTransitionTypePresent
    case MoveTransitionTypeDismiss
}

class MoveTransition: NSObject, UIViewControllerAnimatedTransitioning {

    
    // 动画类型
    var type: MoveTransitionType
    
    init(type: MoveTransitionType) {
        self.type = type
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        switch type {
        case .MoveTransitionTypePresent:
            print("present")
            presentAnimation(transitionContext)
        case .MoveTransitionTypeDismiss:
            print("dismiss")
            dismissAnimation(transitionContext)
        }
    }
    
    private func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        // 创建贴图
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! MenuViewController
        let containerView = transitionContext.containerView()
        
        let startFrame = CGRect(x: 0, y: 64.0 - toVC.view.bounds.height, width: toVC.view.bounds.width, height: toVC.view.bounds.height)
        containerView?.addSubview(toVC.view!)
        
        toVC.view!.hidden = true
        
        let viewHeight = toVC.view.bounds.height
        let viewWidth = toVC.view.bounds.width
        let menuHeight = viewHeight / 5.0
        let menuTitleFrame = CGRect(x: 0, y: viewHeight - menuHeight, width: viewWidth, height: menuHeight)
        
        for (i,item) in MenuItem.shareItems.reverse().enumerate() {
            
            let tempview = UIView(frame: startFrame)
            tempview.backgroundColor = item.color
            let menuTitle = UIButton(type: .Custom)
            tempview.addSubview(menuTitle)
            menuTitle.enabled = false
            menuTitle.titleLabel?.font = UIFont.systemFontOfSize(25.0)
            menuTitle.setTitle(item.title, forState: .Normal)
            menuTitle.titleLabel?.textAlignment = .Center
            menuTitle.frame = menuTitleFrame
            
            let oldOrigin = menuTitle.frame.origin
            menuTitle.layer.anchorPoint = CGPointMake(0.5, 0);
            let newOrigin = menuTitle.frame.origin;
            var transition = CGPoint();
            transition.x = newOrigin.x - oldOrigin.x;
            transition.y = newOrigin.y - oldOrigin.y;
            menuTitle.center = CGPointMake (menuTitle.center.x - transition.x, menuTitle.center.y - transition.y);
            
            containerView?.addSubview(tempview)
            
            print("items title is \(item.title)")
            
            // 执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                UIView.setAnimationDelay(NSTimeInterval(i) * self.transitionDuration(transitionContext))
                tempview.frame = CGRect(x: 0, y: 0 - CGFloat(i) * menuHeight, width: viewWidth, height: viewHeight)
                }, completion: { (success) in
                    
                    if success {
                        
                        toVC.view.hidden = false
                        
                        UIView.animateWithDuration(0.2, animations: { 
                            UIView.setAnimationRepeatCount(2)
                            
                            menuTitle.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4)/25.0)
                            menuTitle.transform = CGAffineTransformMakeRotation(0.0)
                            menuTitle.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4)/25.0)
                            menuTitle.transform = CGAffineTransformMakeRotation(0.0)
                            
                            }, completion: { (success) in
                                
                                if success {
                                    tempview.removeFromSuperview()
                                }
                        })
                        print("\(i) is finish")
                        
                        if i == MenuItem.shareItems.count - 1 {
                            
                            transitionContext.completeTransition(true)
                        }
                    }
                    
            })
        }
    }
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        // 创建贴图
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        containerView?.insertSubview((toVC?.view)!, atIndex: 0)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            fromVC?.view.frame = CGRect(x: 0.0, y: 64 - (fromVC?.view.bounds.height)!, width: (fromVC?.view.bounds.width)!, height: (fromVC?.view.bounds.height)!)
            }) { (success) in
                if success {
                    fromVC?.view.hidden = true
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                }
        }
        
    }
    
//    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        
//        switch type {
//        case .MoveTransitionTypePresent:
//            let transitionContext = anim.valueForKey("transitionContext") as! UIViewControllerContextTransitioning
//            transitionContext.completeTransition(true)
//        case .MoveTransitionTypeDismiss:
//            let transitionContext = anim.valueForKey("transitionContext") as! UIViewControllerContextTransitioning
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
//        }
//    }
    
    
//    //MARK: - 截图
//    func screenshotWithRect(view: UIView, rect: CGRect) -> UIImage {
//        
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
//        let context = UIGraphicsGetCurrentContext()
//    
//        assert(context != nil)
//        CGContextSaveGState(context)
//        CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y)
//    
//        if view.respondsToSelector(#selector(view.drawViewHierarchyInRect)) {
//            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
//        } else {
//            view.layer.renderInContext(context!)
//        }
//        
//        CGContextRestoreGState(context)
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return image
//    }
    
}
