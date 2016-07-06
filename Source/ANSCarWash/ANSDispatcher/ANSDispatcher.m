//
//  ANSGeneralDispatcher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//
// передать клас как парамерт, либо на уровне роутера. протокол { вызывать методы из протокола по обработке

#import "ANSDispatcher.h"

#import "ANSAccountant.h"
#import "ANSCarWasher.h"

#import "NSObject+ANSExtension.h"

@interface ANSDispatcher ()
@property (nonatomic, retain)       NSMutableArray  *mutableProcessors;
@property (nonatomic, retain)       ANSQueue        *processingObjects;
@property (nonatomic, copy)         NSString        *name;

- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;

@end

@implementation ANSDispatcher

@dynamic processors;

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    self.mutableProcessors = nil;
    self.processingObjects = nil;
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.processingObjects = [ANSQueue object];
    self.mutableProcessors = [NSMutableArray object];
    
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    self = [self init];
    self.name = name;
    
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

}

// Dispatcher only interested in what the processing object can be processed.
- (void)workerDidBecomeIsPending:(id)worker {
    @synchronized(self) {
        if (![self isWorkerMemberOfProcessors:worker]) {
        
            ANSQueue *queue = self.processingObjects;
            [queue enqueue:worker];
        
            id processor = [self reservedFreeWorker];
            if (processor && queue.count) {
                [processor startProcessingObject:[queue dequeue]];
            }
        }
    }
}
// Dispatcher interested when processor od free and can get next objext
- (void)workerDidBecomeFree:(id)worker {
    @synchronized(self) {
        if ([self isWorkerMemberOfProcessors:worker]) {
            ANSQueue *queue = self.processingObjects;
            if (queue.count) {
                [worker startProcessingObject:[queue dequeue]];
            }
        }
    }
}

#pragma mark -
#pragma mark Public methods



#pragma mark -
#pragma mark Privat Methods

- (NSArray *)freeWorkers {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"state", ANSWorkerFree]; //@"busy == NO"
    
    return [self.mutableProcessors filteredArrayUsingPredicate:predicate];
}

- (id)reservedFreeWorker {
    @synchronized(self) {
        ANSWorker *freeWorker =  [[self freeWorkers] firstObject];
        freeWorker.state = ANSWorkerBusy;
        NSLog(@"%@ - поменял состояние на ANSWorkerBusy", freeWorker);
        
        return freeWorker;
    }
    
    return nil;
}

- (BOOL)isWorkerMemberOfProcessors:(id)worker {
    return [worker isMemberOfClass:[self.mutableProcessors.firstObject class]];
}

#pragma mark -
#pragma mark Overriden

- (NSString *)description {
    return [NSString stringWithString:self.name];
}

@end
