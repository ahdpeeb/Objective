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
#import "ANSGCD.h"

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
#pragma mark Class methods

+ (ANSDispatcher *)dispatcherWithName:(NSString *)name {
    return [[[self alloc] initWithName:name] autorelease];
}

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
    @synchronized(self.mutableProcessors) {
        return [[self.mutableProcessors copy] autorelease];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)processObject:(id<ANSMoneyOwner>)object {
    @synchronized(self) {
        ANSQueue *queue = self.processingObjects;
        [queue enqueue:object];
    }
    
    [self processing];
}

- (void)addProcessor:(id)processor {
    @synchronized(self.mutableProcessors) {
        NSMutableArray *processors = self.mutableProcessors;
        if (![processors containsObject:processor]) {
            [processors addObject:processor];
            [processor addObserverObject:self];
        }
    }
}

- (void)removeProcessor:(id)processor {
    @synchronized(self.mutableProcessors) {
        [self.mutableProcessors removeObject:processor];
        [processor removeObserverObject:self];
    }
}

- (void)addProcessors:(NSArray *)processors {
    @synchronized(self.mutableProcessors) {
        [self.mutableProcessors addObjectsFromArray:processors];
        [processors makeObjectsPerformSelector:@selector(addObserverObject:) withObject:self];
    }
}

- (void)removeProcessors:(NSArray *)processors {
    @synchronized(self.mutableProcessors) {
        [self.mutableProcessors removeObjectsInArray:processors];
        [processors makeObjectsPerformSelector:@selector(removeObserverObjects:) withObject:self];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)processing {
    @synchronized(self) {
        ANSQueue *queue = self.processingObjects;
        id processedObject = [queue dequeue];
        if (processedObject) {
            id processor = [self reservedFreeWorker];
            if (processor) {
                [processor startProcessingObject:processedObject];
            } else {
                [queue enqueue:processedObject];
            }
        }
    }
}

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

- (BOOL)containsProcessors:(id)worker {
    @synchronized(self.mutableProcessors) {
        return [self.mutableProcessors containsObject:worker];
    }
}

#pragma mark -
#pragma mark Overriden

- (NSString *)description {
    return [NSString stringWithString:self.name];
}

#pragma mark -
#pragma mark Protocol ANSWorkerObserver

- (void)workerDidBecomeIsPending:(id)worker {
    if (![self containsProcessors:worker]) {
        ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
            [self processObject:worker];
        });
    }
}

- (void)workerDidBecomeFree:(id)worker {
    if ([self containsProcessors:worker]) {
        ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
            [self processing];
        });
    }
}

@end
