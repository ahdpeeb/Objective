//
//  ANSMoney.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANSMoneyOwner <NSObject>
@property (atomic, readonly) float money;

- (void)giveMoney:(float)number;
- (void)receiveMoney:(float)number;

@optional

- (void)takeMoneyFromObject:(id<ANSMoneyOwner>)owner;

@end
