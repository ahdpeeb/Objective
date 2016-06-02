//
//  ANSRandom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSRandom : NSObject

+ (NSInteger)randomIntegerBetweenMinValue:(NSInteger)min
                                 maxValue:(NSInteger)max;

+ (BOOL)randomBool;

@end
