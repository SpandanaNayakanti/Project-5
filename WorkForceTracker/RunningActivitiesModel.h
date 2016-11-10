//
//  RunningActivitiesModel.h
//  WorkForceTracker
//
//  Created by Anshu  on 02/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunningActivitiesModel : NSObject

@property (nonatomic , strong , readonly) NSString *uEmployeeId;
@property (nonatomic , strong , readonly) NSString *uId;
@property (nonatomic , strong , readonly) NSString *uOrgId;
@property (nonatomic , strong , readonly) NSString *uEmployeeTasksId;
@property (nonatomic , strong , readonly) NSString *uWorkOrderModulesId;
@property (nonatomic , strong , readonly) NSString *uDiscription;
@property (nonatomic , strong , readonly) NSString *uEmployeeWorkItemsId;
@property (nonatomic , strong , readonly) NSString *uStartTime;
@property (nonatomic , strong , readonly) NSString *uStartDate;
@property (nonatomic , strong , readonly) NSString *uProjectId;
@property (nonatomic , strong , readonly) NSString *uProjectName;
@property (nonatomic , strong , readonly) NSString *uNotes;


- (id) initWithDictionary:(NSDictionary *)dictUser;


@end
