//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSMoneyOwner.h"
#import "ANSWorkerDelegate.h"

typedef enum {
    ANSWorkerFree,
    ANSWorkerBusy,
} ANSWorkerStatus;

@interface ANSWorker : NSObject <ANSMoneyOwner, ANSWorkerDelegate>
@property (nonatomic, assign) float                 income;
@property (nonatomic, assign) NSInteger             yearsOfExperience;
@property (nonatomic, readonly) ANSWorkerStatus     status;

@property (nonatomic, assign) ANSWorker<ANSWorkerDelegate> *delegate;

- (void)processObject:(id)object;



@end
