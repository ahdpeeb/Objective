//
//  ANSWorker.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"
#import "ANSCar.h"

@implementation ANSWorker

- (instancetype)initWorker
{
    self = [super init];
    if (self) {
        self.proffesion = ANSProffesionUnemployed;
    }
    
    return self;
}

@end
