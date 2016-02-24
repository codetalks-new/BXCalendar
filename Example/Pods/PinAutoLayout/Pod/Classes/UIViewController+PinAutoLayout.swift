//
//  UIViewController+PinAutoLayout.swift
//  Pods
//
//  Created by Haizhen Lee on 15/10/9.
//
//

import UIKit

extension UIViewController{
   
    private func assertHasSubview(subview:UIView){
        assert(pa_contains(view), "NO such child View \(view)")
    }
    
    public func pinTopLayoutGuide(view:UIView,margin : CGFloat = 0) -> NSLayoutConstraint{
        assertHasSubview(view)
        let topC = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: margin)
        self.view.addConstraint(topC)
        return topC
    }
    
    public func pinBottomLayoutGuide(view:UIView,margin : CGFloat = 0) -> NSLayoutConstraint{
        assertHasSubview(view)
        let bottomC = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: -margin)
        self.view.addConstraint(bottomC)
        return bottomC
    }
   
    public func pinEdge(view:UIView, margin:UIEdgeInsets = UIEdgeInsetsZero) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.leading =  view.pinLeading(margin.left)
        edgeC.trailing = view.pinTrailing(margin.right)
        edgeC.top = pinTopLayoutGuide(view,margin:margin.top)
        edgeC.bottom = pinBottomLayoutGuide(view, margin: margin.bottom)
        return edgeC
    }
    
    public func pa_contains(view:UIView) -> Bool{
       return _findRootView(view) == self.view
    }
    
    private func _findRootView(view:UIView) -> UIView{
        var rootView = view
        while true{
            if let superview = rootView.superview{
                rootView = superview
            }else{
                break
            }
        }
        return rootView
    }
    
    
}
