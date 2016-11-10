
#import <UIKit/UIKit.h>

#define kDefaultStrokeColor         [UIColor clearColor]
#define kDefaultRectColor           [UIColor clearColor]
#define kDefaultStrokeWidth         3.0
#define kDefaultCornerRadius        25.0

@interface RoundedRectView : UIView {
    UIColor     *strokeColor;
    UIColor     *rectColor;
    CGFloat     strokeWidth;
    CGFloat     cornerRadius;
}
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) UIColor *rectColor;
@property CGFloat strokeWidth;
@property CGFloat cornerRadius;
@end
