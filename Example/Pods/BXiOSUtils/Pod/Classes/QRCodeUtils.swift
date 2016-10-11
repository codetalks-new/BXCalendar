//
//  QRCodeUtils.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/23.
//  Copyright © 2015年 xiyili. All rights reserved.
//

import UIKit


public struct QRCodeUtils {
  
  public static func generateQRCodeImage(_ text:String,imageSize:CGSize=CGSize(width: 200, height: 200)) -> UIImage?{
    if let ciImage = generateQRCode(text){
      NSLog("QRCode imageSize \(imageSize)")
      let scaleX = imageSize.width / ciImage.extent.width
      let scaleY = imageSize.height / ciImage.extent.height
      let transformedImage = ciImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
      return UIImage(ciImage:transformedImage)
    }else{
      NSLog("generateQRCode Failed \(text)")
    }
    return nil
}

public static func generateQRCode(_ text:String) -> CIImage?{
    let data = text.data(using: String.Encoding.isoLatin1, allowLossyConversion: true)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setValue(data, forKey: "inputMessage")
    filter?.setValue("Q", forKey: "inputCorrectionLevel")
    return filter?.outputImage
  }

}
