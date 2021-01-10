//
//  CatalogOfHouses.swift
//  DSoftMPI
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

@IBDesignable
class RoundLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat = -1
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    @IBInspectable var topInset: CGFloat = 8.0
    @IBInspectable var bottomInset: CGFloat = 8.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor.cgColor
    }
}

class RoundView: UIView {
    @IBInspectable var cornerRadius: CGFloat = -1
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor.cgColor
    }
}

class RoundButton: UIButton {
    @IBInspectable var borderWidth : CGFloat = 0
    @IBInspectable var borderColor : UIColor = UIColor.clear
    
    var updateRadius = true
    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet {
            self.updateRadius = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor.cgColor
        
        if updateRadius {
            cornerRadius = min(bounds.width, bounds.height) / 2
            updateRadius = false
        }
        self.layer.cornerRadius = (cornerRadius < 0) ? min(bounds.width, bounds.height) / 2 : cornerRadius
    }
}

class RoundField: UITextField {
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        //        self.layer.cornerRadius = self.bounds.size.height / 2.0
        
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.cornerRadius = cornerRadius
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}

class RoundTextView: UITextView {
    var updateRadius = true
    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet {
            self.updateRadius = false
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if updateRadius {
            cornerRadius = min(bounds.width, bounds.height) / 2
            updateRadius = false
        }
        self.layer.cornerRadius = (cornerRadius < 0) ? min(bounds.width, bounds.height) / 2 : cornerRadius
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor.cgColor
        
        self.textContainerInset = UIEdgeInsets.init(top: self.layer.cornerRadius / 2, left: self.layer.cornerRadius, bottom: self.layer.cornerRadius / 2, right: self.layer.cornerRadius)
        self.textContainer.lineFragmentPadding = 0
    }
}
