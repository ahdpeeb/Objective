//
//  ANSQueue.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSQueue : NSObject
@property (nonatomic, readonly)   NSUInteger     count;
@property (nonatomic, readonly)   NSArray        *objects;

- (void)enqueue:(id)object;
- (id)dequeue;

//this method implemented for KVO observation
- (void)addSubjectsObject:(id)object;

//this method implemented for KVO observation
- (NSUInteger)countOfSubjects;

//this method implemented for KVO observation
- (id)objectInSubjectsAtIndex:(NSUInteger)index;

//this method implemented for KVO observation
-(void)insertObject:(id)object inSubjectsAtIndex:(NSUInteger)index;

- (NSArray *)subjectsAtIndexes:(NSIndexSet *)indexes;

//this method implemented for KVO observation
- (void)removeObjectFromSubjectsAtIndex:(NSUInteger)index;

@end
