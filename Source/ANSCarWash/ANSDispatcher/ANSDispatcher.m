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

- (BOOL)containsProcessors:(id)worker;
- (id)reservedFreeWorker;
- (NSArray *)freeWorkers;
- (void)processing;

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

- (void)workerDidBecomeIsPending:(id)worker {
    if (![self containsProcessors:worker]) {
        @synchronized(worker) {
            [self processObject:worker];
        }
    }
}
    
- (void)workerDidBecomeFree:(id)worker {
    if ([self containsProcessors:worker]) {
        @synchronized(worker) {
            [self processing];
        }
    }
}

#pragma mark -
#pragma mark Public methods

+ (ANSDispatcher *)dispatcherWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}
    // пффф
- (void)processObject:(id<ANSMoneyOwner>)object {
    @synchronized(self.processingObjects) {
        ANSQueue *queue = self.processingObjects;
        [queue enqueue:object];
    }
    
    @synchronized(self) {
        [self processing];
    }
}

- (void)addProcessor:(id)processor {
    @synchronized(self) {
        NSMutableArray *processors = self.mutableProcessors;
        if (![processors containsObject:processor]) {
            [processors addObject:processor];
            [processor addObserverObject:self];
        }
    }
}

- (void)removeProcessor:(id)processor {
    @synchronized(self) {
        [self.mutableProcessors removeObject:processor];
        [processor removeObserverObject:self];
    }
}

- (void)addProcessors:(NSArray *)processors {
    @synchronized(self) {
        [self.mutableProcessors addObjectsFromArray:processors];
        [processors makeObjectsPerformSelector:@selector(addObserverObject:) withObject:self];
    }
}

- (void)removeProcessors:(NSArray *)processors {
    @synchronized(self) {
        [self.mutableProcessors removeObjectsInArray:processors];
        [processors makeObjectsPerformSelector:@selector(removeObserverObjects:) withObject:self];
    }
}

#pragma mark -
#pragma mark Private Methods
// пффф
- (void)processing {
    @synchronized(self.processors) {
        ANSQueue *queue = self.processingObjects;
        if (queue.count) {
            id processor = [self reservedFreeWorker];
            if (processor) {
                [processor startProcessingObject:[queue dequeue]];
            }
        }
    }
}

- (id)reservedFreeWorker {
    @synchronized(self.processors) {
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

- (BOOL)containsProcessors:(id)worker {
    return [self.mutableProcessors containsObject:worker];
}

#pragma mark -
#pragma mark Overriden

- (NSString *)description {
    return [NSString stringWithString:self.name];
}

@end
