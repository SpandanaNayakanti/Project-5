//
//  WTFTextField.h
//  WorkForceTracker
//
//  Created by karthik  on 12/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    VARCHAR ,
    DECIMAL,
    DOUBLE,
    TIME,
    Date
    
    
}txtFieldType;

@interface WTFTextField : UITextField

@property (nonatomic , assign) txtFieldType typeTextfield;
@property (nonatomic , assign) NSString *Type;
@property (nonatomic , assign) BOOL isMandatory;
@property (nonatomic , assign) NSString *tag_Name;

- (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withType:(NSString*)type isMandatory:(BOOL)mandatory withTagName:(NSString*)tagName;


@end
