
#import <UIKit/UIKit.h>
#import "PCLockLabel.h"
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget,
    buttonTagChange
    
}buttonTag;
typedef void (^IgnoreOrBackBlock)();
@interface GestureViewController : UIViewController
/**
 *  登录界面的用户头像
 */
@property(nonatomic,strong)UIImageView  *imageView;

/**
 *  ”绘制解锁图案“Label
 */
@property (nonatomic, strong) PCLockLabel *drawLabel;

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;

/**
 *  是否从修改手势密码跳转进来的
 */
@property(nonatomic,assign)BOOL isFromChangePwd;
//是否从后台跳进来的
@property(nonatomic,assign)BOOL isFromBackground;
//是否从登录跳转进来的
@property(nonatomic,assign)BOOL isFromLogin;
//返回或忽略block属性
@property(nonatomic,copy)IgnoreOrBackBlock backBlock;
@end
