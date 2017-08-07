//
//  ZCSeeTipsViewController.m
//  xiaoDengTravel
//  看锦囊
//  Created by James on 16/12/26.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCSeeTipsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

#import "ZCLeftCell.h"
#import "LeftModel.h"
#import "ZCRightCell.h"
#import "ZCRightHeader.h"
#import "RightModel.h"
#import "ZCAdviseDetailViewController.h"

@interface ZCSeeTipsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UICollectionView *rightCollectionView;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableArray *rightArray;

@end

@implementation ZCSeeTipsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 加载数据
    [self requestData];
    // 加载左侧菜单的数据
    [self requestLeftData];
    // 加载右侧的数据
    [self requestRightData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置导航栏显示
    [self addTitleViewWithTitle:@"看锦囊"];
    
    // 设置左侧的tableView
    [self createLeftTab];
    // 设置右侧的collectionView
    [self createCollectionView];
}

// 加载左边数据
- (void)requestLeftData {
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:LEFTVIEW parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // json的序列化
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [rootDic objectForKey:@"data"];
        for (NSDictionary *dic in array) {
            LeftModel *model = [[LeftModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.leftArray addObject:model];
        }
        
        // 主线程刷新UI
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // time-consuming task
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftTableView reloadData];
                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:false scrollPosition:UITableViewScrollPositionTop];
                [SVProgressHUD dismiss];
            });
        });
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 加载右边数据
- (void)requestRightData {
    //  左边TableView选中的值
    LeftModel *model = _leftArray[_leftTableView.indexPathForSelectedRow.row];
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:RIGHT1,model.id,RIGHT2];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据的解析
        NSDictionary *rootData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        // 清空数据
        [_rightArray removeAllObjects];
        
        // 通过MJExtention转模型  将字典的键值对转化为模型
        RightModel *model = [[RightModel alloc]mj_setKeyValues:rootData];
        
        self.rightArray = model.data;
        // 主线程刷新UI
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // time-consuming task
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.rightCollectionView reloadData];
                [SVProgressHUD dismiss];
            });
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 加载数据
- (void)requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:LATEST parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据的序列化
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        // 清空数据
        [_rightArray removeAllObjects];
        // MJ数据字典转模型
        RightModel *model = [[RightModel alloc]init];
        [model mj_setKeyValues:rootDic];
        self.rightArray = model.data;
        [self.rightCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)createLeftTab {
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, Screen_Height) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 70;
    
    // 去除水平 垂直线
    self.leftTableView.showsVerticalScrollIndicator = false;
    self.leftTableView.showsVerticalScrollIndicator = false;
    
    // 给tableView注册一个cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCLeftCell class]) bundle:nil] forCellReuseIdentifier:@"leftCell"];
    
    [self.view addSubview:self.leftTableView];
}

-(void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80, 0, Screen_Width - 80, Screen_Height) collectionViewLayout:layout];
    self.rightCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.rightCollectionView.dataSource = self;
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.rightCollectionView];
    
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册一个collectionView
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"ZCRightCell" bundle:nil] forCellWithReuseIdentifier:@"RightCell"];
    
    // 注册一个collectionView的headView
    [self.rightCollectionView registerClass:[ZCRightHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
  
}



-(void)pullRefresh {
    [self requestRightData];
}
#pragma mark tableView代理方法的实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftArray.count == 0 ?0 :self.leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    LeftModel *model = self.leftArray[indexPath.row];
    cell.textLabel.text = model.cnname;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self requestRightData];
}
#pragma mark collectionView代理方法的实现
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    DaModel *model = _rightArray[section];
    return model.guides.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   
    return _rightArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCRightCell *right = [collectionView dequeueReusableCellWithReuseIdentifier:@"RightCell" forIndexPath:indexPath];
    DaModel *model = self.rightArray[indexPath.section];
    GuidesModel *guidModel = model.guides[indexPath.row];
    // 给图片设置数据
   NSString* imageStr = [NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",guidModel.cover,guidModel.cover_updatetime];
    [right.imageV sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"hodel.jpeg"]];
    // 给图片设置圆角
    right.imageV.layer.cornerRadius = 5;
    right.imageV.layer.masksToBounds = true;
    return right;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Screen_Width - 90)/3,160);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

// 设置collectionView的头部视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width - 80, 25*(Screen_Height/667));
}

//设置collectionView的头部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ZCRightHeader *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    DaModel *model = self.rightArray[indexPath.section];
    head.titleLabel.text = [NSString stringWithFormat:@"   %@",model.name];
    return head;
}

/**
 *  点击collection 处理事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCAdviseDetailViewController *adviseDetailView = [[ZCAdviseDetailViewController alloc]init];
    DaModel *model = self.rightArray[indexPath.section];
    GuidesModel *guid = model.guides[indexPath.row];
    adviseDetailView.adviseID = guid.guide_id;
        
    [self presentViewController:adviseDetailView animated:YES completion:nil];
    
}

#pragma mark 懒加载

-(NSMutableArray *)leftArray {
    if (_leftArray == nil) {
        _leftArray = [[NSMutableArray alloc]init];
    }
    return _leftArray;
}

-(NSMutableArray *)rightArray {
    if (_rightArray == nil) {
        _rightArray = [[NSMutableArray alloc]init];
    }
    return _rightArray;
}

- (void)addTitleViewWithTitle:(NSString *)title {
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.navigationItem.titleView = titleView;
    // 设置字体
    titleView.font = [UIFont systemFontOfSize:20];
    // 设置颜色
    titleView.textColor = [UIColor blackColor];
    // 设置文字居中
    titleView.textAlignment = NSTextAlignmentCenter;
    // 设置文本
    titleView.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
