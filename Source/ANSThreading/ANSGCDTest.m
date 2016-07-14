//
//  ANSGCDTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 11.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSGCDTest.h"

typedef void(^ANSPerformanceBlock)(void);

static const uint32_t kANSMaxSec = 3;
static NSString * const kANSdispatchLable = @"kANSdispatchLable";

@interface ANSGCDTest ()
@property (nonatomic, retain) dispatch_queue_t queue;


@end

@implementation ANSGCDTest

- (instancetype)initWithType:(dispatch_queue_attr_t)attribute {
    self = [super init];
    
    dispatch_queue_t queue = [dispatch_queue_create([kANSdispatchLable UTF8String], attribute) autorelease];
    self.queue = queue;

    return self;
}

#pragma mark -
#pragma mark Public
// async / sync = do not wait for execution of the block / block the current thread to wait for execution of the block.
// dispatch_apply - stops the current thread (in which he was called), and keeps it until all operations in it.

- (void)execute {
    dispatch_apply(100, self.queue, ^(size_t count) {
        dispatch_async(self.queue, ^(void) {
            uint32_t time = arc4random_uniform(kANSMaxSec);
            NSLog(@"sleep time = %u", time);
            sleep(time);
        } );
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"main thread execution");
        });
    });
}

@end
