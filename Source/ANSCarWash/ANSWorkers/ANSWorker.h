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
#import "ANSQueue.h"

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

@interface ANSWorker : ANSObservableObject <ANSMoneyOwner, ANSWorkerObserver>
// this property only for subclasses
@property (nonatomic, readonly)     id<NSLocking>   locker;
@property (nonatomic, readonly)     ANSQueue        *queue;

- (instancetype)initWithId:(NSUInteger)ID;

- (void)startProcessingObject:(id)object;

//this method is intended for subclasses. Never call it directly.
//This method should be processed in background thread. 
- (void)performWorkWithObject:(id)object;

//this method is intended for subclasses. Never call it directly.
//This method should be processed in main thread. it's change state of object
- (void)finishProcessingObject:(id)object;

//this method is intended for subclasses. Never call it directly.
//This method should be processed in main thread. it's change state of self
- (void)finishProcessing;

//this method is intended for subclasses. Never call it directly.
//This method process workers form self.queue.
- (void)processObjects;
@end
