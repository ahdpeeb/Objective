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

- (BOOL)isWorkerMemberOfProcessors:(id)worker;
- (id)reservedFreeWorker;
- (NSArray *)freeWorkers;

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
    return [self initWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    self.processingObjects = [ANSQueue object];
    self.mutableProcessors = [NSMutableArray object];
    
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

// Dispatcher only interested in what the processing object can be processed.
- (void)workerDidBecomeIsPending:(id)worker {
    @synchronized(self) {
        if (![self isWorkerMemberOfProcessors:worker]) {
            [self processObject:worker];
        }
    }
}

// Dispatcher interested when processor free and he can get next objext
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

- (void)processObject:(id)object {
    @synchronized(self) {
        ANSQueue *queue = self.processingObjects;
        [self.processingObjects enqueue:object];
        
        id processor = [self reservedFreeWorker];
        if (processor && queue.count) {
            [processor startProcessingObject:[queue dequeue]];
        }
    }
}
    
- (void)addProcessors:(NSArray *)processors {
    @synchronized(self) {
        self.mutableProcessors = [NSMutableArray arrayWithArray:processors];
    }
}

- (void)removeProcessors:(NSArray *)processors {
    [self.mutableProcessors removeAllObjects];
}

- (void)addProcessor:(id)processor {
    @synchronized(self) {
        NSMutableArray *processors = self.mutableProcessors;
        if (![processors containsObject:processor]) {
            [self.mutableProcessors addObject:processor];
        }
    }
}

- (void)removeProcessor:(id)processor {
    @synchronized(self) {
        [self.mutableProcessors removeObject:processor];
    }
}

#pragma mark -
#pragma mark Privat Methods

- (id)reservedFreeWorker {
    @synchronized(self) {
        ANSWorker *freeWorker =  [[self freeWorkers] firstObject];
        if (freeWorker) {
            freeWorker.state = ANSWorkerBusy;
            NSLog(@"%@ - поменял состояние на ANSWorkerBusy", freeWorker);
            
            return freeWorker;
        }
    }
    
    return nil;
}

- (NSArray *)freeWorkers {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"state", ANSWorkerFree]; //@"busy == NO"
    
    return [self.mutableProcessors filteredArrayUsingPredicate:predicate];
}

- (BOOL)isWorkerMemberOfProcessors:(id)worker {
    return [self.mutableProcessors containsObject:worker];
}

#pragma mark -
#pragma mark Overriden

- (NSString *)description {
    return [NSString stringWithString:self.name];
}

@end
