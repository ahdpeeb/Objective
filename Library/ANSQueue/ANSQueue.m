//
//  ANSQueue.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSQueue.h"

#import "NSObject+ANSExtension.h"

@interface ANSQueue ()
@property (nonatomic, retain) NSMutableArray *objectsValue;

@end

@implementation ANSQueue

@dynamic count;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.objectsValue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objectsValue = [NSMutableArray object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    @synchronized(self) {
        return [self countOfObjectsValue];
    }
}

#pragma mark -
#pragma mark Public Methods 

- (void)enqueue:(id)object {
    @synchronized(self) {
        NSMutableArray *objects = self.objectsValue;
        if (![objects containsObject:object]) {
            [self addObjectsValueObject:object];
        }
    }
}
    //needToBeRewrited!
- (id)dequeue {
    @synchronized(self) {
        NSMutableArray *objects = self.objectsValue;
        id object = [[[objects firstObject] retain] autorelease];
        [objects removeObject:object];
    
    return object;
    }
}

#pragma mark -
#pragma mark Methods for KVO compatibility

- (void)addObjectsValueObject:(id)object {
    [self.objectsValue addObject:object];
}

- (NSUInteger)countOfObjectsValue {
    return self.objectsValue.count;
}

- (id)objectInObjectsValueAtIndex:(NSUInteger)index {
    return [self.objectsValue objectAtIndex:index];
}

-(void)insertObject:(id)object inObjectsValueAtIndex:(NSUInteger)index {
    [self.objectsValue insertObject:object atIndex:index];
}

- (void)removeObjectFromObjectsValueAtIndex:(NSUInteger)index; {
    [self.objectsValue removeObjectAtIndex:index];
}

@end
