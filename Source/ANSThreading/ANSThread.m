//
//  ANSThreading.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 23.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSThread.h"

#import <libkern/OSAtomic.h>

@interface ANSThread ()
@property (nonatomic, assign) volatile OSSpinLock  *locker;

@end

@implementation ANSThread

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.block = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark Publick methods 

- (void)main {
    @autoreleasepool {
        OSSpinLockLock(_locker);
        ANSThreadBlock block = [self.block retain];
        if (block) {
            block();
        }
        
        [block release];
        OSSpinLockUnlock(_locker);
    }
}

@end
