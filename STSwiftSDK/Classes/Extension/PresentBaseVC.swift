//
//  PresentBaseVC.swift
//  TESt
//
//  Created by cfans on 2018/10/30.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

let CFAnimatorDuration = 0.3


class CFPresentPushAnimator:NSObject,UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return CFAnimatorDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

        let container = transitionContext.containerView
        let screenWidth = UIScreen.main.bounds.size.width
        var fromVCRect = fromVC.view.frame
        fromVCRect.origin.x = 0
        fromVC.view.frame = fromVCRect
        container.addSubview((toVC.view)!)

        var toVCRect = toVC.view.frame
        toVCRect.origin.x = screenWidth
        toVC.view.frame = toVCRect


        fromVCRect.origin.x = -screenWidth
        toVCRect.origin.x = 0

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = fromVCRect
            toVC.view.frame = toVCRect
        }) { (finished) in
            fromVC.view.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }

}

class CFPresentDismissAnimator:NSObject,UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return CFAnimatorDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!


        let container = transitionContext.containerView
        let screenWidth = UIScreen.main.bounds.size.width
        var fromVCRect = fromVC.view.frame
        fromVCRect.origin.x = 0
        fromVC.view.frame = fromVCRect
        container.addSubview((toVC.view)!)

        var toVCRect = toVC.view.frame
        toVCRect.origin.x = -screenWidth
        toVC.view.frame = toVCRect


        fromVCRect.origin.x = screenWidth
        toVCRect.origin.x = 0

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = fromVCRect
            toVC.view.frame = toVCRect
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}

class CFPresentBaseVC:UIViewController,UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate{

    var percentDrivenTransition:UIPercentDrivenInteractiveTransition!

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil,isPushStyle:Bool){

        if flag && isPushStyle {
            viewControllerToPresent.transitioningDelegate = self

            let screenGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onPanGesture(gesture:)))
            screenGesture.delegate = self
            screenGesture.edges = UIRectEdge.left
            viewControllerToPresent.view.addGestureRecognizer(screenGesture)
            
            if viewControllerToPresent.isKind(of: UINavigationController.self){
                screenGesture.require(toFail: (viewControllerToPresent as! UINavigationController).interactivePopGestureRecognizer!)
            }
        }

        present(viewControllerToPresent, animated: flag,completion: completion);
    }

    // pragma mark - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CFPresentPushAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CFPresentDismissAnimator()
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animator.isKind(of: CFPresentDismissAnimator.self){
            return self.percentDrivenTransition
        }
        return nil
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animator.isKind(of: CFPresentPushAnimator.self){
            return self.percentDrivenTransition
        }
        return nil
    }



    //pragma mark - UIGestureRecognizer
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self){
            return false
        }
        return true
    }

    @objc func onPanGesture(gesture:UIScreenEdgePanGestureRecognizer) {
        let progress = gesture.translation(in: self.view).x / UIScreen.main.bounds.size.width
        if (gesture.state == .began) {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.dismiss(animated: true)
        } else if (gesture.state == .changed) {
            self.percentDrivenTransition.update(progress)
        } else if (gesture.state == .cancelled || gesture.state == .ended) {
            if (progress > 0.5) {
                self.percentDrivenTransition.finish()
            } else {
                self.percentDrivenTransition.cancel()
            }
            self.percentDrivenTransition = nil;
        }
    }
}
