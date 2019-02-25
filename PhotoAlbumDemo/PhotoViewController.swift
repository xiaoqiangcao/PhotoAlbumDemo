//
//  PhotoViewController.swift
//  PhotoAlbumDemo
//
//  Created by 万想想 on 2019/2/25.
//  Copyright © 2019年 wanxiangxiang. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController ,UIViewControllerTransitioningDelegate {
    var desAnimation: EdlExamDesAnimation?
    //    var imageView = UIImageView()
    var scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        desAnimation = EdlExamDesAnimation()
        self.transitioningDelegate = self
        desAnimation?.animationType = .ExamDesAnimationTypePresent
        modalPresentationStyle = .custom
        setScrollView()
        setImageView()
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(imageViewPanGesture(pan:)))
        view.addGestureRecognizer(pan)
    }
    func setImageView(){
        let imageArray = ["piao","timg.jpg","timg1.jpg"]
        for i in 0..<3 {
            print(CGFloat(i))
            let imageView = UIImageView.init(frame: CGRect(x: (scrollView.frame.size.width) * CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            imageView.image = UIImage.init(named: imageArray[i])
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapClick))
            imageView.addGestureRecognizer(tap)
            scrollView.addSubview(imageView)
        }
    }
    func setScrollView(){
        scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/2))
        scrollView.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3.0, height: 0)
        view.addSubview(scrollView)
    }
    @objc func imageViewTapClick(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func imageViewPanGesture(pan:UIPanGestureRecognizer){
        let translation = pan.translation(in: self.scrollView)
        var percentComplete = 0.0
        scrollView.center = CGPoint(x: scrollView.center.x + translation.x, y: scrollView.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: scrollView)
        percentComplete = Double((scrollView.center.y - view.frame.height/2.0) / (view.frame.height/2.0))
        percentComplete = fabs(percentComplete)
        switch pan.state {
        case .began:
            break
        case .changed:
            view.alpha = CGFloat(1.0 - percentComplete)
        case .ended:
            if percentComplete > 0.5{
                self.dismiss(animated: true, completion: nil)
            }else{
                scrollView.center = CGPoint(x: view.center.x, y: view.center.y)
                view.alpha = 1
            }
        default:
            break
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.desAnimation
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        desAnimation?.animationType = .ExamDesAnimationTypeDismiss
        return self.desAnimation
    }

}
