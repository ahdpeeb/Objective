//
//  NSArray+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^objectBlock)(void);

@interface NSArray (ANSExtension)

//returns array of objects taken from block
+ (NSArray *)objectsWithCount:(NSUInteger)count object:(id(^)(void))block;

//returns array of filted objects
- (NSArray *)filteredArrayWithBlock:(BOOL(^)(id))block;

@end
