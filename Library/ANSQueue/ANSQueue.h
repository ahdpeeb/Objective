//
//  ANSQueue.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSQueue : NSObject
@property (nonatomic, readonly)   NSUInteger          count;
@property (nonatomic, readonly)   NSMutableArray      *objectsValue;

- (void)enqueue:(id)object;
- (id)dequeue;

//this method implemented for KVO observation
- (void)addObjectsValueObject:(id)object;

//this method implemented for KVO observation
- (NSUInteger)countOfObjectsValue;

//this method implemented for KVO observation
- (id)objectInObjectsValueAtIndex:(NSUInteger)index;

//this method implemented for KVO observation
-(void)insertObject:(id)object inObjectsValueAtIndex:(NSUInteger)index;

//this method implemented for KVO observation
- (void)removeObjectFromObjectsValueAtIndex:(NSUInteger)index;

@end
