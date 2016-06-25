//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

#import "ANSMoneyOwner.h"

@protocol ANSWorkerObserver <NSObject>

@optional
- (void)workerDidBecomeBusy:(id)worker;
- (void)workerDidBecomeIsPending:(id)worker;
- (void)workerDidBecomeFree:(id)worker;

@end

typedef NS_ENUM(uint8_t, ANSState) {
    ANSWorkerFree,
    ANSWorkerBusy,
    ANSWorkerIsPending
};

typedef NS_ENUM(uint8_t, ANSProfessrionType) {
    ANSCarWasherProfession,
    ANSAccountantProfession,
    ANSBossProfession,
};

@interface ANSWorker : ANSObservableObject <ANSMoneyOwner, ANSWorkerObserver>
@property (nonatomic, assign) ANSProfessrionType profession;


- (instancetype)initWithId:(NSUInteger)ID;

- (void)processObject:(id)object;

//this method is intended for subclasses. Never call it directly.
- (void)performWorkWithObject:(id)object;

//this method is intended for subclasses. Never call it directly.
- (void)changeState;

@end
