//
//  PhotoAnimation.swift
//  PhotoAlbumDemo
//
//  Created by 万想想 on 2019/2/25.
//  Copyright © 2019年 wanxiangxiang. All rights reserved.
//

import Foundation
import UIKit
// 动画类型
enum ExamDesAnimationType {
    case ExamDesAnimationTypePresent
    case ExamDesAnimationTypeDismiss
}
class EdlExamDesAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    var animationType: ExamDesAnimationType!
    //动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    //过渡动画事物处理
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch animationType {
        case .ExamDesAnimationTypePresent?:
            presentAnimation(transitionContext: transitionContext)
        default:
            dismissAnimation(transitionContext: transitionContext)
        }
    }
    func presentAnimation(transitionContext:UIViewControllerContextTransitioning){
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? PhotoViewController
        let desVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? UINavigationController
        let fromVc = desVc?.topViewController as! ViewController
        
        let cell = fromVc.tableView.cellForRow(at: fromVc.currnetIndexPath!)
        let containerView = transitionContext.containerView
        let tempView = cell!.imageView!.snapshotView(afterScreenUpdates: false)
        tempView?.frame = cell!.imageView!.convert(cell!.imageView!.bounds, to: containerView)
        
        //设置动画前的各个控件的状态
        cell?.imageView?.isHidden = true
        toVc?.view.alpha = 0
        toVc?.scrollView.isHidden = true
        
        containerView.addSubview((toVc?.view)!)
        containerView.addSubview(tempView!)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            tempView?.frame = (toVc?.scrollView.convert((toVc?.scrollView.bounds)!, to: containerView))!
            toVc?.view.alpha = 1
        }) { (bool) in
            tempView?.removeFromSuperview()
            toVc?.scrollView.isHidden = false
            transitionContext.completeTransition(true)
            let rect = toVc!.view.frame
            print(rect)
        }
    }
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? PhotoViewController
        let toNavVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? UINavigationController
        let toVc = toNavVc?.topViewController as! ViewController
        
        let cell = toVc.tableView.cellForRow(at: toVc.currnetIndexPath!)
        let containerView = transitionContext.containerView
        let tempView = fromVc?.scrollView.snapshotView(afterScreenUpdates: false)
        tempView?.frame = (fromVc?.scrollView.convert((fromVc?.scrollView.bounds)!, to: containerView))!
        
        fromVc?.scrollView.isHidden = true
        containerView.addSubview(tempView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            tempView?.frame = (cell?.imageView!.convert((cell?.imageView!.bounds)!, to: containerView))!
            fromVc?.view.alpha = 0
        }) { (bool) in
            transitionContext.completeTransition(true)
            if transitionContext.transitionWasCancelled{
                //手势取消
                tempView?.removeFromSuperview()
                fromVc?.scrollView.isHidden = false
            }else{
                cell?.imageView?.isHidden = false
                tempView?.removeFromSuperview()
            }
        }
    }
}
