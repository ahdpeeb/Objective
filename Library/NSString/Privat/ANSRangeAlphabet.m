//
//  ANSRangeAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRangeAlphabet.h"

#import "NSObject+ANSExtension.h"

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
    
    state->mutationsPtr = (unsigned long *)self;
    NSUInteger count = self.count;
    if (state->state >= count) {
        return 0;
    }
    
    id objects[count];
    *objects = malloc(sizeof(id) * count);
    
    for (NSUInteger index = 0; index < count; index ++) {
        NSString *symbol = [self stringAtIndex:index];
        objects[index] = symbol;
    }
    
    __unused NSInteger value = sizeof(objects); // test
    state->itemsPtr = objects;
    state->state = count;
    
    return count;
}
    
@end
