//
//  ANSRandom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRandom.h"

typedef struct {
    NSInteger min;
    NSInteger max;
} ANSIntegerRange;

#pragma mark -
#pragma mark Private declaration

ANSIntegerRange ANSIntegerRangeCreate(NSInteger firstValue, NSInteger secondValue);

#pragma mark -
#pragma mark Public implementation

NSInteger ANSRandomIntegerWithRange(NSInteger min, NSInteger max) {
    ANSIntegerRange range = ANSIntegerRangeCreate(min, max);
    
    return range.min + (arc4random_uniform((u_int32_t)(range.max- range.min + 1))) ;
}

BOOL ANSRandomBool(void) {
    return arc4random_uniform(2);
}

#pragma mark -
#pragma mark Private implementation

ANSIntegerRange ANSIntegerRangeCreate(NSInteger firstValue, NSInteger secondValue) {
    ANSIntegerRange range;
    range.min = MIN(firstValue, secondValue);
    range.max = MAX(firstValue, secondValue);
    
    return range;
}
