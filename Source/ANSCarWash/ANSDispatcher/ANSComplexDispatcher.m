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
#import "ANSGCD.h"

static const NSUInteger kANSTimer = 3;

@interface ANSComplexDispatcher ()
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, retain) ANSCarWashComplex *carComplex;

- (void)initTimer;

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
    self.carComplex = carComplex;
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        _timer = timer; 
    }
}

- (void)setRepeats:(BOOL)repeats {
    if (_repeats != repeats) {
        _repeats = repeats;
        ANSPerformInMainQueue(dispatch_sync, ^{
            [self initTimer];
        });
//        [self performSelectorOnMainThread: repeats ? @selector(initTimer) : @selector(setTimer:)
//                               withObject:nil
//                            waitUntilDone:NO];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)conveyCars {
    NSArray *cars = [self cars];
    for (ANSCar *car in cars) {
        ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
            [self.carComplex addCarToQueue:car];
        });
    }
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)cars {
    __block NSUInteger value = 0;
    
    return [NSArray objectsWithCount:kANSMaxCarCount block:^id(void) { return [ANSCar carWithID:value++]; }];
}

- (void)initTimer {
    ANSDispatchTimer(kANSTimer, YES, ^{
        [self conveyCars];
    });
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:kANSTimer
//                                                  target:self
//                                                selector:@selector(conveyCars)
//                                                userInfo:nil
//                                                 repeats:YES];
}

@end
