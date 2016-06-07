//
//  ANSMoney.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANSCarWashComplexProtocol <NSObject>
@property (nonatomic, assign, readonly) float money;

@required

-(void)giveMoney:(float)number;
-(void)acceptMoney:(float)number;

@end
