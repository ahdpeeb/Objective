//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"
#import "NSObject+ANSExtension.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSAdminBuilding  *administrative;
@property (nonatomic, retain) ANSWashBuilding   *washing;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.administrative = [ANSAdminBuilding object];
        self.washing = [ANSWashBuilding object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public implementation

- (void)washCar:(ANSCar *)car withCost:(float)cost; {
    ANSWashBox *freeBox = [self.washing freeBox];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        [freeBox addCar:car];
        [washer washCar:car withCost:cost];
        [freeBox removeCar:car];
    }
}

@end
