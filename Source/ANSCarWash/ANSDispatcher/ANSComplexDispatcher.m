//
//  ANSComplexDispatcher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSComplexDispatcher.h"

#import "ANSCar.h"
#import "ANSConstants.h"

#import "NSArray+ANSExtension.h"

// kANSMaxCarCount = 100;
@interface ANSComplexDispatcher ()
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) ANSCarWashComplex *carComplex;

@end

@implementation ANSComplexDispatcher

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    NSTimer *timer = self.timer;
    [timer invalidate];
    timer = nil;
    
    self.carComplex = nil;
    
    [super dealloc];
}

- (instancetype)initWithComplex:(ANSCarWashComplex *)carComplex {
    self = [super init];
    if (self) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(conveyCars) userInfo:nil repeats:YES];
        self.carComplex = carComplex;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)conveyCars {
    @synchronized(self) {
        NSArray *cars = [self cars];
        for (ANSCar *car in cars) {
            [self.carComplex performSelectorInBackground:@selector(addCarToQueue:) withObject:car];
        }
    }
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)cars {
    __block NSUInteger value = 0;
    ANSObjectBlock object = ^id(void) {
        ANSCar *car  = [[ANSCar alloc] initWithID:value];
        value ++;
        return car;
    };
    
    return [NSArray objectsWithCount:kANSMaxCarCount block:object];
}

@end
