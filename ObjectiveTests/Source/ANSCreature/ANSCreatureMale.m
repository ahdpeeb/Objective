//
//  ANSCreatureMale.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCreatureMale.h"

@implementation ANSCreatureMale

- (void)goFight {
    NSLog(@"%@ - i'am go to fing", self.name);
}

- (void)performGenderSpecificOperation {
    [self goFight];
}

@end
