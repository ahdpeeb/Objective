//
//  ANSGCD.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSGCD.h"

#pragma mark -
#pragma mark Private declaration

long ANSPrioriry(ANSPriorityType type);

#pragma mark -
#pragma mark Public methods

void ANSPerformInAsyncQueue(ANSPriorityType type, ANSGCDBlock block) {
    dispatch_async(dispatch_get_global_queue(ANSPrioriry(type), 0), block);
}

void ANSPerformInSyncQueue(ANSPriorityType type, ANSGCDBlock block) {
    dispatch_sync(dispatch_get_global_queue(ANSPrioriry(type), 0), block);
}

void ANSPerformInMainQueue(ANSDispatch function, ANSGCDBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        function(dispatch_get_main_queue(), block);
    }
}

void ANSDispatchTimer(uint seconds, bool repeat, ANSGCDBlock block) {
    __block bool value = repeat;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        block();
        if(value) {
            ANSDispatchTimer(seconds, value, block);
        }
    });
}

#pragma mark -
#pragma mark Private

long ANSPrioriry(ANSPriorityType type) {
    switch (type) {
        case ANSPriorityHigh:       return  DISPATCH_QUEUE_PRIORITY_HIGH;
        case ANSPriorityDefault:    return  DISPATCH_QUEUE_PRIORITY_DEFAULT;
        case ANSPriorityLow:        return  DISPATCH_QUEUE_PRIORITY_LOW;
        case ANSPriorityBackground: return  DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        default:                    return  DISPATCH_QUEUE_PRIORITY_DEFAULT;
    }
}
