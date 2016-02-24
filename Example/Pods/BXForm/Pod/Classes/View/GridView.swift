//
//  GridView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/6.
//
//

import Foundation

public class GridView:UIView{
  public private(set) var childViews:[UIView] = []
  private var _maxRows = 1{
    didSet{
      relayout()
    }
  }
  
  public var maxRows:Int{
    get{
      return _maxRows
    }set{
      if newValue > 0{
        _maxRows = newValue
      }
    }
  }
  
  convenience init(){
    self.init(frame:CGRectZero)
    backgroundColor = .whiteColor()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func append(childView:UIView){
    childViews.append(childView)
    relayout()
  }
  
  
  
  public var showDividerMiddle = false{
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var dividerColor:UIColor = UIColor(white: 0.9367, alpha: 1.0){
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var dividerLineWidth :CGFloat = 1.0{
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var dividerInset:CGFloat = 0 {
    didSet{
      setNeedsDisplay()
    }
  }
  
  public func appendChildViewsOf(childViews:[UIView]){
    self.childViews.appendContentsOf(childViews)
    relayout()
  }
  
  public func updateChildViews(childViews:[UIView]){
    for oldChild in self.childViews{
      oldChild.removeFromSuperview()
    }
    self.childViews.removeAll()
    self.childViews.appendContentsOf(childViews)
    relayout()
  }
  
  
  func relayout(){
    for childView in childViews{
      childView.removeFromSuperview()
    }
    installChildViews()
    installChildViewsConstaints()
  }
 
  func installChildViews(){
    for childView in childViews{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
  }
 
  public var maxColCount:Int{
    return Int(ceil(Double(childViews.count) / Double(maxRows)))
  }
  
  public func installChildViewsConstaints(){
    var col = 0
    var row = 0
    let xMultiple: CGFloat = 1 / CGFloat(maxColCount)
    let yMultiple: CGFloat = 1 / CGFloat(maxRows)
    
    var centerXmultiple = xMultiple * 0.5
    var centerYmultiple = yMultiple * 0.5
    
    for childView in childViews{
      
      let yConstraint = NSLayoutConstraint(item: childView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: centerYmultiple * 2, constant: 0)
      
      addConstraint(yConstraint)
      
      let xConstraint = NSLayoutConstraint(item: childView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier:centerXmultiple * 2, constant: 0)
      addConstraint(xConstraint)
      
      col++
      if col < maxColCount{
        centerXmultiple += xMultiple
      }else{
        col = 0
        centerXmultiple = xMultiple * 0.5
        centerYmultiple += yMultiple
        row++
      }
      
    }
  }
  
  public var maxChildViewWidth:CGFloat{
    return (bounds.width - CGFloat(maxColCount - 1) * dividerLineWidth) / CGFloat(maxColCount)
  }
  
  public var maxChildViewHeight:CGFloat{
    return (bounds.height / CGFloat(maxRows))
  }
  
  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    if !showDividerMiddle{
      return
    }
    let childViewWidth = maxChildViewWidth
    let childViewHeight = maxChildViewHeight
    
    var startY :CGFloat = rect.minY
    var startX :CGFloat = rect.minX
    
    var count = 0
    let childCount = childViews.count
    
    var col = 1
    let ctx = UIGraphicsGetCurrentContext()
    dividerColor.setStroke()
    repeat{
      if col < maxColCount{
        startX = startX + childViewWidth
        CGContextMoveToPoint(ctx,startX, startY + dividerInset)
        CGContextAddLineToPoint(ctx, startX, startY + childViewHeight - dividerInset)
      }else{
        startY = startY + childViewHeight
        col = 1
      }
      col++
      count++
    }while (count < childCount )
   
    CGContextStrokePath(ctx)
    
  }
}