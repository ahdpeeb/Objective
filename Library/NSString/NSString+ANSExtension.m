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

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for (NSUInteger index = 0; index < length; index ++) {
        [string appendFormat:@"%c", [kANSalphabet characterAtIndex:arc4random_uniform((u_int32_t)length)]];
    }
    
    return [self stringWithString:string];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = range.location; character < NSMaxRange(range); character ++) {
        [result appendFormat:@"%c",character];
    }
    
    return [self stringWithString:result];
}

+ (instancetype)alphanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self letterAlphabet]];
    [result appendString:[self numericAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('0', '9' - '0')];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('a', 'z' - 'a')];
}

+ (instancetype)capitalizedLetterAlphabet {
   return [self alphabetWithUnicodeRange:NSMakeRange('A', 'Z' - 'A')];
}

+ (instancetype)letterAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self lowercaseLetterAlphabet]];
    [result appendString:[self capitalizedLetterAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length
                              alphabet:(NSString *)alphabet {
    
    return nil;
}

- (NSArray *)symbols {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.length];
    NSUInteger length = [self length];
    
    for (NSUInteger index = 0; index < length; index ++) {
        unichar resultChar = [self characterAtIndex:index];
        [result addObject:[NSString stringWithFormat:@"%c", resultChar]];
    }
    
    return [[result copy] autorelease];
}

@end
