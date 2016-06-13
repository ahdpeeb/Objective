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
#pragma mark Public

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSInteger)index {
    NSRange range = self.range;
    
    return [NSString stringWithFormat:@"%c",(char)(range.location + index)];
}

@end
