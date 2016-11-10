//
//  WFTUserModel.h
//  WorkForceTracker
//
//  Created by karthik on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WFTUserModel : NSObject


@property (nonatomic , strong , readonly) NSString *uCreated;
@property (nonatomic , strong , readonly) NSString *uId;
@property (nonatomic , strong , readonly) NSString *uAddress;
@property (nonatomic , strong , readonly) NSString *uTimeStart;
@property (nonatomic , strong , readonly) NSString *uTitle;
@property (nonatomic , strong , readonly) NSString *uTaskType;
@property (nonatomic , strong , readonly) NSString *uName;
@property (nonatomic , strong , readonly) NSString *uEmail;
@property (nonatomic , strong , readonly) NSString *uMobile;
@property (nonatomic , strong , readonly) NSString *uRequstedDate;
@property (nonatomic , strong , readonly) NSString *uRequstedEndDate;
@property (nonatomic , strong , readonly) NSString *uDescription;
@property (nonatomic , strong , readonly) NSString *uStatus;

- (id) initWithDictionary:(NSDictionary *)dictUser;

@end
