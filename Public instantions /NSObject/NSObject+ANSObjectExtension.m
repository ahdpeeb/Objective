//
//  NSObject+ANSObjectExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSObject+ANSObjectExtension.h"

@implementation NSObject (ANSObjectExtension)

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

@end
