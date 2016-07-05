//
//  ANSThreading.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 23.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ANSThreadBlock)(void);

@interface ANSThread : NSThread
@property (atomic, copy) ANSThreadBlock block;

@end
