//
//  ANSCarWash.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCar.h"

@interface ANSCarWashComplex : NSObject
@property (nonatomic, readonly) NSArray *rooms;

- (void)washCar:(ANSCar *)car;

@end
