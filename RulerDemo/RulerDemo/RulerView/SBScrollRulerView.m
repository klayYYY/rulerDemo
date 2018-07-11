//
//  SBScrollRulerView.m
//  ShouBa
//
//  Created by wenjie on 2018/4/14.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBScrollRulerView.h"

#define RulerGap        50 //单位距离
#define RulerLong       80
#define RulerShort      60
#define TrangleWidth    25
#define CollectionHeight 100



/**
 绘制三角形标示
 */
@interface SBTriangleView : UIView
@property(nonatomic,strong)UIColor *triangleColor;

@end
@implementation SBTriangleView

- (void)drawRect:(CGRect)rect{
    //设置背景颜色
    [clear_color set];
    UIRectFill([self bounds]);
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path路径进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, TrangleWidth, 0);
    CGContextAddLineToPoint(context, TrangleWidth / 2.0, TrangleWidth / 2.0);
    CGContextSetLineCap(context, kCGLineCapButt);//线结束时是否绘制端点，该属性不设置。有方形，圆形，自然结束3中设置
    CGContextSetLineJoin(context, kCGLineJoinBevel);//线交叉时设置缺角。有圆角，尖角，缺角3中设置
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [_triangleColor setFill];//设置填充色
    [_triangleColor setStroke];//设置边框色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path，后属性表示填充
}

@end


/**
 绘制标尺刻度View
 */

@interface SBRulerView : UIView

@property (nonatomic,assign) NSInteger betweenNumber;
@property (nonatomic,assign) int minValue;
@property (nonatomic,assign) int maxValue;
@property (nonatomic,  copy) NSString *unit;
@property (nonatomic,assign) CGFloat step;

@end
@implementation SBRulerView

- (void)drawRect:(CGRect)rect{
    CGFloat startX = 0;
    CGFloat lineCenterX = RulerGap;
    CGFloat shortLineY  = rect.size.height - RulerLong;
    CGFloat longLineY = rect.size.height - RulerShort;
    CGFloat topY = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context,kCGLineCapButt);
    CGContextSetRGBStrokeColor(context, 255/255, 255/255, 255/255, 1.0);//设置线的颜色，默认是黑色
    for (int i = 0; i <= _betweenNumber; i ++){
        CGContextMoveToPoint(context, startX+lineCenterX*i, topY);
        if (i % _betweenNumber == 0){
            CGContextSetLineWidth(context, 2);//设置线的宽度，
            NSString *num = [NSString stringWithFormat:@"%.f%@",i*_step+_minValue,_unit];
            if ([num floatValue]>1000000){
                num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
            }
            
            NSDictionary *attribute = @{NSFontAttributeName:H18,NSForegroundColorAttributeName:white_color};
            CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            
            CGContextSetRGBStrokeColor(context, 255/255, 255/255, 255/255, 1.0);
            CGContextAddLineToPoint(context, startX + lineCenterX * i, longLineY);
            [num drawInRect:CGRectMake(startX + lineCenterX * i - width / 2, longLineY + 30, width, 30) withAttributes:attribute];
        }else{
            CGContextSetLineWidth(context, 1);//设置线的宽度，
            CGContextSetRGBStrokeColor(context, 255/255, 255/255, 255/255, 1.0);
            CGContextAddLineToPoint(context, startX+lineCenterX*i, shortLineY);
        }
        CGContextStrokePath(context);//开始绘制
    }
}

@end


/**
 标尺起始端view
 */
@interface SBHeaderRulerView : UIView

@property(nonatomic,assign)int minValue;
@property(nonatomic,  copy)NSString *unit;

@end

@implementation SBHeaderRulerView

- (void)drawRect:(CGRect)rect{
    CGFloat longLineY = rect.size.height - RulerShort;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 2);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context, rect.size.width, 0);
    NSString *num = [NSString stringWithFormat:@"%d%@",_minValue,_unit];
    if ([num floatValue]>1000000){
        num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:H18,NSForegroundColorAttributeName:white_color};
    CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [num drawInRect:CGRectMake(rect.size.width - width / 2, longLineY + 30, width, 30) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, longLineY);
    CGContextStrokePath(context);//开始绘制
}

@end




/**
 标尺结束端view
 */
@interface SBFooterRulerView : UIView

@property(nonatomic,assign)int maxValue;
@property(nonatomic,  copy)NSString *unit;
@end
@implementation SBFooterRulerView

- (void)drawRect:(CGRect)rect{
    CGFloat longLineY = rect.size.height - RulerShort;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 2);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context, 0, 0);//起始点
    NSString *num = [NSString stringWithFormat:@"%d%@",_maxValue,_unit];
    if ([num floatValue]>1000000) {
        num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
    }
    NSDictionary *attribute = @{NSFontAttributeName:H18,NSForegroundColorAttributeName:white_color};
    CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [num drawInRect:CGRectMake(0 - width / 2, longLineY + 30, width, 30) withAttributes:attribute];
    CGContextAddLineToPoint(context, 0, longLineY);
    CGContextStrokePath(context);//开始绘制
}

@end

/**
 标尺collectionView展示数据
 */
@interface SBScrollRulerView()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)SBTriangleView  *triangle;
@property(nonatomic, strong)UITextField     *valueTF;
@property(nonatomic, strong)UILabel         *unitLab;
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
        _minValue   = minValue;
        _maxValue   = maxValue;
        _step       = step;
        _stepNum    = (_maxValue-_minValue)/_step/betweenNum;
        _unit       = unit;
        _betweenNum = betweenNum;
        _bgColor    = [UIColor whiteColor];
        _triangleColor          = clear_color;//默认橙色
        self.backgroundColor    = white_color;
        
//        [self addSubview:self.valueTF];
//        [self addSubview:self.unitLab];
        [self addSubview:self.collectionView];
        [self addSubview:self.triangle];
//        self.unitLab.text = _unit;
    }
    return self;
}
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

#pragma mark - UI

- (void)setupSubViews{

}


#pragma mark - Lazy Load


- (SBTriangleView *)triangle{
    if (!_triangle) {
        _triangle = [[SBTriangleView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - TrangleWidth / 2, 0, TrangleWidth, TrangleWidth)];
        _triangle.triangleColor = white_color;
        _triangle.backgroundColor = [UIColor clearColor];
    }
    return _triangle;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - CollectionHeight, self.bounds.size.width, CollectionHeight) collectionViewLayout:flowLayout];

        _collectionView.backgroundColor = _bgColor;
        _collectionView.bounces         = YES;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.showsVerticalScrollIndicator    = NO;
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        _collectionView.contentSize     = CGSizeMake(_stepNum * _step + SCREEN_WIDTH / 2 - 26.f, CollectionHeight);
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"headCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"footerCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
    }
    return _collectionView;
}

#pragma mark - Target Or Method
+ (CGFloat)rulerViewHeight{
    return 20 + CollectionHeight;
}


-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    _collectionView.backgroundColor = _bgColor;
}
-(void)setTriangleColor:(UIColor *)triangleColor{
    _triangleColor = triangleColor;
    _triangle.triangleColor = _triangleColor;
}

-(void)setRealValue:(float)realValue{
    [self setRealValue:realValue animated:NO];
}
-(void)setRealValue:(float)realValue animated:(BOOL)animated{
    
    _realValue      = realValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",_realValue * _step + _minValue];
    [_collectionView setContentOffset:CGPointMake((int)realValue*RulerGap, 0) animated:animated];
}


-(void)setDefaultValue:(float)defaultValue animated:(BOOL)animated{
    _realValue      = defaultValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",defaultValue];
    
    [_collectionView setContentOffset:CGPointMake(((defaultValue-_minValue)/(float)_step)*RulerGap, 0) animated:animated];
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
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
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headCell" forIndexPath:indexPath];
        SBHeaderRulerView *headerView = [cell.contentView viewWithTag:1000];
        if (!headerView){
            headerView = [[SBHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, CollectionHeight)];
            headerView.backgroundColor  =  clear_color;
            headerView.tag              =  1000;
            headerView.minValue         = _minValue;
            headerView.unit             = _unit;
            [cell.contentView addSubview:headerView];
        }
        
        return cell;
    }else if( indexPath.item == _stepNum + 1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"footerCell" forIndexPath:indexPath];
        SBFooterRulerView *footerView = [cell.contentView viewWithTag:1001];
        if (!footerView){
            footerView = [[SBFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, CollectionHeight)];
            footerView.backgroundColor  = clear_color;
            footerView.tag              = 1001;
            footerView.maxValue         = _maxValue;
            footerView.unit             = _unit;
            [cell.contentView addSubview:footerView];
        }
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        SBRulerView *rulerView = [cell.contentView viewWithTag:1002];
        [rulerView removeFromSuperview];
        rulerView = nil;
        if (!rulerView){
            rulerView  = [[SBRulerView alloc] init];
            rulerView  = [[SBRulerView alloc]initWithFrame:CGRectMake(0, 0, RulerGap * _betweenNum, CollectionHeight)];
            rulerView.tag               = 1002;
            rulerView.step              = _step;
            rulerView.unit              = _unit;
            rulerView.betweenNumber     = _betweenNum;
            [cell.contentView addSubview:rulerView];
        }
        rulerView.backgroundColor = clear_color;
        rulerView.minValue = _step * (indexPath.item - 1) * _betweenNum + _minValue;
        rulerView.maxValue = _step * indexPath.item * _betweenNum;
        [rulerView setNeedsDisplay];
        
        return cell;
    }
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0 || indexPath.item == _stepNum + 1){
        return CGSizeMake(self.frame.size.width / 2, CollectionHeight);
    }else{
        return CGSizeMake(RulerGap * _betweenNum, CollectionHeight);
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int value = scrollView.contentOffset.x / RulerGap;
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
        [self setRealValue:round(scrollView.contentOffset.x/(RulerGap)) animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setRealValue:round(scrollView.contentOffset.x/(RulerGap)) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
