//
//  CircleImageView.swift
//
//  Created by Haizhen Lee on 14/12/10.
//

import UIKit

//@IBDesignable // reduce performance
public class CircleImageView: UIImageView {
  
  //    @IBInspectable
  public var borderWidth:CGFloat=3.0{
    didSet{
      updateBorderStyle()
    }
  }
  
  //    @IBInspectable
  public var borderColor:UIColor=UIColor(white: 0.5, alpha: 0.5){
    didSet{
      updateBorderStyle()
    }
  }
  

  
  public func updateBorderStyle(){
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.CGColor
  }
  
  func commonInit(){
    layer.cornerRadius = frame.size.width * 0.5
    clipsToBounds = true
    updateBorderStyle()
  }
  
  public lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
  }()
  
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.width * 0.5
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(ovalInRect:bounds.insetBy(dx: borderWidth, dy: borderWidth)).CGPath
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  public override init(image: UIImage?) {
    super.init(image: image)
    commonInit()
  }
  
  public override init(image: UIImage?, highlightedImage: UIImage?) {
    super.init(image: image, highlightedImage: highlightedImage)
    commonInit()
  }
  
}
