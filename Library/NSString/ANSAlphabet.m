//
//  ANSAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAlphabet.h"

#import "ANSRAngeAlphabet.h"
#import "ANSClasterAlphabet.h"
#import "ANSStringAlphabet.h"

#import "NSString+ANSExtension.h"

@implementation ANSAlphabet

#pragma mark -
#pragma mark Class methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[ANSRAngeAlphabet alloc] initWithRange:range] autorelease];
}
+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[ANSStringAlphabet alloc] initWithStrings:strings] autorelease];
}
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabers {
    return [[[ANSClasterAlphabet alloc] initWithAlphabets:alphabers] autorelease];
}
+ (instancetype)alphabetWithCharacters:(NSString *)strings {
    return [[[ANSStringAlphabet alloc] initWithStrings:[strings symbols]] autorelease];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    ANSAlphabet *result = [[ANSRAngeAlphabet alloc] initWithRange:range];
    
    return result;
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    ANSAlphabet *result = [[ANSClasterAlphabet alloc] initWithAlphabets:alphabets];
    
    return result;
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    ANSAlphabet *result = [[ANSStringAlphabet alloc] initWithStrings:strings];
    
    return result;
}

- (instancetype)initWithSymbols:(NSString *)string {
    [self release];
    
    ANSAlphabet *result = [self initWithStrings:[string symbols]];
    
    return result;
}

#pragma mark -
#pragma mark Public methods


- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)stringAtIndex:(NSInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)objectAtIndexSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                  count:(NSUInteger)len
{

    return 0;
}

@end
