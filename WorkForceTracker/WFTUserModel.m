//
//  WFTUserModel.m
//  WorkForceTracker
//
//  Created by karthik on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "WFTUserModel.h"


static NSString *const kCreated         = @"created";
static NSString *const kId              = @"id";
static NSString *const kAddress         = @"address";
static NSString *const kTimeStart       = @"time_start";
static NSString *const KTitle           = @"title";
static NSString *const KTaskType        = @"task_type";
static NSString *const KName            = @"name";
static NSString *const KEmail           = @"email";
static NSString *const KMobile          = @"mobile";
static NSString *const KRequestedDate   = @"requested_date";
static NSString *const KRequstedEndDate = @"requested_enddate";
static NSString *const KDescription     = @"description";
static NSString *const KStatus          = @"status";

@implementation WFTUserModel

- (id) initWithDictionary:(NSDictionary *)dictUser
{
    if (self = [super init])
    {
         
        NSString  *time=[[dictUser objectForKey:kTimeStart]copy];
        NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
        NSDateFormatter *df1 = [NSDateFormatter new];
        [df1 setDateFormat:@"hh:mm:ss a"];
        NSString *ti=[df1 stringFromDate:myDate];
        
        
        
    _uCreated         =  [[dictUser objectForKey:kCreated] copy];
    _uId              =  [[dictUser objectForKey:kId]      copy];
    _uAddress         =  [[dictUser objectForKey:kAddress] copy];
    _uTimeStart       =   ti;
    _uTitle           =  [[dictUser objectForKey:KTitle]   copy];
    _uTaskType        =  [[dictUser objectForKey:KTaskType]copy];
    _uName            =  [[dictUser objectForKey:KName]    copy];
    _uEmail           =  [[dictUser objectForKey:KEmail]   copy];
    _uMobile          =  [[dictUser objectForKey:KMobile]  copy];
    _uRequstedDate    =  [[dictUser objectForKey:KRequestedDate] copy];
    _uRequstedEndDate =  [[dictUser objectForKey:KRequstedEndDate] copy];
    _uDescription     =  [[dictUser objectForKey:KDescription] copy];
    _uStatus          = [[dictUser objectForKey:KStatus] copy];
        
    }
    return self;
}

@end
