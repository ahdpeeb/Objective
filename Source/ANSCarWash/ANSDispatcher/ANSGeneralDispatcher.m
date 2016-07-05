//
//  ANSGeneralDispatcher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//
// передать клас как парамерт, либо на уровне роутера. протокол { вызывать методы из протокола по обработке
}


#import "ANSGeneralDispatcher.h"

#import "ANSAccountant.h"
#import "ANSCarWasher.h"

#import "NSObject+ANSExtension.h"

@interface ANSGeneralDispatcher ()
@property (nonatomic, retain)       NSMutableArray  *mutableProcessors;
@property (nonatomic, retain)       ANSQueue        *processingObjects;
                                                    //or busy, or ready to work

@end

@implementation ANSGeneralDispatcher

@dynamic processors;

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    self.mutableProcessors = nil;
    self.processingObjects = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.processingObjects = [ANSQueue object];
        self.mutableProcessors = [NSMutableArray object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors 

- (NSArray *)processors {
    return [[self.mutableProcessors copy] autorelease];
}

#pragma mark -
#pragma mark Protocol ANSWorkerObserver

//if accountant become busy - add it mutableProcessors
- (void)workerDidBecomeBusy:(id)worker {
    if ([worker isMemberOfClass:[ANSAccountant class]]) {
        [worker addObject:self.mutableProcessors];
    }
}

- (void)workerDidBecomeIsPending:(id)worker {
    // слушает за мойщиками.
}

- (void)workerDidBecomeFree:(id)worker {
    ANSQueue *washersQueue = self.processingObjects;
    if (washersQueue.count) {
        ANSCarWasher *washer = [washersQueue dequeue];
        [worker startProcessingObject:washer];
    }
}

@end
