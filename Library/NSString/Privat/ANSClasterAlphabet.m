//
//  ANSClasterAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSClasterAlphabet.h"

@interface ANSClasterAlphabet ()

@property (nonatomic, retain) NSArray *alphabets;
@property (nonatomic, assign) NSUInteger symbolsCount;

- (NSUInteger)symbolsCount:(NSArray *)alphabets;

@end
@implementation ANSClasterAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    self = [super init];
    if (self) {
        self.alphabets = alphabets;
        self.symbolsCount = [self symbolsCount:alphabets];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSUInteger)index {
    if (index < self.symbolsCount) {
        NSUInteger iteratedIndex = index;
        for (ANSAlphabet *alphabet in self.alphabets) {
            if (iteratedIndex < [alphabet count]) {
                return alphabet[iteratedIndex];
            }
            
            iteratedIndex -= [alphabet count];
            }
        }
        
    
    return nil;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    return [super countByEnumeratingWithState:state
                                      objects:buffer
                                        count:len];
}

#pragma mark -
#pragma mark Private

- (NSUInteger)symbolsCount:(NSArray *)alphabets {
    NSUInteger count = 0;
    for (ANSAlphabet *alphabet in self.alphabets) {
        count += [alphabet count];
    }
    
    return count;
}

@end
