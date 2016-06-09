//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSMoneyOwner.h"
#import "ANSFindingObject.h"

@interface ANSWorker : NSObject <ANSMoneyOwner, ANSFindingObject>
@property (nonatomic, assign)           float             income;
@property (nonatomic, assign)           NSInteger         yearsOfExperience;

@end
