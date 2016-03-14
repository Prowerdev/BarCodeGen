//
//  BarcodeGenerationClass.h
//  BarCodeGenerator
//
//  Created by Panda, Debasish on 14/03/16.
//  Copyright © 2016 Panda, Debasish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConstantsEnums.h"

@interface BarcodeGenerationClass : NSObject
//@property (nonatomic) BarcodeEnum barcodeEnum;

+ (UIImage *)returnBarcodeImageForBarcodeFormat:(BarcodeType)barcodeEnum forBarcodeString:(NSString *)barcodeString forSize:(CGSize)barcodeImageSize;


@end
