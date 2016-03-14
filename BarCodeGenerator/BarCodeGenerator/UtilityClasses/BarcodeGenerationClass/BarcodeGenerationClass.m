//
//  BarcodeGenerationClass.m
//  BarCodeGenerator
//
//  Created by Panda, Debasish on 14/03/16.
//  Copyright © 2016 Panda, Debasish. All rights reserved.
//

#import "BarcodeGenerationClass.h"

@implementation BarcodeGenerationClass

+ (UIImage *)returnBarcodeImageForBarcodeFormat:(BarcodeType)barcodeEnum forBarcodeString:(NSString *)barcodeString forSize:(CGSize)barcodeImageSize
{
    UIImage *barCodeImage = nil;
    if (barcodeEnum == kUpcaBarcode) {
        barCodeImage = [self getUPCABarcodeImageFromString:barcodeString withSize:barcodeImageSize];
        
    }
    return barCodeImage;
}

+ (UIImage *)getUPCABarcodeImageFromString:(NSString *)barcodeString withSize:(CGSize)barcodeImageSize
{
    NSInteger barcodeStringLength = (int)barcodeString.length;
    CGFloat x = 5; // Left Margin
    CGFloat y = 0; // Top Margin
    // bar width is decided by dividing total width by total number of bars
    // Each digit takes 7 unit space and 11 unit space added as 3 at the start, 5 in middle and 3 at end
    CGFloat barWidth = ((barcodeImageSize.width - 10)/(barcodeStringLength * 7 + 11));
    NSString *barcodeEncodedString = @"101"; // Encoding string for starting and ending mark bar-space-bar (its format of code UPCA barcode)
    NSString *superSetBarcodeString = @"0123456789"; // UPCA numerics
    
    NSString* codeUPCAStringArray1[] = //Encoding strings for CodeUPCA alphabets
    {
        /* 0 */ @"3211",
        /* 1 */ @"2221",
        /* 2 */ @"2122",
        /* 3 */ @"1411",
        /* 4 */ @"1132",
        /* 5 */ @"1231",
        /* 6 */ @"1114",
        /* 7 */ @"1312",
        /* 8 */ @"1213",
        /* 9 */ @"3112"
    };
    
    // Calculate graphic size
    CGSize size = CGSizeMake(barcodeImageSize.width, barcodeImageSize.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill background color (transparent)
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.0);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.0);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, size.width, size.height));
    
    // Begin encoding
    for (NSInteger i = 0; i < 6; i++)
    {
        // Check for illegal characters
        char c = [barcodeString characterAtIndex:i];
        long index = [superSetBarcodeString rangeOfString:[NSString stringWithFormat:@"%c",c]].location;
        if (index == NSNotFound)
        {
            NSLog(@"Barcode contains invalid characters");
            return nil;
        }
        // Get and concat encoding string
        barcodeEncodedString = [NSString stringWithFormat:@"%@%@",barcodeEncodedString, codeUPCAStringArray1[index]];
    }
    
    // Add middle character space-bar-space-bar-space
    barcodeEncodedString = [NSString stringWithFormat:@"%@01010", barcodeEncodedString];
    for (NSInteger i = 6; i < 12; i++)
    {
        // Check for illegal characters
        char c = [barcodeString characterAtIndex:i];
        long index = [superSetBarcodeString rangeOfString:[NSString stringWithFormat:@"%c",c]].location;
        if (index == NSNotFound)
        {
            NSLog(@"Barcode contains invalid characters");
            return nil;
        }
        // Get and concat encoding string
        barcodeEncodedString = [NSString stringWithFormat:@"%@%@",barcodeEncodedString, codeUPCAStringArray1[index]];
    }
    
    // Pad ending with bar-space-bar (its format of UPCA barcode)
    barcodeEncodedString = [NSString stringWithFormat:@"%@101", barcodeEncodedString];
    NSInteger barcodeEncodedStringLength = (NSInteger)barcodeEncodedString.length; // final encoded data length
    CGFloat barWidthForChar;
    
    // Draw UPCA BarCode according the the encoded data
    for (NSInteger i = 0; i < barcodeEncodedStringLength; i++)
    {
        NSString *charString = [barcodeEncodedString substringWithRange:NSMakeRange(i, 1)];
        NSInteger charInt = [charString integerValue];
        if (charInt > 1)
        {
            barWidthForChar = barWidth * charInt;
        }
        else
        {
            barWidthForChar = barWidth;
        }
        // Draw barcode lines with specified color
        if (i % 2 == 0) {
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
            CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
        }
        // Draw with transparent color
        else {
            CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.0);
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.0);
        }
        
        CGContextFillRect(context, CGRectMake(x, y, barWidthForChar, barcodeImageSize.height));
        x += barWidthForChar;
    }
    
    // Get image from context and return
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end
