//
//  XMessageDetailViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/12/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMessageDetailViewController.h"
#import "XHMessageModel.h"

@interface XMessageDetailViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation XMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textView];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.textColor = [XAppContext appColors].grayBlackColor;
        _textView.font = [XAppContext appFonts].font_15;
        _textView.text = _model.content;
    }
    return _textView;
}

@end
