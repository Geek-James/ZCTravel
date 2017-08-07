//
//  ZCAdView.m
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCAdView.h"

@interface ZCAdView()<UIScrollViewDelegate>
{
    // 记录当前显示的页数
    NSInteger _currentPage;
}

@property (nonatomic ,copy)GoBackBlock goBackBlack;


@end

@implementation ZCAdView
-(id)initWithArray:(NSArray *)array andFrame:(CGRect)frame andBlock:(GoBackBlock)back {
    if (self = [super init]) {
        self.frame = frame;
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
        NSString *s0 = arrayM[0];
        NSString *tailS = array[array.count -1];
        [arrayM insertObject:tailS atIndex:0];
        [arrayM addObject:s0];
        self.imageArray = [NSArray arrayWithArray:arrayM];
        // 设置ui
        [self configUI];
        self.goBackBlack = back;
        
    }
    return  self;
}

- (void)configUI {
    UIScrollView *src = [[UIScrollView alloc]initWithFrame:self.bounds];
//    src.backgroundColor = [UIColor yellowColor];
    // 创建滚动视图的子视图
    NSArray *imageArray = self.imageArray;
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*ADWIDTH,0, ADWIDTH, ADHEIGHT)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.backgroundColor = [UIColor blackColor];
        // 开启图片手势
        imageView.userInteractionEnabled = YES;
        [src addSubview:imageView];
        
        if (i == imageArray.count -2) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ADWIDTH, ADHEIGHT)];
            [btn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor clearColor];
            // 将按钮添加到图片上
            [imageView addSubview:btn];
        }
    }
    // 设置内容视图的大小
    src.contentSize = CGSizeMake(imageArray.count*ADWIDTH, ADHEIGHT) ;
    // 用户看到的第一张
    src.contentOffset = CGPointMake(ADWIDTH, 0);
    // 设置回弹效果
    src.bounces = NO;
    // 设置代理
    src.delegate = self;
    // 水平指示条
    src.showsHorizontalScrollIndicator = NO;
    // 设置翻页效果
    src.pagingEnabled = true;
    
    [self addSubview:src];
    
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(250, 250, 100, 50 )];
    page.numberOfPages = imageArray.count -2;
    page.pageIndicatorTintColor  = [UIColor yellowColor];
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    _currentPage = 1;
    //设置页码指示器的页码
    page.currentPage = _currentPage-1;
    page.tag = 20;
    //[self addSubview:page];

    

}

-(void)go{
    self.goBackBlack();
}

#pragma mark 协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    if (point.x == 0) {
        scrollView.contentOffset = CGPointMake(ADWIDTH*(self.imageArray.count-2), 0);
    }
    // 获得页码指示器
    UIPageControl *page = (UIPageControl *)[self viewWithTag:20];
    _currentPage = scrollView.contentOffset.x/ADWIDTH;
    page.currentPage = _currentPage - 1;
}
@end
