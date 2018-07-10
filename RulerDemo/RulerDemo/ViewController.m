//
//  ViewController.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/9.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "ViewController.h"
#import "SBScrollRulerView.h"

@interface ViewController ()<SBScrollRulerViewDelegate>

///尺子view 的父容器View
@property (weak, nonatomic) IBOutlet UIView *rulerView_ContainerView;

///尺子view
@property (strong, nonatomic) SBScrollRulerView *rulerView;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"111RVCShareIns ==== %@",RVCShareIns);
    NSLog(@"222RVCShareIns ==== %@",RVCShareIns);
    NSLog(@"222RVCShareIns ==== %lf",RVCShareIns.trangle_W);
    NSLog(@"222RVCShareIns ==== %lf",RVCShareIns.rulerGap);
    self.unit = @"占位单位";
    [self.rulerView_ContainerView addSubview:self.rulerView];
}


#pragma mark - getter


- (SBScrollRulerView *)rulerView{
    if (!_rulerView) {
        
        _rulerView = [[SBScrollRulerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 0 * 2, RVCShareIns.rulerView_H) theMinValue:0 theMaxValue:10 theStep:0.5 theUnit:@"" theNum:2];
        _rulerView.delegate = self;

    }
    return _rulerView;
}




#pragma mark - method

///单位1btn点击
- (IBAction)test1BtnClick:(UIButton *)sender {
    
    self.unit = @"g";
    
    RVCShareIns.step = 10;
    RVCShareIns.betweenNum = 10;
    RVCShareIns.rulerGap = 10;
    RVCShareIns.maxValue = 1000;
    RVCShareIns.minValue = 0;
    [self.rulerView reDrawRectRulerView:RVCShareIns];
    [self.rulerView setRealValue:61 animated:YES];
}

///单位2btn点击
- (IBAction)test2BtnClick:(UIButton *)sender {
    
    self.unit = @"勺";
    
    RVCShareIns.step = 0.5;
    RVCShareIns.betweenNum = 2;
    RVCShareIns.rulerGap = 50;
    RVCShareIns.maxValue = 10;
    RVCShareIns.minValue = 0;
    [self.rulerView reDrawRectRulerView:RVCShareIns];
    [self.rulerView setRealValue:2.5 animated:YES];
}

///单位3btn点击
- (IBAction)test3BtnClick:(UIButton *)sender {
    
    self.unit = @"毫克";
    
    RVCShareIns.step = 0.1;
    RVCShareIns.betweenNum = 10;
    RVCShareIns.rulerGap = 10;
    RVCShareIns.maxValue = 10;
    RVCShareIns.minValue = 0;
    [self.rulerView reDrawRectRulerView:RVCShareIns];
    [self.rulerView setRealValue:2.5 animated:YES];
}


#pragma mark - SBScrollRulerViewDelegate
- (void)sbScrollRulerView:(SBScrollRulerView *)rulerView valueChange:(float)value{
    self.valueLbl.text = [NSString stringWithFormat:@"%.1lf%@",value,self.unit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
