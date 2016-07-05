//
//  ANSCar.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCar.h"

static const NSUInteger kANSServiceCost = 5;

@interface ANSCar ()
@property (nonatomic, assign) float money;
@property (nonatomic, assign) NSUInteger ID;

@end

@implementation ANSCar

#pragma mark -
#pragma mark initializetion / deallocation

- (void)dealloc {
    [super dealloc]; }

- (instancetype)init {
    self = [super init];
    self.status = ANSCarDirty;
    self.money = kANSServiceCost;

    return self;
}

- (instancetype)initWithID:(NSUInteger)ID {
    self = [self init];
    self.ID = ID;
    
    return self;
}

#pragma mark -
#pragma mark Protocol <ANSMoneyOwner>

- (void)receiveMoney:(float)number {
     @synchronized(self) {
        self.money += number;
    }
}

- (void)giveMoney:(float)number {
    @synchronized(self) {
        self.money -= number;
    }
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"CAR %ld", (long)self.ID ];
}

@end
