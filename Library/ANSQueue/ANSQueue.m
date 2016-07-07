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
@property (nonatomic, retain) NSMutableArray *subjects;

@end

@implementation ANSQueue

@dynamic objects;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.subjects = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.subjects = [NSMutableArray object];
    }
    
    return self;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"subjects"]) {
        return YES;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    @synchronized(self) {
        return [self countOfSubjects];
    }
}

- (NSArray *)objects {
    return [[self.subjects copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods 

- (void)enqueue:(id)object {
    @synchronized(self) {
        NSMutableArray *objects = self.subjects;
        if (![objects containsObject:object]) {
            [self addSubjectsObject:object];
        }
    }
}
    //needToBeRewrited!
- (id)dequeue {
    @synchronized(self) {
        NSMutableArray *objects = self.subjects;
        id object = [[[objects firstObject] retain] autorelease];
        [objects removeObject:object];
    
    return object;
    }
}

#pragma mark -
#pragma mark Methods for KVO compatibility

- (void)insertObject:(id)object inSubjectsAtIndex:(NSUInteger)index {
    self.subjects[index] = object;
}

- (void)removeObjectFromSubjectsAtIndex:(NSUInteger)index {
    [self.subjects removeObjectAtIndex:index];
}

- (id)objectInSubjectsAtIndex:(NSUInteger)index {
    return self.subjects[index];
}

- (NSArray *)subjectsAtIndexes:(NSIndexSet *)indexes {
    return [self.subjects objectsAtIndexes:indexes];
}

- (NSUInteger)countOfSubjects {
    return [self.subjects count];
}

- (void)addSubjectsObject:(id)object {
    [self insertObject:object inSubjectsAtIndex:[self count]];
}

@end
