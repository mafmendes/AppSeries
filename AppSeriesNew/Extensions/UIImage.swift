//
//  UIImage.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 07/06/2022.
//

import Foundation
import UIKit
extension UIImage {

    func trim() -> UIImage {
        let newRect = self.cropRect
        if let imageRef = self.cgImage!.cropping(to: newRect) {
            return UIImage(cgImage: imageRef)
        }
        return self
    }

    var cropRect: CGRect {
        let cgImage = self.cgImage
        let context = createARGBBitmapContextFromImage(inImage: cgImage!)
        if context == nil {
            return CGRect.zero
        }

        let height = CGFloat(cgImage!.height)
        let width = CGFloat(cgImage!.width)

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context?.draw(cgImage!, in: rect)

        guard let data = context?.data?.assumingMemoryBound(to: UInt8.self) else {
            return CGRect.zero
        }

        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0

        let heightInt = Int(height)
        let widthInt = Int(width)
        // Filter through data and look for non-transparent pixels.
        for yforLopp in (0 ..< heightInt) {
            let yvar = CGFloat(yforLopp)
            for xforLopp in (0 ..< widthInt) {
                let xvar = CGFloat(xforLopp)
                let pixelIndex = (width * yvar + xvar) * 4 /* 4 for A, R, G, B */

                if data[Int(pixelIndex)] == 0 { continue } // crop transparent

                if data[Int(pixelIndex+1)] > 0xE0 && data[Int(pixelIndex+2)] > 0xE0
                    && data[Int(pixelIndex+3)] > 0xE0 { continue } // crop white

                if xvar < lowX {
                    lowX = xvar
                }
                if xvar > highX {
                    highX = xvar
                }
                if yvar < lowY {
                    lowY = yvar
                }
                if yvar > highY {
                    highY = yvar
                }

            }
        }

        return CGRect(x: lowX, y: lowY, width: highX - lowX, height: highY - lowY)
    }

    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {

        let width = inImage.width
        let height = inImage.height

        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }

        let context = CGContext(data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8,      // bits per component
            bytesPerRow: bitmapBytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)

        return context
    }
}
