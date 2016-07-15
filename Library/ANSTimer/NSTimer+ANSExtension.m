//
//  NSTimer+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 15.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSTimer+ANSExtension.h"

@implementation NSTimer (ANSExtension)

#pragma mark -
#pragma mark Public methods

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(ANSTimerBlock)block
                           repeats:(BOOL)yesOrNo
{
    if (!block) {
        return 0;
    }
    
    ANSTimerBlock copy = [block copy];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:self selector:@selector(executeBlock)
                                           userInfo:copy
                                            repeats:yesOrNo];
    
    [copy release];
    
    return timer;
};

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    block:(ANSTimerBlock)block
                                    repeats:(BOOL)yesOrNo

{
    
    if (!block) {
        return 0;
    }
    
    ANSTimerBlock copy = [block copy];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:self selector:@selector(executeBlock)
                                           userInfo:copy
                                            repeats:yesOrNo];
    
    [copy release];
    
    return timer;
}

#pragma mark -
#pragma mark Private

- (void)executeBlock {
    ANSTimerBlock block = self.userInfo;
    block();
}

@end
