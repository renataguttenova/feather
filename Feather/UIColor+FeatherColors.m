//
//  UIColor+FeatherColors.m
//  Feather
//
//  Created by Renata Guttenová on 24/07/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "UIColor+FeatherColors.h"

@implementation UIColor (FeatherColors)

+ (UIColor *)tealLight {
    return [UIColor colorFromHexString:@"#1abc9c"];
}

+ (UIColor *)tealDark {
    return [UIColor colorFromHexString:@"#16a085"];
}

+ (UIColor *)greenLight {
    return [UIColor colorFromHexString:@"#2ecc71"];
}

+ (UIColor *)greenDark {
    return [UIColor colorFromHexString:@"#27ae60"];
}

+ (UIColor *)blueLight {
    return [UIColor colorFromHexString:@"#3498db"];
}

+ (UIColor *)blueDark {
    return [UIColor colorFromHexString:@"#2980b9"];
}

+ (UIColor *)purpleLight {
    return [UIColor colorFromHexString:@"#9b59b6"];
}

+ (UIColor *)purpleDark {
    return [UIColor colorFromHexString:@"#8e44ad"];
}

+ (UIColor *)yellowLight {
    return [UIColor colorFromHexString:@"#f1c40f"];
}

+ (UIColor *)yellowDark {
    return [UIColor colorFromHexString:@"#f39c12"];
}

+ (UIColor *)orangeLight {
    return [UIColor colorFromHexString:@"#e67e22"];
}

+ (UIColor *)orangeDark {
    return [UIColor colorFromHexString:@"#d35400"];
}

+ (UIColor *)redLight {
    return [UIColor colorFromHexString:@"#e74c3c"];
}

+ (UIColor *)redDark {
    return [UIColor colorFromHexString:@"#c0392b"];
}

+ (UIColor *)offWhite {
    return [UIColor colorFromHexString:@"#ecf0f1"];
}

+ (UIColor *)grayLight {
    return [UIColor colorFromHexString:@"#bdc3c7"];
}

+ (UIColor *)gray {
    return [UIColor colorFromHexString:@"#95a5a6"];
}

+ (UIColor *)grayDark {
    return [UIColor colorFromHexString:@"#7f8c8d"];
}

+ (UIColor *)grayDarker {
    return [UIColor colorFromHexString:@"#34495e"];
}

+ (UIColor *)grayDarkest {
    return [UIColor colorFromHexString:@"#2c3e50"];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
