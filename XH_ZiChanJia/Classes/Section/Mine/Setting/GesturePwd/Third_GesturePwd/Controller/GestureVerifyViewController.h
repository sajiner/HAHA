
#import <UIKit/UIKit.h>
typedef void (^VerifyBlock)();
@interface GestureVerifyViewController : UIViewController
//修改密码
@property (nonatomic, assign) BOOL isToSetNewGesture;
//进前台的验证密码
@property(nonatomic,assign)BOOL isFromBackground;
//验证输入次数达到上限block属性
@property(nonatomic,copy)VerifyBlock block;
//点击忘记手势密码block属性
@property(nonatomic,copy)VerifyBlock forgetPwdBlock;

@end
