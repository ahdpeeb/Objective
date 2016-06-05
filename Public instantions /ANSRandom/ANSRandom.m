//
//  ANSRandom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRandom.h"

NSInteger randomIntegerBetweenMinValue(NSInteger min, NSInteger max) {
    if (max >= min) {
        return min + (arc4random_uniform((u_int32_t)(max - min + 1))) ;
    }
    
    return 0;
}

BOOL randomBool(void) {
    return arc4random_uniform(2);
}

