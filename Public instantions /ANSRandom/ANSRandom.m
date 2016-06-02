//
//  ANSRandom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRandom.h"

@implementation ANSRandom

+ (NSInteger)randomIntegerBetweenMinValue:(NSInteger)min
                                 maxValue:(NSInteger)max
{
    if (max >= min) {
        return min + (arc4random () %max - min + 1) ;
    }
    
    return 0;
}

+ (BOOL)randomBool {
    return arc4random_uniform(2);
}

@end
