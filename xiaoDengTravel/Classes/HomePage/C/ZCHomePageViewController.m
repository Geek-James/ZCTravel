//
//  ZCHomePageViewController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/5.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCHomePageViewController.h"

#import "ZCAdView.h"
#import "ZCHeadView.h"
#import "ZCFootView.h"
#import "ZCFootBigCell.h"
#import "ZCFootCell.h"
#import "ZCMiddleBigCell.h"
#import "ZCMiddleCell.h"
#import "ZCLastCell.h"
#import "ZCAdViewView.h"
#import "ZCTravailDetailViewController.h"
#import "ZCSeeTipsViewController.h"

#import "SBAFNetWork.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"



@interface ZCHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,adViewViewDelegate,footViewDelegate>
{
    int currentPage;
    UICollectionView *_collectionView;
    BOOL _isRefresh;
    
}

@end

@implementation ZCHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    _dataArray = [[NSMutableArray alloc]initWithCapacity:3];
    [_dataArray addObject:@[]];
    [_dataArray addObject:@[]];
    [_dataArray addObject:@[]];
    [self addTitleViewTitle:@"爱旅行"];
    
    [self createCollectionView];
    [self requestDatatop];
    [self requestDataFoot];
    [self createRefresh];
}

-(void)createRefresh
{
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    
    [_collectionView.mj_header beginRefreshing];
    
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushRefresh)];
    
}
-(void)pullRefresh
{
    _isRefresh = YES;
    
    currentPage = 1;
    
    [self requestDataFoot];
}

-(void)pushRefresh
{
    _isRefresh = NO;
    
    currentPage ++;//每次请求下一页数据
    
    [self requestDataFoot];
}

-(void)requestDatatop
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:OTHER parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *data = [rootDic objectForKey:@"data"];
        
        NSArray *array1 = [data objectForKey:@"subject"];//发现下一站的数据
        
        NSMutableArray *array2 = [NSMutableArray new];//中间部分的数据
        
        NSArray *arraydis = [data objectForKey:@"discount_subject"];
        if (arraydis.count !=0) {
            [array2 addObject:arraydis[0]];
        }
        NSArray *arraydiscount = [data objectForKey:@"discount"];
        for (NSDictionary *discount in arraydiscount) {
            [array2 addObject:discount];
        }
        [_dataArray replaceObjectAtIndex:0 withObject:array1];
        [_dataArray replaceObjectAtIndex:1 withObject:array2];//装入大数组
        
        if (self.adArray.count !=0) {
            [self.adArray removeAllObjects];
        }
        
        NSArray *slide = [data objectForKey:@"slide"];//广告数据
        for (NSDictionary *slideDic in slide) {
            [self.adArray addObject:slideDic[@"photo"]];
            [self.urlArray addObject:slideDic[@"url"]];
        }
        if ([_dataArray[0] count]!=0) {
            [_collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)requestDataFoot
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString* URL=[NSString stringWithFormat:TRAVELNOTE1,currentPage,TRAVELONTE2];
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *data = [rootDic objectForKey:@"data"];
        if(currentPage > 1){
            for (NSDictionary *dic in data) {
                [_dataArray[2] addObject:dic];
            }
        }else{
            NSMutableArray *array3 = [NSMutableArray new];
            for (NSDictionary *dic in data) {
                [array3 addObject:dic];
            }
            [_dataArray replaceObjectAtIndex:2 withObject:array3];//底部数据装入大数组
        }
        
        if (_isRefresh) {
            [_collectionView.mj_header endRefreshing];
        }
        else
        {
            [_collectionView.mj_footer endRefreshing];
        }
        
        [_collectionView reloadData];//一定要reloadData;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
-(void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//水平方向滑动
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 自动布局
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_collectionView];
    //_collectionView.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];//灰色背景
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    
    // 创建五个不同的cell，登记注册
    [_collectionView  registerNib:[UINib nibWithNibName:@"ZCFootBigCell" bundle:nil] forCellWithReuseIdentifier:@"FootBigCell"];
    [_collectionView  registerNib:[UINib nibWithNibName:@"ZCFootCell" bundle:nil] forCellWithReuseIdentifier:@"FootCell"];
    [_collectionView  registerNib:[UINib nibWithNibName:@"ZCMiddleBigCell" bundle:nil] forCellWithReuseIdentifier:@"MiddleBigCell"];
    [_collectionView  registerNib:[UINib nibWithNibName:@"ZCMiddleCell" bundle:nil] forCellWithReuseIdentifier:@"MiddleCell"];
    [_collectionView  registerNib:[UINib nibWithNibName:@"ZCLastCell" bundle:nil] forCellWithReuseIdentifier:@"LastCell"];
    
    //创建广告头部
    [_collectionView registerClass:[ZCAdViewView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"adViewView"];
    
    //创建每组的头和尾
    [_collectionView registerClass:[ZCHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [_collectionView registerClass:[ZCFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
}
#pragma mark 代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    if ([_dataArray[0] count] == 0) {
        return 0;
    }
    return _dataArray.count;//返回组数
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray[section] count];//返回每一组的个数Item
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)//第一组
    {
        if (indexPath.row == 0)
        {
            ZCFootBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootBigCell" forIndexPath:indexPath];
            NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
            NSString *photo = [dic objectForKey:@"photo"];
            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:photo]];
            cell.imageV.layer.cornerRadius = 10;
            cell.imageV.layer.masksToBounds = YES;
            return cell;
        }
        else
        {
            ZCFootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootCell" forIndexPath:indexPath];
            NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
            NSString *photo = [dic objectForKey:@"photo"];
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:photo]];
            cell.icon.layer.cornerRadius = 8;
            cell.icon.layer.masksToBounds = YES;
            return cell;
        }
    }else if (indexPath.section==1)//第二组
    {
        if (indexPath.row==0)
        {
            ZCMiddleBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MiddleBigCell" forIndexPath:indexPath];
            NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
            [cell.middleImageV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"default.jpeg"]];
            cell.middleImageV.layer.cornerRadius = 5;
            cell.middleImageV.layer.masksToBounds = YES;
            return cell;
        }
        ZCMiddleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MiddleCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        NSString *photo = [dic objectForKey:@"photo"];
        [cell.MiddleImagev sd_setImageWithURL:[NSURL URLWithString:photo]];
        cell.MiddleImagev.layer.cornerRadius = 5;
        cell.MiddleImagev.layer.masksToBounds = YES;
        cell.infoLabel.text = [dic objectForKey:@"title"];
        cell.discountLabel.text = [dic objectForKey:@"priceoff"];
        NSString *strPrice = [dic objectForKey:@"price"];
        NSString* search = @"(>)(\\w+)(<)";
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            cell.PriceLabel.text = [NSString stringWithFormat:@"%@元起", [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)]];
        }
        
        return cell;
    }else//第三组
    {
        ZCLastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LastCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        [cell.iconV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"photo"]]];
        cell.iconV.layer.cornerRadius = 10;
        cell.iconV.layer.masksToBounds = YES;
        cell.authour.text = [dic objectForKey:@"username"];
        cell.authour.font = [UIFont boldSystemFontOfSize:16];
        cell.TitleLabel.text = [dic objectForKey:@"title"];
        cell.TitleLabel.textColor = [UIColor whiteColor];
        cell.TitleLabel.font = [UIFont boldSystemFontOfSize:22];
        cell.readLabel.text = [dic objectForKey:@"replys"];
        cell.likeLabel.text = [dic objectForKey:@"likes"];
        return cell;
    }
}
#pragma mark 设置大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return CGSizeMake(Screen_Width, 200*(Screen_Height/667.0));
        }
        else{
            return CGSizeMake((Screen_Width-6)/2, 160*(Screen_Height/667.0));
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            return CGSizeMake(Screen_Width, 200*(Screen_Height/667.0));
        }
        else{
            return CGSizeMake((Screen_Width-6)/2, 180*(Screen_Height/667.0));
        }
        
    }else
    {
        return CGSizeMake(Screen_Width, 180*(Screen_Height/667.0));
    }
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else{
        return 1;
    }
}

//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else{
        return 1;
    }
}

#pragma mark  点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && (indexPath.row ==1 && indexPath.row <4 )) {
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        ZCTravailDetailViewController *traval = [[ZCTravailDetailViewController alloc]init];
        traval.ID = [dic objectForKey:@"id"];
        [self presentViewController:traval animated:YES completion:nil];

    } else if (indexPath.section == 2) {
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        ZCTravailDetailViewController *datailView = [[ZCTravailDetailViewController alloc]init];
        datailView.url = [dic objectForKey:@"view_url"];
        [self presentViewController:datailView animated:YES completion:nil];

    } else {
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        ZCTravailDetailViewController *detailView = [[ZCTravailDetailViewController alloc]init];
        detailView.url = [dic objectForKey:@"url"];
        [self presentViewController:detailView animated:YES completion:nil];
        
    }
}

#pragma mark 设置头视图和脚视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            static NSString* adview=@"adViewView";//定义一个全局断点
            ZCAdViewView *ADview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:adview forIndexPath:indexPath];
            ADview.tag = 100;
            [self createAD];
            ADview.delegate = self;
            return ADview;
        }else{
            static NSString *footV = @"footView";
            ZCFootView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footV forIndexPath:indexPath];
            [foot.button setTitle:@"查看更多精彩专题>" forState:UIControlStateNormal];
            foot.delegate = self;
            return foot;
            
        }
    }else if (indexPath.section==1){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            static NSString *headV = @"headView";
            ZCHeadView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headV forIndexPath:indexPath];
            head.titleLable.text = @"  抢特价折扣";
            return head;
        }else
        {
            static NSString *footV = @"footView";
            ZCFootView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footV forIndexPath:indexPath];
            [foot.button setTitle:@"查看全部特价折扣  >" forState:UIControlStateNormal];
            foot.delegate = self;
            return foot;
        }
    }else
    {
        static NSString *headV = @"headView";
        ZCHeadView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headV forIndexPath:indexPath];
        head.titleLable.text = @"  看热门游记";
        return head;
    }
}
#pragma mark 设置每组头部和尾部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 300);
    }
    else
    {
        return CGSizeMake(Screen_Width, 30);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    //return CGSizeMake(Screen_Width, 30);
    if (section ==2) {
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(Screen_Width, 30);
    }
}

#pragma mark 实现两个代理方法
-(void)sendAdButton:(UIButton *)button {
    if (button.tag == 500) {
        // 点击了看锦囊
        ZCSeeTipsViewController *seeTip = [[ZCSeeTipsViewController alloc]init];
        [self.navigationController pushViewController:seeTip animated:YES];
        
    } else if (button.tag == 501) {
        // 点击了抢折扣
        
    }
}

-(void)sendButton:(UIButton *)button
{
    if (button.tag ==500) {
//        ZCBaseViewController *advise = [[ZCBaseViewController alloc]init];
//        [self.navigationController pushViewController:advise animated:YES];
        NSLog(@"%ld", button.tag);
    }
    else if (button.tag==501)
    {
//        ZCBaseViewController *advise = [[ZCBaseViewController alloc]init];
//        [self.navigationController pushViewController:advise animated:YES];
        NSLog(@"%ld", button.tag);
        
    }
}
-(void)createAD
{
    ZCAdViewView *adview = (ZCAdViewView *)[self.view viewWithTag:100];
    adview.array = _adArray;
    adview.scrollView.contentSize = CGSizeMake(_adArray.count*Screen_Width, 200);
    for (UIView *subview in adview.scrollView.subviews) {
        [subview removeFromSuperview];//移除
    }
    //点击图片能够滑动,跳转
    for (int i=0; i<_adArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.userInteractionEnabled = YES;
        imageV.frame = CGRectMake(i*Screen_Width, 0, Screen_Width, 200);
//        [imageV sd_setImageWithURL:[NSURL URLWithString:_adArray[i]]];
        [imageV sd_setImageWithURL:[NSURL URLWithString:_adArray[i]] placeholderImage:[UIImage imageNamed:@"default"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;//轻触的次数
        imageV.tag = 300+i;
        [imageV addGestureRecognizer:tap];
        [adview.scrollView addSubview:imageV];
        //i ++;
    }
    adview.page.currentPage = 0;
    adview.page.numberOfPages = _adArray.count;
}

-(void)tap:(UITapGestureRecognizer *)tap
{
//    int value = (int)[(UIImageView *)tap.view tag];
//    TravailDeTailViewController *detail = [[TravailDeTailViewController alloc]init];
//    detail.url = _urlArray[value-300];
//    //[self.navigationController pushViewController:detail animated:YES];
//    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark 懒加载
// 重写getter方法，用到的时候才初始化，经典的引用就是视图控制器的view
// 懒加载
-(NSMutableArray *)adArray
{
    if (_adArray == nil) {
        _adArray = [[NSMutableArray alloc]init];
    }
    return _adArray;
}
-(NSMutableArray *)urlArray
{
    if (_urlArray == nil) {
        _urlArray = [[NSMutableArray alloc]init];
    }
    return _urlArray;
}

@end
