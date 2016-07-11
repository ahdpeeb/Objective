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

@interface ANSComplexDispatcher ()
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, retain) ANSCarWashComplex *carComplex;

@end

@implementation ANSComplexDispatcher

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    self.timer = nil;
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
#pragma mark Accsessors

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        _timer = nil;
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Public methods

- (void)conveyCars {
    NSArray *cars = [self cars];
    for (ANSCar *car in cars) {
        [self.carComplex performSelectorInBackground:@selector(addCarToQueue:) withObject:car];
    }
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)cars {
    __block NSUInteger value = 0;
    
    return [NSArray objectsWithCount:kANSMaxCarCount block:^id(void) { return [[ANSCar alloc] initWithID:value++]; }];
}

@end
