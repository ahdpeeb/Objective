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
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.administrative = [ANSAdminBuilding object];
    self.washing = [ANSWashBuilding object];
    
    return self;
}

- (void)dealloc {
    self.administrative = nil;
    self.washing = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public implementation

- (void)washCar:(ANSCar *)car; {
    ANSWashBox *freeBox = [self.washing freeBox];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        [freeBox addCar:car];
        [washer washCar:car];
        [freeBox removeCar:car];
    }
}

@end
