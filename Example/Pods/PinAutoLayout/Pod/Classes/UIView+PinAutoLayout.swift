//
//  UIView+PinAutoLayout.swift
//  banxi1988
//  @LastModified 2015/09/30
//  Created by banxi1988 on 15/5/28.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

public extension UIEdgeInsets{
  public init (margin:CGFloat){
   top = margin
   left = margin
   right = margin
   bottom = margin
  }
}

public class PAEdgeConstraints{
    public var leading:NSLayoutConstraint?
    public var trailing:NSLayoutConstraint?
    public var top:NSLayoutConstraint?
    public var bottom:NSLayoutConstraint?
    
    public func updateBy(edge:UIEdgeInsets){
        leading?.constant = edge.left
        trailing?.constant = edge.right
        top?.constant = edge.top
        bottom?.constant = edge.bottom
    }
}

public class PACenterConstraints{
    public let centerX:NSLayoutConstraint
    public let centerY:NSLayoutConstraint
    
    public init(centerX:NSLayoutConstraint,centerY:NSLayoutConstraint){
        self.centerX = centerX
        self.centerY = centerY
    }
}

public class PASizeConstraints{
    public let width:NSLayoutConstraint
    public let height:NSLayoutConstraint
    public init(width:NSLayoutConstraint,height:NSLayoutConstraint){
        self.width = width
        self.height = height
    }
    
    public func updateBy(size:CGSize){
        width.constant = size.width
        height.constant = size.height
    }
}

public let PA_DEFAULT_MARGIN : CGFloat = 15
public let PA_DEFAULT_SIBLING_MARGIN : CGFloat = 8

public extension UIView{
    
    private func assertHasSuperview(){
        assert(superview != nil, "NO SUPERVIEW")
    }
    
    public  func pinTop(margin:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview!, attribute: .Top, multiplier: 1.0, constant: margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinLeading(margin:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: superview!, attribute: .Leading, multiplier: 1.0, constant: margin)
        c.priority  = priority
        superview?.addConstraint(c)
        return c
    }
    
  public func pinBottom(margin:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: superview!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: margin)
        c.priority  = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinTrailing(margin:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: superview!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinVertical(margin:CGFloat =  PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.top =  pinTop(margin,priority: priority)
        edgeC.bottom =  pinBottom(margin,priority: priority)
        return edgeC
    }
    
    public func pinHorizontal(margin:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.leading =  pinLeading(margin,priority: priority)
        edgeC.trailing = pinTrailing(margin,priority: priority)
        return edgeC
    }
    
    public func pinEdge(margin:UIEdgeInsets=UIEdgeInsetsZero,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
         edgeC.leading = pinLeading(margin.left,priority: priority)
        edgeC.trailing = pinTrailing(margin.right,priority: priority)
        edgeC.top =  pinTop(margin.top,priority: priority)
        edgeC.bottom = pinBottom(margin.bottom,priority: priority)
        return edgeC
    }
    
    public func pinTopLeading(top:CGFloat = PA_DEFAULT_MARGIN, leading:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.top = pinTop(top,priority: priority)
        edgeC.leading = pinLeading(leading,priority: priority)
        return edgeC
    }
    
    public func pinTopTrailing(top:CGFloat =  PA_DEFAULT_MARGIN,trailing:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.top = pinTop(top,priority: priority)
        edgeC.trailing = pinTrailing(trailing,priority: priority)
        return edgeC
    }
   
    public func pinBottomLeading(bottom:CGFloat = PA_DEFAULT_MARGIN,
        leading:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
            let edgeC = PAEdgeConstraints()
            edgeC.bottom = pinTop(bottom,priority: priority)
            edgeC.leading = pinLeading(leading,priority: priority)
            return edgeC
    }
    
    
    public func pinBottomTrailing(bottom:CGFloat = PA_DEFAULT_MARGIN,
        trailing:CGFloat = PA_DEFAULT_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> PAEdgeConstraints{
        let edgeC = PAEdgeConstraints()
        edgeC.bottom = pinTop(bottom,priority: priority)
        edgeC.trailing = pinLeading(trailing,priority: priority)
        return edgeC
    }
    
   
    private func assertIsSibling(sibling:UIView){
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
    }
    
    
    public func pinLeadingToSibling(sibling:UIView,margin:CGFloat = PA_DEFAULT_SIBLING_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: sibling, attribute: .Trailing, multiplier: 1.0, constant: margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
   
    public func pinLeadingEqualWithSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: sibling, attribute: .Leading, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinTrailingEqualWithSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: sibling, attribute: .Trailing, multiplier: 1.0, constant: -offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinTrailingToSibing(sibling:UIView,margin:CGFloat = PA_DEFAULT_SIBLING_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute:.Trailing , relatedBy: .Equal, toItem: sibling, attribute: .Leading, multiplier: 1.0, constant: -margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    
    public func pinAboveSibling(sibling:UIView,margin:CGFloat = PA_DEFAULT_SIBLING_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute:.Bottom , relatedBy: .Equal, toItem: sibling, attribute: .Top, multiplier: 1.0, constant: -margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinBelowSibling(sibling:UIView,margin:CGFloat = PA_DEFAULT_SIBLING_MARGIN,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: sibling, attribute: .Bottom, multiplier: 1.0, constant: margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinTopWithSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: sibling, attribute: .Top, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinBottomWithSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: sibling, attribute: .Bottom, multiplier: 1.0, constant: -offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    
    public func pinCenterXToSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: sibling, attribute: .CenterX, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinCenterYToSibling(sibling:UIView,offset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: sibling, attribute: .CenterY, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinWidthToSibling(sibling:UIView,multiplier:CGFloat = 1.0,constant :CGFloat = 0.0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: sibling, attribute: .Width, multiplier: multiplier, constant: constant)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinHeightToSibling(sibling:UIView,multiplier:CGFloat = 1.0,constant :CGFloat = 0.0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertIsSibling(sibling)
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: sibling, attribute: .Height, multiplier: multiplier, constant: constant)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinWidth(width:CGFloat,priority:UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    public func pinWidthGreaterThanOrEqual(width:CGFloat,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    func pinWidthLessThanOrEqual(width:CGFloat,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    func pinHeight(height:CGFloat,priority:UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    public func pinHeightGreaterThanOrEqual(height:CGFloat,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    public func pinHeightLessThanOrEqual(height:CGFloat,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    public func pinSize(size:CGSize,priority:UILayoutPriority=UILayoutPriorityRequired) -> PASizeConstraints{
        let widthC = pinWidth(size.width,priority: priority)
        let heightC = pinHeight(size.height,priority: priority)
        return PASizeConstraints(width:widthC,height:heightC)
    }
    
    public func pinCenterY(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: superview!, attribute: .CenterY, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinCenterX(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: superview!, attribute: .CenterX, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
  
    public func pinInCenterX(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: superview!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    public func pinTrailingToCenterX(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: superview!, attribute: .CenterX, multiplier: 1.0, constant: -offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinLeadingToCenterX(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: superview!, attribute: .CenterX, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinAboveCenterY(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: superview!, attribute: .CenterY, multiplier: 1.0, constant: -offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinBelowCenterY(offset:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        assertHasSuperview()
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview!, attribute: .CenterY, multiplier: 1.0, constant: offset)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
    
    public func pinCenter(xOffset :CGFloat = 0,yOffset:CGFloat = 0,priority:UILayoutPriority=UILayoutPriorityRequired) -> PACenterConstraints{
       let centerX  = pinCenterX(xOffset,priority: priority)
        let centerY = pinCenterY(yOffset,priority: priority)
        return PACenterConstraints(centerX: centerX, centerY: centerY)
    }
    
    public func pinAspectRatio(aspectRatio:CGFloat=0,priority:UILayoutPriority=UILayoutPriorityRequired) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier:aspectRatio, constant: 0)
        c.priority = priority
        self.addConstraint(c)
        return c
    }
    
    
}