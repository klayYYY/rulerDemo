//
//  SBScrollRulerView.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBScrollRulerView.h"
#import "SBTriangleView.h"
#import "SBRulerView.h"
@interface SBScrollRulerView()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)SBTriangleView  *triangle;

///后期 文本属性配置 =====
@property(nonatomic, strong)UITextField     *valueTF;
@property(nonatomic, strong)UILabel         *unitLab;
/// ================

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UIImageView     *redLine;
@property(nonatomic, assign)float           realValue;
@property(nonatomic, copy  )NSString        *unit;//单位
@property(nonatomic, assign)float           stepNum;//分多少个区
@property(nonatomic, assign)float           minValue;//游标的最小值
@property(nonatomic, assign)float           maxValue;//游标的最大值
@property(nonatomic, assign)float           step;//间隔值，每两条相隔多少值
@property(nonatomic, assign)NSInteger       betweenNum;
@end

@implementation SBScrollRulerView

- (instancetype)initWithFrame:(CGRect)frame theMinValue:(float)minValue theMaxValue:(float)maxValue theStep:(float)step theUnit:(NSString *)unit theNum:(NSInteger)betweenNum{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.minValue   = minValue;
        self.maxValue   = maxValue;
        self.step       = step;
        self.stepNum    = (self.maxValue - self.minValue) / _step / betweenNum;
        self.unit       = unit;
        self.betweenNum = betweenNum;
        RVCShareIns.step = step;
        RVCShareIns.betweenNum = betweenNum;
        [self addSubview:self.collectionView];
        [self addSubview:self.triangle];
        self.bgColor = RVCShareIns.rulerView_BGColor;
        self.triangleColor = RVCShareIns.triangle_Color;
        self.backgroundColor = RVCShareIns.rulerView_BGColor;
        // [self addSubview:self.valueTF];
        // [self addSubview:self.unitLab];
        // self.unitLab.text = _unit;
    }
    return self;
}

#pragma mark - getter
/*
 - (UITextField *)valueTF{
 if (!_valueTF) {
 _valueTF  = [[UITextField alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - 60, 10,80, 40)];
 _valueTF.userInteractionEnabled   = YES;
 _valueTF.defaultTextAttributes    = @{NSFontAttributeName:H19,
 NSForegroundColorAttributeName:red_color};
 _valueTF.textAlignment            = NSTextAlignmentRight
 ;
 _valueTF.delegate                 = self;
 _valueTF.keyboardType             = UIKeyboardTypeNamePhonePad;
 }
 return _valueTF;
 }
 - (UILabel *)unitLab{
 if (!_unitLab) {
 _unitLab = [[UILabel alloc]initWithFrame:CGRectMake( self.bounds.size.width / 2 + 20 , 10, 40, 40)];
 _unitLab.textColor = [UIColor redColor];
 }
 return _unitLab;
 }
 */

- (SBTriangleView *)triangle{
    if (!_triangle) {
        _triangle = [[SBTriangleView alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - 0.5 - RVCShareIns.trangle_W / 2, 0, RVCShareIns.trangle_W, RVCShareIns.trangle_W)];
        _triangle.triangleColor = self.triangleColor;
        _triangle.backgroundColor = [UIColor clearColor];
    }
    return _triangle;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - RVCShareIns.rulerView_H, self.bounds.size.width, RVCShareIns.rulerView_H) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = self.bgColor;
        _collectionView.bounces         = YES;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.showsVerticalScrollIndicator    = NO;
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        _collectionView.contentSize     = CGSizeMake(_stepNum * _step + [UIScreen mainScreen].bounds.size.width / 2 - 26.f, RVCShareIns.rulerView_H);
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"headCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"footerCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
    }
    return _collectionView;
}

#pragma mark - Target Or Method


///重新绘制标尺数据
- (void)reDrawRectRulerView:(SBRulerViewConfiguration *)config{
    self.minValue   = config.minValue;
    self.maxValue   = config.maxValue;
    self.step       = config.step;
//    self.unit       = config.unit;
    self.betweenNum = config.betweenNum;
    self.stepNum    = (_maxValue - _minValue) / _step / _betweenNum;
    self.bgColor = config.rulerView_BGColor;
    self.triangleColor = config.triangle_Color;
    self.backgroundColor = config.rulerView_BGColor;
    [self.collectionView reloadData];
}


- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.collectionView.backgroundColor = _bgColor;
}

- (void)setTriangleColor:(UIColor *)triangleColor{
    _triangleColor = triangleColor;
    self.triangle.triangleColor = _triangleColor;
}

- (void)setRealValue:(float)realValue{
    [self setRealValue:realValue animated:NO];
}

- (void)setRealValue:(float)realValue animated:(BOOL)animated{
    _realValue      = realValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",_realValue * _step + _minValue];
    [_collectionView setContentOffset:CGPointMake((int)realValue * RVCShareIns.rulerGap, 0) animated:animated];
}


- (void)setDefaultValue:(float)defaultValue animated:(BOOL)animated{
    _realValue      = defaultValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",defaultValue];
    [_collectionView setContentOffset:CGPointMake(((defaultValue-_minValue)/(float)_step) * RVCShareIns.rulerGap, 0) animated:animated];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newStr intValue]>_maxValue){
        _valueTF.text =  [NSString stringWithFormat:@"%.f",_maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}
- (void)didChangeValue{
    float textFieldValue = [_valueTF.text floatValue];
    if ((textFieldValue-_minValue) >= 0) {
        [self setRealValue:(textFieldValue - _minValue)/(float)_step animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"少于最低值，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark UICollectionViewDataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2 + _stepNum;///左右占位
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        SBRulerView *rulerView = [cell.contentView viewWithTag:1002];
    [rulerView removeFromSuperview];
    rulerView = nil;
    CGRect frame = CGRectMake(0, 0, RVCShareIns.rulerGap * _betweenNum, RVCShareIns.rulerView_H);
    if (indexPath.item == 0 || indexPath.item == _stepNum + 1) {
        if (indexPath.item == 0) {
            ///3x屏幕起始点会有0.1误差这里处理
            frame = CGRectMake(0, 0, self.frame.size.width / 2 + 0.1, RVCShareIns.rulerView_H);
        }else{
            frame = CGRectMake(0, 0, self.frame.size.width / 2, RVCShareIns.rulerView_H);
        }
    }
    if (!rulerView){
        rulerView  = [[SBRulerView alloc] init];
        rulerView  = [[SBRulerView alloc]initWithFrame:frame];
        rulerView.tag               = 1002;
        rulerView.step              = _step;
        rulerView.unit              = _unit;
        rulerView.betweenNumber     = _betweenNum;
        [cell.contentView addSubview:rulerView];
    }
    rulerView.backgroundColor = [UIColor clearColor];
    
    if (indexPath.item == 0){
        rulerView.isPlaholderCell_Min = YES;
        rulerView.isPlaholderCell_Max = NO;
        rulerView.minValue = (NSInteger)(self.minValue - _step * _betweenNum);
        rulerView.maxValue = self.minValue;
    }else if( indexPath.item == _stepNum + 1){
        rulerView.isPlaholderCell_Max = YES;
        rulerView.isPlaholderCell_Min = NO;
        rulerView.minValue = self.maxValue;
        rulerView.maxValue = self.maxValue + _step * _betweenNum;
    }else{
        rulerView.isPlaholderCell_Max = NO;
        rulerView.isPlaholderCell_Min = NO;
        rulerView.minValue = _step * (indexPath.item - 1) * _betweenNum + _minValue;
        rulerView.maxValue = _step * indexPath.item * _betweenNum;
    }
        
    [rulerView setNeedsDisplay];
    return cell;
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0 || indexPath.item == _stepNum + 1){
        return CGSizeMake(self.frame.size.width / 2, RVCShareIns.rulerView_H);
    }else{
        
        return CGSizeMake(RVCShareIns.rulerGap * _betweenNum, RVCShareIns.rulerView_H);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int value = scrollView.contentOffset.x / RVCShareIns.rulerGap;
    float totalValue = value*_step +_minValue;
    
    if (_scrollByHand) {
        if (totalValue >= _maxValue) {
            _valueTF.text = [NSString stringWithFormat:@"%.1f",_maxValue];
        }else if(totalValue <= _minValue){
            _valueTF.text = [NSString stringWithFormat:@"%.1f",_minValue];
        }else{
            _valueTF.text = [NSString stringWithFormat:@"%.1f",value*_step +_minValue];
        }
    }
    
    
    if (totalValue > _maxValue) {
        totalValue = _maxValue;
    }
    
    if (totalValue < _minValue) {
        totalValue = _minValue;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sbScrollRulerView:valueChange:)]) {
        [self.delegate sbScrollRulerView:self valueChange:totalValue];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{//拖拽时没有滑动动画
    if (!decelerate){
        [self setRealValue:round(scrollView.contentOffset.x/(RVCShareIns.rulerGap)) animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setRealValue:round(scrollView.contentOffset.x/(RVCShareIns.rulerGap)) animated:YES];
}


@end
