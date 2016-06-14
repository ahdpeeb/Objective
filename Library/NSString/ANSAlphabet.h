//
//  ANSAlphabet.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

NSRange ANSCreateAlphabetRange(unsigned char value1,unsigned char value2);

@interface ANSAlphabet : NSObject <NSFastEnumeration>
+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithStrings:(NSArray *)strings;
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabers;
+ (instancetype)alphabetWithCharacters:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)string;

- (NSUInteger)count;
- (NSString *)stringAtIndex:(NSInteger)index;

- (NSString *)objectAtIndexSubscript:(NSUInteger)index;

- (NSString *)string;

@end
