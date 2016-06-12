//
//  ANSCarWash.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCar.h"
#import "ANSBuilding.h"

@interface ANSCarWashComplex : NSObject
@property (nonatomic, readonly) NSArray *rooms;
@property (nonatomic, readonly) ANSBuilding       *office;
@property (nonatomic, readonly) ANSBuilding       *washing;

- (instancetype)initInfrastructure;
- (void)washCar:(ANSCar *)car;

@end
