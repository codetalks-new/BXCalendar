//
//  UIFontExtensions.swift
//
//  Created by Haizhen Lee on 15/4/10.
//

import UIKit

let  bx_contentSizeCategoryIndexDict = [
    UIContentSizeCategory.extraSmall:0,
    UIContentSizeCategory.small:1,
    UIContentSizeCategory.medium:2,
    UIContentSizeCategory.large:3,
    UIContentSizeCategory.extraLarge:4,
    UIContentSizeCategory.extraExtraLarge:5,
    UIContentSizeCategory.extraExtraExtraLarge:6,
    UIContentSizeCategory.accessibilityMedium:7,
    UIContentSizeCategory.accessibilityLarge:8,
    UIContentSizeCategory.accessibilityExtraLarge:9,
    UIContentSizeCategory.accessibilityExtraExtraLarge:10,
    UIContentSizeCategory.accessibilityExtraExtraExtraLarge:11
]

public func bx_preferedContentSizeCategory() -> UIContentSizeCategory{
    return UIApplication.shared.preferredContentSizeCategory
}

public extension UIFont/*Dynamic Font Size*/{
    
    public static func bx_fontSize(_ smallestSize:CGFloat,normalSize:CGFloat,maxNormalSize:CGFloat,
        maxAccessibilitySize:CGFloat) -> CGFloat{
        let index = bx_contentSizeCategoryIndexDict[bx_preferedContentSizeCategory()] ??  2
            let fIndex = CGFloat(index)
            var size:CGFloat = 0
            switch index{
            case 0:
                size = smallestSize;
            case 1 ... 2:
                size = smallestSize + (normalSize - smallestSize) * (fIndex / 3.0 )
            case 4 ... 5:
                size = normalSize + (maxNormalSize - normalSize) * ((fIndex - 3) / 3.0 )
            case 7 ... 11:
                size = maxNormalSize + (maxAccessibilitySize - maxNormalSize) * ( (fIndex - 6) / 5.0 )
            case 12:
                size = maxAccessibilitySize
            default:
                size = normalSize
            }
        
            return round(size)
    }
}


