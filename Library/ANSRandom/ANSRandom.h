//
//  ANSRandom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    NSInteger min;
    NSInteger max;
} ANSIntegerRange;

static inline 
ANSIntegerRange ANSIntegerRangeCreate(NSInteger firstValue, NSInteger secondValue) {
    ANSIntegerRange range;
    range.min = MIN(firstValue, secondValue);
    range.max = MAX(firstValue, secondValue);
    
    return range;
}

NSInteger ANSRandomIntegerWithRange(NSInteger min, NSInteger max);

BOOL ANSRandomBool(void);

