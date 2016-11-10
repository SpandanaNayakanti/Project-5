//
//  ActivitiesModel.h
//  WorkForceTrackera
//
//  Created by karthik  on 28/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <Foundation/Foundation.h>






@interface ActivitiesModel : NSObject
@property (nonatomic , strong , readonly) NSString *uCreated;
@property (nonatomic , strong , readonly) NSString *uId;
@property (nonatomic , strong , readonly) NSString *uOrgId;
@property (nonatomic , strong , readonly) NSString *uEmployeeTasksId;
@property (nonatomic , strong , readonly) NSString *uWorkOrderModulesId;
@property (nonatomic , strong , readonly) NSString *uWorkItemname;




- (id) initWithDictionary:(NSDictionary *)dictUser;
@end
