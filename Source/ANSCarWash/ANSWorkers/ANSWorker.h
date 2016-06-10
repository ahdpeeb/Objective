//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSMoneyOwner.h"

@interface ANSWorker : NSObject <ANSMoneyOwner>
@property (nonatomic, assign) float     income;
@property (nonatomic, assign) NSInteger yearsOfExperience;

@end
