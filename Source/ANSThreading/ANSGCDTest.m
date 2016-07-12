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

- (void)executeWithQueueType:(dispatch_queue_attr_t)attribute;

@end

@implementation ANSGCDTest

- (instancetype)initWithType:(dispatch_queue_attr_t)attribute {
    self = [super init];
    
    dispatch_queue_t queue = dispatch_queue_create([kANSdispatchLable cStringUsingEncoding:NSUTF8StringEncoding], attribute);
    self.queue = queue;
    dispatch_release(queue);

    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setQueue:(dispatch_queue_t)queue {
    if (queue != _queue) {
        if (_queue) {
            dispatch_release(_queue);
        }
        
        _queue = queue;
        if (queue) {
            dispatch_retain(queue);
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)executeSerial {
    [self executeWithQueueType:DISPATCH_QUEUE_SERIAL];
}
- (void)executeConcurent {
    [self executeWithQueueType:DISPATCH_QUEUE_CONCURRENT];
}

#pragma mark -
#pragma mark Private

- (void)executeWithQueueType:(dispatch_queue_attr_t)attribute {
    dispatch_async(self.queue, ^(void) {
        uint32_t time = arc4random_uniform(kANSMaxSec);
        NSLog(@"sleep time = %u", time);
        sleep(time);
    } );
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"main thread execution");
    });
}

@end
