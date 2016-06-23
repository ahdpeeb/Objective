//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//


// after worker got money, he change status for=> ANSWorkerBusy
// after worker will finished work, he change status for=> "ANSWorkIsPending"!
// after worker inform delegate, delegate after processing worker change his state=> ANSWorkerFree!

#import <Foundation/Foundation.h>

#import "ANSMoneyOwner.h"
#import "ANSWorkerDelegate.h"

typedef NS_ENUM(uint8_t, ASNWorkerState) {
    ANSWorkerFree,
    ANSWorkerBusy,
    ANSWorkIsPending
};

@interface ANSWorker : NSObject <ANSMoneyOwner, ANSWorkerDelegate>

@property (nonatomic, assign)   NSInteger               idNumber;

//this property readonly,readwrite only for inheritance
@property (nonatomic, assign)   ASNWorkerState          state;
@property (nonatomic, assign)   id<ANSWorkerDelegate>   delegate;

- (instancetype)initWithId:(NSUInteger)idNumber;

- (void)processObject:(id)object;

@end
