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

@interface ANSWorker : NSObject <ANSMoneyOwner, ANSWorkerDelegate>
@property (nonatomic, assign)                float      income;
@property (nonatomic, assign)                NSInteger  yearsOfExperience;

// can be readonly from outside
@property (nonatomic, assign, getter=isBusy) BOOL                   busy;

@property (nonatomic, assign)               id<ANSWorkerDelegate>   delegate;

- (void)processObject:(id)object;

@end
