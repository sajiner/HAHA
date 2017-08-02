
#import <Foundation/Foundation.h>

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

/**
 *  单个圆背景色
 */
#define CircleBackgroundColor [UIColor clearColor]

/**
 *  解锁背景色
 */
#define CircleViewBackgroundColor [XAppContext appColors].blueColor

/**
 *  普通状态下外空心圆颜色
 */
#define CircleStateNormalOutsideColor rgba(78,163,255,1)

/**
 *  选中状态下外空心圆颜色
 */
#define CircleStateSelectedOutsideColor rgba(255,255,255,1)

/**
 *  错误状态下外空心圆颜色
 */
#define CircleStateErrorOutsideColor rgba(260,124,83,1)

/**
 *  普通状态下内实心圆颜色
 */
#define CircleStateNormalInsideColor [UIColor clearColor]

/**
 *  选中状态下内实心圆颜色
 */
#define CircleStateSelectedInsideColor rgba(255,255,255,1)

/**
 *  错误状态内实心圆颜色
 */
#define CircleStateErrorInsideColor rgba(160,124,83,1)

/**
 *  普通状态下三角形颜色
 */
#define CircleStateNormalTrangleColor [UIColor clearColor]

/**
 *  选中状态下三角形颜色
 */
#define CircleStateSelectedTrangleColor rgba(255,255,255,1)

/**
 *  错误状态三角形颜色
 */
#define CircleStateErrorTrangleColor rgba(81,68,51,1)

/**
 *  三角形边长
 */
#define kTrangleLength 10.0f

/**
 *  普通时连线颜色
 */
#define CircleConnectLineNormalColor rgba(77,162,254,1)

/**
 *  错误时连线颜色
 */
#define CircleConnectLineErrorColor rgba(160,124,83,1)

/**
 *  连线宽度
 */
#define CircleConnectLineWidth 2.0f

/**
 *  单个圆的半径
 */
#define CircleRadius ([UIScreen mainScreen].bounds.size.width - 165) / 6   //30.0f

/**
 *  单个圆的圆心
 */
#define CircleCenter CGPointMake(CircleRadius, CircleRadius)

/**
 *  空心圆圆环宽度
 */
#define CircleEdgeWidth 1.0f

/**
 *  九宫格展示infoView 单个圆的半径
 */
#define CircleInfoRadius 5

/**
 *  内部实心圆占空心圆的比例系数
 */
#define CircleRadio 0.4

/**
 *  整个解锁View居中时，距离屏幕左边和右边的距离
 */
#define CircleViewEdgeMargin 38.0f

/**
 *  整个解锁View的Center.y值 在当前屏幕的3/5位置
 */
#define CircleViewCenterY kScreenH * 3/5 - 30

/**
 *  连接的圆最少的个数
 */
#define CircleSetCountLeast 4

/**
 *  错误状态下回显的时间
 */
#define kdisplayTime 0.5f

/**
 *  最终的手势密码存储key
 */
#define gestureFinalSaveKey @"gestureFinalSaveKey"

/**
 *  第一个手势密码存储key
 */
#define gestureOneSaveKey @"gestureOneSaveKey"

#pragma mark - 文字提示颜色

/**
 *  普通状态下文字提示的颜色
 */
#define textColorNormalState rgba(255,255,255,1)

/**
 *  警告状态下文字提示的颜色
 */
#define textColorWarningState rgba(255,132,0,1)

#pragma mark - 提示语
//-------------------------------------------------设置---------------------------------------------------
/**
 *  绘制解锁界面准备好时，提示文字
 */
#define gestureTextBeforeSet @"绘制解锁图案"

/**
 *  设置时，连线个数少，提示文字
 */
#define gestureTextConnectLess [NSString stringWithFormat:@"最少连接%d个点，请重新输入", CircleSetCountLeast]

/**
 *  设置-为了您的数据安全，请设置手势密码
 */
#define gestureTextRemindSet @"为了您的数据安全，请设置手势密码"

/**
 *  设置-设置成功
 */
#define gestureTextSetSuccess @"恭喜您，手势密码设置成功"
//-------------------------------------------------修改---------------------------------------------------
/**
 *  修改-请输入原手势密码
 */
#define gestureTextOldGesture @"请输入原手势密码"
/**
 *  修改-请输入新手势密码
 */
#define gestureTextDrawFirst @"请绘制手势密码，至少连接4个点"
/**
 *  设置（修改）-确认图案，提示再次绘制
 */
#define gestureTextDrawAgain @"再次绘制解锁图案"

/**
 *  设置(修改)-再次绘制不一致，提示文字
 */
#define gestureTextDrawAgainError @"手势密码不一致，请重新绘制"

/**
 *  修改-修改成功
 */
#define gestureTextChangeSuccess @"恭喜您，手势密码修改成功"

//-------------------------------------------------登录---------------------------------------------------

/**
 *  验证-密码错误
 */
#define gestureTextGestureVerifyError(n) [NSString stringWithFormat:@"手势密码错误，还可以输入%d次",n]

/**
 *  登录-登录手势密码成功
 */
#define gestureTextGestureVerifySuccess @"恭喜您，手势密码解锁成功"
/**
 *  登录-请输入手势密码
 */
#define gestureTextGestureVerify @"请输入手势密码"
//-------------------------------------------------------------------------------------------------------

@interface PCCircleViewConst : NSObject

/**
 *  偏好设置：存字符串（手势密码）
 *
 *  @param gesture 字符串对象
 *  @param key     存储key
 */
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key;

/**
 *  偏好设置：取字符串手势密码
 *
 *  @param key key
 *
 *  @return 字符串对象
 */
+ (NSString *)getGestureWithKey:(NSString *)key;

@end
