//
//  TaskListModel.h
//  WorkForceTracker
//
//  Created by karthik  on 03/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListModel : NSObject

@property (nonatomic , strong , readonly) NSString *uId;
@property (nonatomic , strong , readonly) NSString *uEmployeeTasksId;
@property (nonatomic , strong , readonly) NSString *uEmployeeWorkItemsId;
@property (nonatomic , strong , readonly) NSString *uStartTime;
@property (nonatomic , strong , readonly) NSString *uCreated;
@property (nonatomic , strong , readonly) NSString *uTaskDescription;
@property (nonatomic , strong , readonly) NSString *uStartHours;
@property (nonatomic , strong , readonly) NSString *uEndHours;
@property (nonatomic , strong , readonly) NSString *uWorkingDate;
@property (nonatomic , strong , readonly) NSString *uStartDate;
@property (nonatomic , strong , readonly) NSString *uEndTime;

-(id) initWithDictionary:(NSDictionary *)dictUser;





@end
