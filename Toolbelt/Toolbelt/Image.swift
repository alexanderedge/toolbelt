//
//  Image.swift
//  Toolbelt
//
//  The MIT License (MIT)
//
//  Copyright (c) 02/05/2015 Alexander G Edge
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import CoreGraphics

#if os(OSX)
    import AppKit.NSImage
    public typealias Image = NSImage
    
    extension Image {
        
        public convenience init?(CGImage cgImage: CGImage) {
            self.init(CGImage : cgImage, size: CGSizeZero);
        }
    
        public class func imageWithColour(colour: Colour, size: CGSize) -> Image {
            let width : size_t = Int(size.width)
            let height : size_t = Int(size.height)
            let bitsPerComponent : size_t = 8
            let bytesPerRow : size_t = 4 * width
            let colourSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue)
            let ctx = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colourSpace, bitmapInfo)
            CGContextSetFillColorWithColor(ctx, colour.CGColor)
            CGContextFillRect(ctx,CGRect(origin: CGPointZero,size:size));
            return Image(CGImage:CGBitmapContextCreateImage(ctx))!
        }
    
    }
    
#else
    import UIKit.UIImage
    public typealias Image = UIImage
    
    extension Image {
    
        public class func imageWithColour(colour:Colour, size:CGSize) -> Image {
            let rect = CGRect(origin: CGPointZero, size: size)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context = UIGraphicsGetCurrentContext();
            colour.setFill()
            CGContextFillRect(context, rect);
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    
    }
    
#endif

extension Image {
    public class func imageWithColour(colour:Colour) -> Image {
        return imageWithColour(colour, size: CGSizeMake(1, 1))
    }
}
