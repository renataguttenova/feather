//
//  UIFont+FeatherFonts.m
//  Feather
//
//  Created by Renata Guttenová on 24/07/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "UIFont+FeatherFonts.h"

@implementation UIFont (FeatherFonts)

+ (UIFont *)nunitoBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Nunito-Bold" size:size];
}

+ (UIFont *)nunitoLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Nunito-Light" size:size];
}

+ (UIFont *)nunitoRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Nunito-Regular" size:size];
}

@end
