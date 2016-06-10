//
//  ANSCar.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCar.h"
#import "ANSConstants.h"

@interface ANSCar ()
@property(nonatomic, assign) float money;

@end

@implementation ANSCar

#pragma mark -
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.status = ANSCarDirty;
    self.money = kANSServiceCost;

    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)receiveMoney:(float)number {
    self.money += number;
}

- (void)giveMoney:(float)number {
    self.money -= number;
}

@end
