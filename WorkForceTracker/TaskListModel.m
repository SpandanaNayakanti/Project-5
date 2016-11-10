//
//  TaskListModel.m
//  WorkForceTracker
//
//  Created by karthik  on 03/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TaskListModel.h"

static NSString *const kEmployeeId              = @"empid";
static NSString *const kId                      = @"id";
static NSString *const kOrgId                   = @"orgid";
static NSString *const kEmployeeTasksId         = @"employeetasks_id";
static NSString *const KWorkOrderModulesId      = @"workordermodules_id";
static NSString *const KTaskDescription         = @"task_description";
static NSString *const kEmployeeWorkItemsId     = @"employeeworkitems_id";
static NSString *const kStartTime               = @"starttime";
static NSString *const kEndTime                 = @"endtime";
static NSString *const kStartDate               = @"startdate";
static NSString *const kStartHours              = @"starthours";
static NSString *const kEndHours                = @"endhours";
static NSString *const kCreated                 = @"created";
static NSString *const kWorkingDate             = @"working_date";

@implementation TaskListModel

-(id) initWithDictionary:(NSDictionary *)dictUser
{
    if (self=[super init])
    {
        _uId                     = [[dictUser objectForKey:kId] copy];
        _uEmployeeTasksId        = [[dictUser objectForKey:kEmployeeTasksId] copy];
        _uEmployeeWorkItemsId    = [[dictUser objectForKey:kEmployeeWorkItemsId] copy];
        _uStartTime              = [[dictUser objectForKey:kStartTime] copy];
        _uCreated                = [[dictUser objectForKey:kCreated] copy];
        _uTaskDescription        = [[dictUser objectForKey:KTaskDescription] copy];
        _uStartHours             = [[dictUser objectForKey:kStartHours] copy];
        _uEndHours               = [[dictUser objectForKey:kEndHours] copy];
        _uWorkingDate            = [[dictUser objectForKey:kWorkingDate] copy];
        _uStartDate              = [[dictUser objectForKey:kStartDate] copy];
        _uEndTime                = [[dictUser objectForKey:kEndTime] copy];
    }
    return self;
}



@end
