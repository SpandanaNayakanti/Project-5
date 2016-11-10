//
//  ActivitiesModel.m
//  WorkForceTracker
//
//  Created by karthik  on 28/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "ActivitiesModel.h"

static NSString *const kCreated                 = @"created";
static NSString *const kId                      = @"id";
static NSString *const kOrgId                   = @"orgid";
static NSString *const kEmployeeTasksId         = @"employeetasks_id";
static NSString *const KWorkOrderModulesId      = @"workordermodules_id";
static NSString *const KWorkItemname            = @"workitemname";



@implementation ActivitiesModel
- (id) initWithDictionary:(NSDictionary *)dictUser
{
    if (self = [super init])
    {
        _uCreated             = [[dictUser valueForKey:kCreated] copy];
        _uId                  = [[dictUser valueForKey:kId] copy];
        _uOrgId               = [[dictUser valueForKey:kOrgId] copy];
        _uEmployeeTasksId     = [[dictUser valueForKey:kEmployeeTasksId] copy];
        _uWorkOrderModulesId  = [[dictUser valueForKey:KWorkOrderModulesId] copy];
        _uWorkItemname        = [[dictUser valueForKey:KWorkItemname] copy];

        
    }
    return self;
}

@end
