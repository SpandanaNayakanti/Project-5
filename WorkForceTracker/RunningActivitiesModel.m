//
//  RunningActivitiesModel.m
//  WorkForceTracker
//
//  Created by karthik  on 02/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "RunningActivitiesModel.h"

static NSString *const kEmployeeId              = @"employee_id";
static NSString *const kId                      = @"id";
static NSString *const kOrgId                   = @"orgid";
static NSString *const kEmployeeTasksId         = @"employeetasks_id";
static NSString *const KWorkOrderModulesId      = @"workordermodules_id";
static NSString *const KDiscription             = @"discription";
static NSString *const kEmployeeWorkItemsId     = @"employeeworkitems_id";
static NSString *const kStartTime               = @"starttime";
static NSString *const kStartDate               = @"startdate";
static NSString *const KProjectId               = @"project_id";
static NSString *const KProjectName             = @"project_name";
static NSString *const KNotes                   = @"nots";

@implementation RunningActivitiesModel

- (id) initWithDictionary:(NSDictionary *)dictUser
{
    if (self = [super init])
    {
        _uEmployeeId          = [[dictUser objectForKey:kEmployeeId] copy];
        _uId                  = [[dictUser objectForKey:kId]      copy];
        _uOrgId               = [[dictUser valueForKey:kOrgId] copy];
        _uEmployeeTasksId     = [[dictUser valueForKey:kEmployeeTasksId] copy];
        _uWorkOrderModulesId  = [[dictUser valueForKey:KWorkOrderModulesId] copy];
        _uDiscription         = [[dictUser objectForKey:KDiscription] copy];
        _uEmployeeWorkItemsId = [[dictUser objectForKey:kEmployeeWorkItemsId] copy];
        _uStartTime           = [[dictUser objectForKey:kStartTime] copy];
        _uStartDate           = [[dictUser objectForKey:kStartDate] copy];
        _uProjectId           = [[dictUser objectForKey:KProjectId] copy];
        _uProjectName         = [[dictUser objectForKey:KProjectName] copy];
        _uNotes               = [[dictUser objectForKey:KNotes] copy];
    }
    return self;
}


@end
