//
//  UIView+SplitAutoLayout.swift
//  Pods
//
//  Created by Haizhen Lee on 15/9/30.
//
//

import UIKit

public let PA_DEFAULT_PADDING : CGFloat = 8

public enum PAHorizontalAlign:Int{
    case Left
    case Middle
    case Right
    
    var alignKey:String{
        switch self{
        case .Left:
            return "L"
        case .Middle:
            return "M"
        case .Right:
            return "R"
        }
    }
}

public enum PAVerticalAlign:Int{
    case Top
    case Middle
    case Bottom
    
    var alignKey:String{
        switch self{
        case .Top:
            return "T"
        case .Middle:
            return "M"
        case .Bottom:
            return "M"
        }
    }
}


public enum PALayoutOrientation:Int{
    case Horizontal
    case Vertical
}

public struct PALayoutParams{
    var margin = UIEdgeInsetsZero
    var innerSpace:CGFloat = PA_DEFAULT_SIBLING_MARGIN
    var orientation = PALayoutOrientation.Horizontal
    var horizontalAlign = PAHorizontalAlign.Middle
    var verticalAlign = PAVerticalAlign.Middle
    
    public init(orientation:PALayoutOrientation = .Horizontal,horizontalAlign:PAHorizontalAlign = .Middle
        ,verticalAlign:PAVerticalAlign = .Middle
        ,margin:UIEdgeInsets = UIEdgeInsetsZero,innerSpace:CGFloat = PA_DEFAULT_SIBLING_MARGIN){
            self.orientation = orientation
            self.horizontalAlign = horizontalAlign
            self.verticalAlign = verticalAlign
            self.margin = margin
            self.innerSpace = innerSpace
    }
    
    
    public var alignKey:String{
       return "\(horizontalAlign.alignKey)\(verticalAlign.alignKey)"
    }
    
}


public extension UIView{
    
    public func batchAddSubviews(subviews:[UIView]) -> Self{
        for subview in subviews{
            addSubview(subview)
        }
        
        return self
    }
    
    public func batchDisableTranslatesAutoresizingMaskIntoConstraints(views:[UIView]){
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func assertSubviews(views:[UIView]){
        assert(views.count > 0, "Subviews is Empty")
        for subview in views{
            assert(subview.superview == self, "No such subview \(subview)")
        }
    }
    
   public func splitVerticalForSubviews(subviews:[UIView], withInsets insets:UIEdgeInsets = UIEdgeInsetsZero,withSpace space:CGFloat = PA_DEFAULT_PADDING) -> PAEdgeConstraints {
       assertSubviews(subviews)
        let topView = subviews.first!
        let bottomView = subviews.last!
        let edgeC = PAEdgeConstraints()
        edgeC.leading =  topView.pinLeading(insets.left)
        edgeC.trailing = topView.pinTrailing(insets.right)
        edgeC.top = topView.pinTop(insets.top)
        edgeC.bottom = bottomView.pinBottom(insets.bottom)
        
        var childViews = subviews
        let previousView = childViews.removeAtIndex(0)
        while !childViews.isEmpty{
           let sibling = childViews.removeAtIndex(0)
            sibling.pinWidthToSibling(topView)
            sibling.pinHeightToSibling(topView)
            sibling.pinCenterXToSibling(topView)
            sibling.pinBelowSibling(previousView,margin:space)
        }
        return edgeC
    }
   
    public func splitHorizontalForSubviews(subviews:[UIView], withInsets insets:UIEdgeInsets = UIEdgeInsetsZero,withSpace space:CGFloat = PA_DEFAULT_PADDING) -> PAEdgeConstraints {
        assertSubviews(subviews)
        let leadingView = subviews.first!
        let trailingView = subviews.last!
        let edgeC = PAEdgeConstraints()
        edgeC.leading =  leadingView.pinLeading(insets.left)
        edgeC.trailing = trailingView.pinTrailing(insets.right)
        edgeC.top = leadingView.pinTop(insets.top)
        edgeC.bottom = leadingView.pinBottom(insets.bottom)
        
        var childViews = subviews
        while !childViews.isEmpty{
            let sibling = childViews.removeAtIndex(0)
            sibling.pinWidthToSibling(leadingView)
            sibling.pinHeightToSibling(leadingView)
            sibling.pinCenterYToSibling(leadingView)
            sibling.pinLeadingToSibling(leadingView, margin: space)
        }
        return edgeC
    }
    
    public func layoutSubviewsHorizontalToCenter(subviews:[UIView]){
        layoutSubviews(subviews,layoutParams:PALayoutParams())
    }
    
    
    public func layoutSubviews(subviews:[UIView],layoutParams:PALayoutParams){
        if subviews.isEmpty{
            NSLog("WARN alignSubviews is empty")
            return
        }
        assertSubviews(subviews)
        
        let childCount = subviews.count
        var prevView:UIView?
        var nextView:UIView?
        var leftEndIndex = 0
        var nextStartIndex = Int.max
        let isHorizontalLayout = layoutParams.orientation == PALayoutOrientation.Horizontal
        let isVerticalLayout = layoutParams.orientation == PALayoutOrientation.Vertical
        let verticalAlign = layoutParams.verticalAlign
        let horizontalAlign = layoutParams.horizontalAlign
        let innerSpace = layoutParams.innerSpace
        let margin = layoutParams.margin
       
        if  isHorizontalLayout {
            // y aix
            for childView in subviews{
                switch verticalAlign{
                case .Top:
                    childView.pinTop(margin.top)
                case .Middle:
                    childView.pinCenterY()
                case .Bottom:
                    childView.pinBottom(margin.bottom)
                }
            }
            
        }else{
            // Vertical
            
            for childView in subviews{
                switch horizontalAlign{
                case .Left:
                    childView.pinLeading(margin.left)
                case .Middle:
                    childView.pinCenterX()
                case .Right:
                    childView.pinTrailing(margin.right)
                }
            }
        }
        
        
        if horizontalAlign == PAHorizontalAlign.Left && isHorizontalLayout
            || verticalAlign == PAVerticalAlign.Top && isVerticalLayout{
            leftEndIndex = 0
            nextStartIndex = 0
            nextView = subviews.first
            if isHorizontalLayout{
                nextView?.pinLeading(margin.left)
            }else{
                nextView?.pinTop(margin.top)
            }
        }
        if horizontalAlign == PAHorizontalAlign.Right && isHorizontalLayout
            || verticalAlign == PAVerticalAlign.Bottom && isVerticalLayout{
            leftEndIndex = subviews.count - 1
            nextStartIndex = subviews.count - 1
            prevView = subviews.last
            
            if isHorizontalLayout{
                prevView?.pinTrailing(margin.right)
            }else{
                prevView?.pinBottom(margin.bottom)
            }
            
        }
        
        if horizontalAlign == PAHorizontalAlign.Middle && isHorizontalLayout
            || verticalAlign == PAVerticalAlign.Middle && isVerticalLayout{
            if childCount % 2 != 0 {
                // even
                let median = (childCount + 1) / 2 - 1
                leftEndIndex = median
                nextStartIndex = median
                let medianView = subviews[median]
                prevView = medianView
                nextView = medianView
                if isHorizontalLayout{
                    medianView.pinCenterX()
                }else{
                    medianView.pinCenterY()
                }
            }else{
                
                
                let mid = childCount / 2
                leftEndIndex = mid - 1
                nextStartIndex = mid
                let midLeftView = subviews[leftEndIndex]
                let midRightView = subviews[nextStartIndex]
                
                prevView = midLeftView
                nextView = midRightView
                let halfSpace = innerSpace * 0.5
                if isHorizontalLayout{
                    midLeftView.pinTrailingToCenterX(halfSpace)
                    midRightView.pinLeadingToCenterX(halfSpace)
                }else{
                    midLeftView.pinAboveCenterY(halfSpace)
                    midRightView.pinBelowCenterY(halfSpace)
                }
            }
            
        }
        
        for var index = leftEndIndex - 1 ; index > -1 ;index-- {
            let view = subviews[index]
            if let prevView = prevView{
                if isHorizontalLayout{
                    view.pinTrailingToSibing(prevView , margin:innerSpace)
                }else{
                    view.pinAboveSibling(prevView,margin:innerSpace)
                }
            }
            prevView = view
        }
        
        for var index = nextStartIndex + 1;index < childCount;index++ {
            let view = subviews[index]
            if let nextView = nextView{
                if isHorizontalLayout{
                    view.pinLeadingToSibling(nextView,margin:innerSpace)
                }else{
                    view.pinBelowSibling(nextView,margin:innerSpace)
                }
            }
            
            nextView = view
        }
        
        

        
    }
    
    public func alignSubviewsToVerticalCenter(subviews:[UIView], withInsets insets:UIEdgeInsets = UIEdgeInsetsZero,withSpace space:CGFloat = PA_DEFAULT_PADDING) -> PAEdgeConstraints {
        assertSubviews(subviews)
        let leadingView = subviews.first!
        let trailingView = subviews.last!
        let edgeC = PAEdgeConstraints()
        edgeC.leading =  leadingView.pinLeading(insets.left)
        edgeC.trailing = trailingView.pinTrailing(insets.right)
        edgeC.top = leadingView.pinTop(insets.top)
        edgeC.bottom = leadingView.pinBottom(insets.bottom)
        
        var childViews = subviews
        while !childViews.isEmpty{
            let sibling = childViews.removeAtIndex(0)
            sibling.pinWidthToSibling(leadingView)
            sibling.pinHeightToSibling(leadingView)
            sibling.pinCenterYToSibling(leadingView)
            sibling.pinLeadingToSibling(leadingView, margin: space)
        }
        return edgeC
    }
    
    
}
