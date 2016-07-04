//
//  ANSKVOtestObserver.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 03.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSKVOtestObserver.h"

@implementation ANSKVOtestObserver

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"name wash changed");
        NSLog(@"%@",change);
    }
    
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"age was changed");
        NSLog(@"%@",change);
    }
}

@end
