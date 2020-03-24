//
//  UIImage+RemoveStatusBar.swift
//  Pods-UIUtils_Example
//
//  Created by Artem Kufaev on 18.03.2020.
//

import UIKit

extension UIImage {
    
    public var removingStatusBar: UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        var yOffset: CGFloat = 0
        if (!UIDevice.current.isXFamily) {
            yOffset = 22 * scale
        } else if (UIDevice.current.isIPhoneX) {
            yOffset = 44 * scale
        } else if (UIDevice.current.isIPhoneX_Max || UIDevice.current.isIPhoneXR) {
            yOffset = 48.6 * scale
        }
        let rect = CGRect(
            x: 0,
            y: Int(yOffset),
            width: cgImage.width,
            height: cgImage.height - Int(yOffset)
        )
        
        if let croppedCGImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        }
        
        return nil
    }
    
}
