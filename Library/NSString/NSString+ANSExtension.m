//
//  NSString+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 09.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSString+ANSExtension.h"

static NSString * const kANSalphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

@implementation NSString (ANSExtension)

+ (instancetype)randomStrnigWithLength:(NSInteger)length {
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for (NSInteger index = 0; index < length; index ++) {
        [string appendFormat:@"%C", [kANSalphabet characterAtIndex:arc4random_uniform((u_int32_t)(length))]];
    }
    
    return [self stringWithString:string];
}

@end
