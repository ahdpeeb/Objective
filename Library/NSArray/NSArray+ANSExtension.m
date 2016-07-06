//
//  NSArray+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSArray+ANSExtension.h"

#import "NSObject+ANSExtension.h"

@implementation NSArray (ANSExtension)

+ (NSArray *)objectsWithCount:(NSUInteger)count object:(id(^)(void))block; {
    NSMutableArray *objects = [NSMutableArray object];
    for (NSUInteger value = 0; value < count; value ++) {
        [objects addObject:block];
    }
    
    return [[objects copy] autorelease];
}

@end
