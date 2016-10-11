//
//  BasicTextInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/9.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils
import PinAuto
import Cent


open class BasicTextInputCell : StaticTableViewCell{
  open let labelLabel = UILabel(frame:CGRect.zero)
  open let textView = ExpandableTextView(frame:CGRect.zero)
  open let countLabel = UILabel(frame:CGRect.zero)
  
  
  convenience init() {
    self.init(style: .default, reuseIdentifier: "BasicTextInputCellCell")
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [textView,labelLabel,countLabel]
  }
  var allUITextViewOutlets :[UITextView]{
    return [textView]
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  

  
  open func bindLabel(_ label:String){
    labelLabel.text = label
    labelLabel.isHidden = label.isEmpty
    if label.isEmpty{
      textTopConstraint?.isActive = true
      textBelowLabelConstraint?.isActive = false
    }else{
      textTopConstraint?.isActive = false
      textBelowLabelConstraint?.isActive = true
    }
  }
  
  func commonInit(){
    staticHeight = 100
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  var textBelowLabelConstraint:NSLayoutConstraint?
  var textTopConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    labelLabel.pa_top.eq(11).install()
    labelLabel.pa_leading.eq(15).install()
    
    textView.pac_horizontal(15)
    
    textBelowLabelConstraint =  textView.pa_below(labelLabel, offset: 8).install()
    textBelowLabelConstraint?.isActive = false
    textTopConstraint = textView.pa_top.eq(12).install()
    
    countLabel.pa_below(textView, offset: 8).install()
    countLabel.pa_trailing.eq(15).install()
    countLabel.pa_bottom.eq(10).install()
    
    textView.setContentHuggingPriority(200, for: .vertical)
    
  }
  
  func setupAttrs(){
    textView.textContainerInset = UIEdgeInsets.zero
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFont(ofSize: 16)
    labelLabel.textAlignment = .left
    
    textView.setTextPlaceholderColor(FormColors.tertiaryTextColor)
    textView.setTextPlaceholderFont(UIFont.systemFont(ofSize: 15))
    textView.font = UIFont.systemFont(ofSize: 15)
    
    countLabel.textColor = FormColors.hintTextColor
    countLabel.font = UIFont.systemFont(ofSize: 14)
    
    textView.delegate = self
    
    textView.onTextDidChangeCallback = { text in
      self.countLabel.attributedText = self.createCountDownAttributedText(text)
    }
    countLabel.text = "最多\(inputMaxLength)字"
  }
  
  open func setTextPlaceholder(_ placeholder:String){
    textView.setTextPlaceholder(placeholder)
  }
  
  open var inputText:String{
    return textView.text ?? ""
  }
  
  open var inputMaxLength = 100{
    didSet{
      if inputText.isEmpty{
        countLabel.text = "最多\(inputMaxLength)字"
      }else{
        self.countLabel.attributedText = self.createCountDownAttributedText(inputText.strip())
      }
    }
  }
  
  func createCountDownAttributedText(_ text:String) -> NSAttributedString{
    let count = text.strip().length
    if count <= inputMaxLength{
      return NSAttributedString(string: "\(count)/\(inputMaxLength)")
    }else{
      let attributedText =  NSMutableAttributedString(string:"\(count)",attributes:[
        NSForegroundColorAttributeName:UIColor.red
        ])
      attributedText.append(NSAttributedString(string: "/ \(inputMaxLength)"))
      return attributedText
    }
  }
  
}


extension BasicTextInputCell: UITextViewDelegate{
  
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //NSLog("\(#function) \(range) \(text)")
    let content = textView.text ?? ""
    let currentCount = content.characters.count
    let postCount = currentCount + text.characters.count
    if range.length == 0 {
      // append
      return postCount <= inputMaxLength
    }else{
      // delete
      return true
    }
  }
}
