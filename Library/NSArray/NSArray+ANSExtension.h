//
//  NSArray+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

<<<<<<< HEAD
typedef id(^objectBlock)(void);

@interface NSArray (ANSExtension)

+ (NSArray *)objectsWithCount:(NSUInteger)count object:(id(^)(void))block;
=======
typedef id(^ANSObjectBlock)(void);

@interface NSArray (ANSExtension)

//returns array of objects taken from block
+ (instancetype)objectsWithCount:(NSUInteger)count block:(ANSObjectBlock)block;

//returns array of filted objects
- (NSArray *)filteredArrayWithBlock:(BOOL(^)(id))block;
>>>>>>> feature/Task_8

@end
