//
//  XFeedBackVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XFeedBackVC.h"
//意见反馈文字最大支持个数
#define Feedback_maxContentCount @"500"
// button设置点击背景
#define SetButtonColor(btn,backgroundColor,highlight)\
{\
CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);\
UIGraphicsBeginImageContext(rect.size);\
CGContextRef context = UIGraphicsGetCurrentContext();\
UIColor *fillColor=backgroundColor;\
CGContextSetFillColorWithColor(context, [fillColor CGColor]);\
CGContextFillRect(context, rect);\
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();\
UIGraphicsEndImageContext();\
if(!highlight)\
{\
[btn setBackgroundImage:image forState:UIControlStateNormal];\
}else{\
[btn setBackgroundImage:image forState:UIControlStateHighlighted];\
}\
}
#import "XFeedBackApi.h"
@interface XFeedBackVC () <UITextViewDelegate,YTKRequestDelegate,CustomAlertViewDelegate>
{
    UITextView  *_textView;
    UILabel     *_reminderLabel;
    UILabel *_showTextCountLabel;
    NSString *_content;
    NSString *_maxContent;
}
@property(nonatomic,strong)XFeedBackApi *feedbackApi;
@end

@implementation XFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _maxContent = Feedback_maxContentCount;
    _textView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets =  NO;
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    //通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self initElement];
}

- (void)initElement
{
    UIImageView *bgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    bgview.image=[UIImage imageNamed:@"feedBack_bg"];
    [self.view addSubview:bgview];
    
    UIImageView *iconview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 15, 15)];
    iconview.image=[UIImage imageNamed:@"feedBack_icon"];
    [self.view addSubview:iconview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconview.right+5, 13, ScreenWidth, 20)];
    titleLabel.textColor = [UIColor colorWithRed:169/255.0f green:125/255.0f blue:76/255.0f alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"请简要描述您遇到的问题，我们会尽快为您解决^_^";
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, ScreenWidth, 20)];
    contentLabel.textColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    //    contentLabel.text = @"一旦您的吐槽被采纳，将送您万元投资金哦^^";
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(16, contentLabel.bottom+10, ScreenWidth-32, 200)];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate = self;
    //    _textView.layer.borderColor = RGBCOLOR(200, 200, 200).CGColor;
    //    _textView.layer.cornerRadius = 5;
    //    _textView.layer.borderWidth = 1;
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, contentLabel.bottom+9, ScreenWidth, 1)];
    line0.backgroundColor = RGB(228, 228, 228);
    [self.view addSubview:line0];
    
    UIView *line00 = [[UIView alloc] initWithFrame:CGRectMake(0, _textView.bottom, ScreenWidth, 1)];
    line00.backgroundColor = RGB(228, 228, 228);
    [self.view addSubview:line00];
    
    _showTextCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_textView.right - 50, _textView.bottom - 20, 50, 20)];
    _showTextCountLabel.font = [UIFont systemFontOfSize:12];
    _showTextCountLabel.textAlignment = NSTextAlignmentCenter;
    _showTextCountLabel.textColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
    _showTextCountLabel.text = [NSString stringWithFormat:@"0/%@", _maxContent];
    
    _reminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, contentLabel.bottom+14, ScreenWidth-16, 20)];
    _reminderLabel.textColor = RGB(175, 175, 175);
    _reminderLabel.font = [UIFont systemFontOfSize:13];
    _reminderLabel.text = @"请在这里输入您对我们的意见和建议（最少5个字）";
    
    
    UIButton *resiterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SetButtonColor(resiterBtn, [UIColor colorWithRed:13/255.0f green:115/255.0f blue:226/255.0f alpha:1], YES);
    resiterBtn.frame = CGRectMake(10, _textView.bottom + 30, ScreenWidth - 20, 44);
    [resiterBtn addTarget:self action:@selector(buttonAction_Commite) forControlEvents:UIControlEventTouchUpInside];
    resiterBtn.backgroundColor = [UIColor colorWithRed:2/255.0f green:100/255.0f blue:207/255.0f alpha:1];
    [resiterBtn setTitle:@"提交" forState:UIControlStateNormal];
    resiterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    resiterBtn.layer.cornerRadius = 5;
    resiterBtn.layer.masksToBounds = YES;
    
    UILabel *phoneLable=[[UILabel alloc]init];
    phoneLable.font=[UIFont systemFontOfSize:18];
    NSString *string=@"客服电话    400-015-0808";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange rng = [string rangeOfString:@"4"];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(145, 154, 167) range:NSMakeRange(0, rng.location)];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(2, 100, 207) range:NSMakeRange(rng.location, 12)];
    phoneLable.attributedText = str;
    // phoneLable.textColor=RGB(145, 154, 167);
    [self.view addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(-(400/1920.0)*ScreenHeight);
    }];
    
    UILabel *day=[[UILabel alloc]init];
    day.font=[UIFont systemFontOfSize:16];
    day.text=@"周一至周五  9:00 ~ 21:00";
    day.textColor=RGB(145, 154, 167);
    [self.view addSubview:day];
    [day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLable.mas_left);
        make.bottom.equalTo(phoneLable.mas_bottom).offset(20);
    }];
    
    UILabel *monday=[[UILabel alloc]init];
    monday.font=[UIFont systemFontOfSize:16];
    monday.text=@"周六、日      9:00 ~ 18:00";
    monday.textColor=RGB(145, 154, 167);
    [self.view addSubview:monday];
    [monday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(day.mas_left);
        make.bottom.equalTo(day.mas_bottom).offset(20);
    }];
    
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=RGB(228, 228, 228);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phoneLable.mas_left).offset(-8);
        make.top.equalTo(phoneLable.mas_top).offset(2);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(57);
    }];
    
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(228, 228, 228);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLable.mas_right).offset(8);
        make.top.mas_equalTo(phoneLable.mas_top).offset(2);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(57);
    }];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:contentLabel];
    [self.view addSubview:_textView];
    [self.view addSubview:_showTextCountLabel];
    
    
    [self.view addSubview:_reminderLabel];
    [self.view addSubview:resiterBtn];
}

#pragma mark - 提交点击事件
- (void)buttonAction_Commite
{
    if (_textView.text.length == 0 ||_textView.text == nil) {
        [self completeLoadWithTitle:@"请输入您的意见内容"];
    }else if (_textView.text.length > [_maxContent intValue]){
        [self completeLoadWithTitle:@"请输入500字以内"];
    }else if(_textView.text.length <5){
        [self completeLoadWithTitle:@"最少输入5个字"];
    }else{
        [self.feedbackApi start];
    }
    
}

//退回
-(void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _reminderLabel.hidden = NO;
    }else {
        _reminderLabel.hidden = YES;
    }
    
    _showTextCountLabel.text = [NSString stringWithFormat:@"%lu/%@", (unsigned long)textView.text.length, _maxContent];
    _showTextCountLabel.textAlignment = NSTextAlignmentCenter;
    
    if (textView.text.length > [_maxContent intValue]) {
        _showTextCountLabel.textColor = [UIColor redColor];
    }else
    {
        _showTextCountLabel.textColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
    }
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 意见反馈 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //意见反馈
    if (request == _feedbackApi) {
        if (state == 1) {
            [self completeLoadWithTitle:nil];
            [self showAlertViewWithTitle:@"" message:@"提交成功" letfButtonTitle:nil rightBtn:@"确定"];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
    [self completeLoadWithTitle:nil];
}

- (void)clearRequest {
    
}

- (XFeedBackApi *)feedbackApi {
    _feedbackApi = [[XFeedBackApi alloc]initWithContent:_textView.text Token:[UserManager User].token];
    _feedbackApi.delegate = self;
    return _feedbackApi;
}
@end
