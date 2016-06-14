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
@property (nonatomic, assign) NSUInteger count;

- (NSUInteger)countWithAlphabets:(NSArray *)alphabets;

@end
@implementation ANSClasterAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.alphabets = nil;
    
    [super dealloc];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    self = [super init];
    if (self) {
        self.alphabets = alphabets;
        self.count = [self countWithAlphabets:alphabets];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSInteger)index {
    NSUInteger count = self.count;
    NSUInteger iteretedIndex = index;
    
    NSAssert(index < count, NSRangeException);
    for (ANSAlphabet *alphabet in self.alphabets) {
        count = [alphabet count];
        
        if (iteretedIndex < index) {
            return ((NSArray *)alphabet)[iteretedIndex];
        }
        
        iteretedIndex -= count;
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

- (NSUInteger)countWithAlphabets:(NSArray *)alphabets {
    NSInteger count = 0;
    for (ANSAlphabet *alphabet in self.alphabets) {
        count += [alphabet count];
    }
    
    return count;
}

@end