//
//  UIFontExtensions.swift
//
//  Created by Haizhen Lee on 15/4/10.
//

import UIKit

let  bx_contentSizeCategoryIndexDict = [
    UIContentSizeCategoryExtraSmall:0,
    UIContentSizeCategorySmall:1,
    UIContentSizeCategoryMedium:2,
    UIContentSizeCategoryLarge:3,
    UIContentSizeCategoryExtraLarge:4,
    UIContentSizeCategoryExtraExtraLarge:5,
    UIContentSizeCategoryExtraExtraExtraLarge:6,
    UIContentSizeCategoryAccessibilityMedium:7,
    UIContentSizeCategoryAccessibilityLarge:8,
    UIContentSizeCategoryAccessibilityExtraLarge:9,
    UIContentSizeCategoryAccessibilityExtraExtraLarge:10,
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:11
]

public func bx_preferedContentSizeCategory() -> String{
    return UIApplication.sharedApplication().preferredContentSizeCategory
}

public extension UIFont/*Dynamic Font Size*/{
    
    public static func bx_fontSize(smallestSize:CGFloat,normalSize:CGFloat,maxNormalSize:CGFloat,
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


