//
//  ANSRangeAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRangeAlphabet.h"

@interface ANSRangeAlphabet ()
@property (nonatomic, assign) NSRange range;

@end

@implementation ANSRangeAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    if (self) {
        self.range = range;
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.range.length;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%c", (unichar)(self.range.location + index)];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    BOOL firsCycle = YES;
    state->mutationsPtr = 0;

    NSUInteger elementsCount = self.range.length;
    if (elementsCount == 0) {
        return 0;
    }
    
    if (firsCycle) {
        state->state = self.range.location;
        firsCycle = NO;
    }
    
    NSUInteger value = MIN(state->state + len, NSMaxRange(self.range));
    len = value - state->state;
    
    for (NSUInteger index = state->state; index < value; index ++) {
        buffer[index] = self[index]; // self.range.location + index
    }
    
    state->state += (value - state->state);
    
    return len;
}

@end
