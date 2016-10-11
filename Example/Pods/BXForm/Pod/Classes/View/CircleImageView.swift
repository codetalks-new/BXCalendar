//
//  CircleImageView.swift
//
//  Created by Haizhen Lee on 14/12/10.
//

import UIKit

//@IBDesignable // reduce performance
open class CircleImageView: UIImageView {
  
  //    @IBInspectable
  open var borderWidth:CGFloat=3.0{
    didSet{
      updateBorderStyle()
    }
  }
  
  //    @IBInspectable
  open var borderColor:UIColor=UIColor(white: 0.5, alpha: 0.5){
    didSet{
      updateBorderStyle()
    }
  }
  

  
  open func updateBorderStyle(){
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }
  
  func commonInit(){
    layer.cornerRadius = frame.size.width * 0.5
    clipsToBounds = true
    updateBorderStyle()
  }
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
  }()
  
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.width * 0.5
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(ovalIn:bounds.insetBy(dx: borderWidth, dy: borderWidth)).cgPath
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override open func awakeFromNib() {
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
