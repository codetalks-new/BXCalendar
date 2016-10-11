//
//  GridView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/6.
//
//

import Foundation

open class GridView:UIView{
  open fileprivate(set) var childViews:[UIView] = []
  fileprivate var _maxRows = 1{
    didSet{
      relayout()
    }
  }
  
  open var maxRows:Int{
    get{
      return _maxRows
    }set{
      if newValue > 0{
        _maxRows = newValue
      }
    }
  }
  
  convenience init(){
    self.init(frame:CGRect.zero)
    backgroundColor = .white
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open func append(_ childView:UIView){
    childViews.append(childView)
    relayout()
  }
  
  open var isFillEqually = false
  
  open var showHorizontalDivider = false{
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var showDividerMiddle = false{
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var dividerColor:UIColor = UIColor(white: 0.9367, alpha: 1.0){
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var dividerLineWidth :CGFloat = 1.0{
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var dividerInset:CGFloat = 0 {
    didSet{
      setNeedsDisplay()
    }
  }
  
  open func appendChildViewsOf(_ childViews:[UIView]){
    self.childViews.append(contentsOf: childViews)
    relayout()
  }
  
  open func updateChildViews(_ childViews:[UIView]){
    for oldChild in self.childViews{
      oldChild.removeFromSuperview()
    }
    self.childViews.removeAll()
    self.childViews.append(contentsOf: childViews)
    relayout()
  }
  
  open var fillEqual = false
  
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
 
  open var maxColCount:Int{
    return Int(ceil(Double(childViews.count) / Double(maxRows)))
  }
  
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    if fillEqual{
      fillEqualLayout()
    }
    
  }
  
  func fillEqualLayout(){
    let rows = maxRows
    let cols = maxColCount
    let lineWidth = dividerLineWidth
    let cellWidth = maxChildViewWidth
    let cellHeight = maxChildViewHeight
   
    var col = 0
    var row = 0
    var childFrame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
    for childView in childViews{
      childView.frame = childFrame

      childFrame = childFrame.offsetBy(dx: cellWidth, dy: 0)
      childFrame = childFrame.offsetBy(dx: lineWidth, dy: 0)
      col += 1
      if col >= cols{
        childFrame.origin.x = 0
        childFrame.origin.y = cellHeight + lineWidth
        col = 0
        row += 1
      }
    }
  }
  
  open func installChildViewsConstaints(){
    if fillEqual{
      return //use framelayout
    }
    var col = 0
    var row = 0
    let xMultiple: CGFloat = 1 / CGFloat(maxColCount)
    let yMultiple: CGFloat = 1 / CGFloat(maxRows)
    
    var centerXmultiple = xMultiple * 0.5
    var centerYmultiple = yMultiple * 0.5
    let maxWidth = maxChildViewWidth
    for childView in childViews{
      
      let yConstraint = NSLayoutConstraint(item: childView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: centerYmultiple * 2, constant: 0)
      
      addConstraint(yConstraint)
      
      let xConstraint = NSLayoutConstraint(item: childView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier:centerXmultiple * 2, constant: 0)
      addConstraint(xConstraint)
     
      if maxWidth > 1{
        // 如果小于1说明可能是在初始时还没有 layout 的宽度信息.所以暂不处理.
        childView.pa_width.lte(maxWidth).withHighPriority.install()
      }
      
      col += 1
      if col < maxColCount{
        centerXmultiple += xMultiple
      }else{
        col = 0
        centerXmultiple = xMultiple * 0.5
        centerYmultiple += yMultiple
        row += 1
      }
      
    }
  }
  
  open var maxChildViewWidth:CGFloat{
    return (bounds.width - CGFloat(maxColCount - 1) * dividerLineWidth) / CGFloat(maxColCount)
  }
  
  open var maxChildViewHeight:CGFloat{
    return (bounds.height - CGFloat(maxRows - 1) * dividerLineWidth) / CGFloat(maxRows)
  }
  
  open override func draw(_ rect: CGRect) {
    super.draw(rect)
    if !showDividerMiddle && !showHorizontalDivider{
      return
    }
    let rows = maxRows
    let cols = maxColCount
    
    let childViewWidth = maxChildViewWidth
    let childViewHeight = maxChildViewHeight
    
    var startY :CGFloat = rect.minY
    var startX :CGFloat = rect.minX
    
    var count = 0
    let childCount = childViews.count
    
    var col = 1
    let ctx = UIGraphicsGetCurrentContext()
    dividerColor.setStroke()
  
    let dividerHeight = childViewHeight - dividerInset * 2
    if showDividerMiddle{
      for row in 1...rows{
        startY = dividerInset + CGFloat(row - 1) * (dividerHeight + dividerLineWidth)
        for col in 1..<cols{
          startX = childViewWidth * CGFloat(col) + CGFloat(col - 1) * dividerLineWidth
          ctx?.move(to: CGPoint(x: startX, y: startY))
          ctx?.addLine(to: CGPoint(x: startX, y: startY + dividerHeight))
        }
      }
    }
  
    if showHorizontalDivider{
      startY = 0
      for row in 1..<rows{
        startY = CGFloat(row) * childViewHeight + CGFloat(row - 1) * dividerLineWidth
        ctx?.move(to: CGPoint(x: rect.minX, y: startY))
        ctx?.addLine(to: CGPoint(x: rect.maxX, y: startY))
      }
    }
   
    if showHorizontalDivider || showDividerMiddle{
      ctx?.strokePath()
    }
    
   
    
  }
}
