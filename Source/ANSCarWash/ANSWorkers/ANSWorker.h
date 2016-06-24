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
- (void)workerBecameBusy:(id)worker;
- (void)workerBecameIsPending:(id)worker;
- (void)workerBecameFree:(id)worker;

@end

@interface ANSWorker : ANSObservableObject <ANSMoneyOwner, ANSWorkerObserver>
@property (atomic, assign) NSInteger idNumber;

- (instancetype)initWithId:(NSUInteger)idNumber;

- (void)processObject:(id)object;

//this method is intended for subclasses. Never call it directly.
- (void)performWorkWithObject:(id)object;

@end
