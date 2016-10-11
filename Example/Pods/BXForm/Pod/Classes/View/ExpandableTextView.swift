/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

open class ExpandableTextView: UITextView {

    fileprivate let placeholder: UITextView = UITextView()
  
    public init(frame: CGRect) {
      super.init(frame: frame, textContainer: nil)
      commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override open var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.onContentSizeChangedCallback?(contentSize)
            self.layoutIfNeeded() // needed?
        }
    }
  
    open var onContentSizeChangedCallback:( (CGSize) -> Void )?
    open var onTextDidChangeCallback: ((String) -> Void)?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(ExpandableTextView.textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        self.configurePlaceholder()
        self.updatePlaceholderVisibility()
    }


    override open func layoutSubviews() {
        super.layoutSubviews()
        self.placeholder.frame = self.bounds
    }

    override open var intrinsicContentSize : CGSize {
        return self.contentSize
    }

    override open var text: String! {
        didSet {
            self.textDidChange()
        }
    }

    override open var textContainerInset: UIEdgeInsets {
        didSet {
            self.configurePlaceholder()
        }
    }

    override open var textAlignment: NSTextAlignment {
        didSet {
            self.configurePlaceholder()
        }
    }

    open func setTextPlaceholder(_ textPlaceholder: String) {
        self.placeholder.text = textPlaceholder
    }

    open func setTextPlaceholderColor(_ color: UIColor) {
        self.placeholder.textColor = color
    }

    open func setTextPlaceholderFont(_ font: UIFont) {
        self.placeholder.font = font
    }

    func textDidChange() {
        self.updatePlaceholderVisibility()
        self.scrollToCaret()
        onTextDidChangeCallback?(text)
    }

    fileprivate func scrollToCaret() {
        if selectedTextRange != nil {
            var rect = caretRect(for: self.selectedTextRange!.end)
            rect = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height + textContainerInset.bottom))

            self.scrollRectToVisible(rect, animated: false)
        }
    }

    fileprivate func updatePlaceholderVisibility() {
        if text == "" {
            self.showPlaceholder()
        } else {
            self.hidePlaceholder()
        }
    }

    fileprivate func showPlaceholder() {
        self.addSubview(placeholder)
    }

    fileprivate func hidePlaceholder() {
        self.placeholder.removeFromSuperview()
    }

    fileprivate func configurePlaceholder() {
        self.placeholder.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder.isEditable = false
        self.placeholder.isSelectable = false
        self.placeholder.isUserInteractionEnabled = false
        self.placeholder.textAlignment = textAlignment
        self.placeholder.textContainerInset = textContainerInset
        self.placeholder.backgroundColor = UIColor.clear
    }
}
