//
//  ZCAdviseDetailViewController.m
//  xiaoDengTravel
//
//  Created by James on 17/1/4.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "ZCAdviseDetailViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "SSZipArchive.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

#import "ZCIntroduceCell.h"
#import "ZCAuthorCell.h"
#import "ZCTableHeadView.h"
#import "AdviseDetailModel.h"
#import "ZCRelateCell.h"

@interface ZCAdviseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,AdviseDetailHeadViewDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *relateArray;
@property (nonatomic, strong) NSMutableDictionary *authorDic;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MobileModel *mobile;
@property (nonatomic, strong) NSString *cover_updateTime;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *file;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *contentInfo;

//锦囊详情的高度
@property (nonatomic, assign) CGFloat titleHeight;
//锦囊作者信息的高度
@property (nonatomic, assign) CGFloat authorIntroduceHeight;
@property (nonatomic, strong) NSString *downPath;
//创建下载任务
@property (nonatomic, strong) NSURLSession *session;
//创建请求对象
@property (nonatomic, strong) NSURLRequest *downloadRequest;
//下载
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
//定义一个NSData类型的变量,接受下载下来的数据
@property (nonatomic, strong) NSData *data;


@end

@implementation ZCAdviseDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self reloadData];
}

/**
 *  加载数据
 */
-(void)reloadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:LATESTDETAIL,self.adviseID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        AdviseDetailModel *model = [[AdviseDetailModel alloc]init];
        [model mj_setKeyValues:rootDic];
        
        self.cover_updateTime = model.data.cover_updatetime;
        self.cover = model.data.cover;
        self.contentInfo = model.data.info;
        // 下载数据
        self.mobile = model.data.mobile;
        // 给relateArray 设置数据
        self.relateArray = model.data.related_guides;
        // 给authorArray 设置数据
        self.authorDic = model.data.authors[0];
        
        [self creatTableHeaderView];
        
        // 刷新控件
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 *  创建tableView
 */
-(void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    // 设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"ZCIntroduceCell" bundle:nil] forCellReuseIdentifier:@"IntroduceCell"];

//    self.tableView.rowHeight = 200;
    [self.view addSubview:_tableView];
}

/**
 *  创建tableView的headerView
 */
-(void)creatTableHeaderView {
    
    ZCTableHeadView *tableHeadView = [[ZCTableHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 250)];
    // 设置图片的内容
    NSString *imageStr = [NSString stringWithFormat:@"%@/670_420.jpg?cover_updatetime=%@",self.cover,self.cover_updateTime];
    [tableHeadView.headerImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"topnav"]];
    // 设置代理
    tableHeadView.delegate = self;
    
    // 给tableView设置tag值
    tableHeadView.tag = 500;
    // 下载
    self.downPath = [NSString stringWithFormat:@"%@?modified=%@",self.mobile.file,self.cover_updateTime];
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),self.cover_updateTime];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    
    if (isExist) {
        [tableHeadView.downloadBtn setTitle:@"打开" forState:UIControlStateNormal];
    } else {
    }
    _tableView.tableHeaderView = tableHeadView;
    
}
#pragma mark AdviseDetailHeadViewDelegate 方法的实现
-(void)downloandSleeve:(UIButton *)downLoadBtn {
    if ([downLoadBtn.titleLabel.text isEqualToString:@"下载"]) {
        ZCTableHeadView *head = (id)[self.view viewWithTag:500];
        head.progressView.hidden = false;
        // 开始下载
        [downLoadBtn setImage:[UIImage imageNamed:@"icon_trip_download@3x"] forState:UIControlStateNormal];
        [downLoadBtn setTitle:@"暂停" forState:UIControlStateNormal];
        // <1>配置NSURLSession的配置信息
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // <2>创建session对象 将配置信息与Session对象进行关联
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        // <3>将路径转化为NSURL
        NSURL *url = [NSURL URLWithString:_downPath];
        // <4>请求对象
        self.downloadRequest = [NSURLRequest requestWithURL:url];
        // <5>进行数据请求
        self.task = [_session downloadTaskWithRequest:_downloadRequest];
        // <6>开始请求
        [_task resume];
    } else if ([downLoadBtn.titleLabel.text isEqualToString:@"暂停"]) {
        [downLoadBtn setTitle:@"继续" forState:UIControlStateNormal];
        // 暂停
        [downLoadBtn setImage:[UIImage imageNamed:@"icon_trip_download_pause@3x"] forState:UIControlStateNormal];
        [_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            //resumeData就是存放下来的数据
            _data = resumeData;
        }];
    } else if ([downLoadBtn.titleLabel.text isEqualToString:@"继续"]) {
        [downLoadBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [downLoadBtn setImage:[UIImage imageNamed:@"icon_trip_download_pause@3x"] forState:UIControlStateNormal];
        if (!_data) {
            NSURL *url = [NSURL URLWithString:_downPath];
            _downloadRequest = [NSURLRequest requestWithURL:url];
            _task = [_session downloadTaskWithRequest:_downloadRequest];
        } else {
            // 继续下载
            _task = [_session downloadTaskWithResumeData:_data];
        }
        [_task resume];
    } else {
        // 打开锦囊
        
    }
}

- (void)leftBackBtn:(UIButton *)leftBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark NSURLSessionDownloadDelegate的代理方法
/**
 *  任务下载完成后
 *
 *  @param session      任务
 *  @param downloadTask 下载的任务
 *  @param location     下载的地址
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // 获取存放信息的路径
    NSString *sleevepath = [NSString stringWithFormat:@"%@/%@.zip",NSHomeDirectory(),self.time];
    NSString *destinationPath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),self.time];
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath isDirectory:&isDir]) {
        
        [[NSFileManager defaultManager]createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    NSURL *url = [NSURL fileURLWithPath:sleevepath];
    // 通过文件管理对象将下载下来的文件路径移到URL路径下
    NSFileManager *manager= [NSFileManager defaultManager];
    [manager moveItemAtURL:location toURL:url error:nil];
    // 通过SSZipArchive进行压缩为zip格式
    [SSZipArchive unzipFileAtPath:sleevepath toDestination:destinationPath];
    [manager removeItemAtURL:url error:nil];
    
}

/**
 *  获取下载进度
 *
 *  @param session                   任务
 *  @param downloadTask              下载任务
 *  @param bytesWritten              下载数据
 *  @param totalBytesWritten         此时下载的二进制数据大小(进度)
 *  @param totalBytesExpectedToWrite 预期的下载量
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    //totalBytesWritten 此时下载的二进制数据大小(进度)
    CGFloat progress = (totalBytesWritten * 1.0)/totalBytesExpectedToWrite;
    //修改主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        ZCTableHeadView *head = [(id)self.view viewWithTag:500];
        head.progressView.progress = progress;
        if (progress == 1.0) {
            [head.downloadBtn setTitle:@"打开" forState:UIControlStateNormal];
            head.progressView.hidden = YES;
        }
    });
}

#pragma mark tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return self.relateArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 锦囊信息
            ZCIntroduceCell *introduceCell = [tableView dequeueReusableCellWithIdentifier:@"IntroduceCell"];
            if (introduceCell == nil) {
                introduceCell = [[ZCIntroduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntroduceCell"];
            }
            // 设置锦囊数据
            introduceCell.contentLabel.text = self.contentInfo;
            
            // 设置显示高度
            self.titleHeight = [introduceCell.contentLabel.text boundingRectWithSize:CGSizeMake(Screen_Width-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil].size.height;
            introduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return introduceCell;
        } else {
            static NSString *authCellId = @"AuthorCell";
            ZCAuthorCell *authorCell = [tableView dequeueReusableCellWithIdentifier:authCellId];
            authorCell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (authorCell == nil) {
                authorCell = [[ZCAuthorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:authCellId];
            }
            
        // 设置作者数据
        AuthorsModel *model = self.authorDic;
        authorCell.authorLabel.text = @"锦囊作者";
            authorCell.authorNameLabel.text = model.username;
        authorCell.authorIntroduceLabel.text = [NSString stringWithFormat:@"%@",model.intro];
        [authorCell.authorImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"bg_itinerary_null"]];
        self.authorIntroduceHeight = [authorCell.authorIntroduceLabel.text boundingRectWithSize:CGSizeMake(Screen_Width - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil].size.height;
            return authorCell;
        }
    } else {
        static NSString *relateID = @"relateCell";
        ZCRelateCell *relateCell = [tableView dequeueReusableCellWithIdentifier:relateID];
        if (relateCell == nil) {
            relateCell = [[ZCRelateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:relateID];
        }
        // 设置数据
        RelateModel *model = self.relateArray[indexPath.row];
        NSString *imgStr = [NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",model.cover,model.cover_updatetime];
        [relateCell.relateImage sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"hodel"]];
        relateCell.relateTitle.text = [NSString stringWithFormat:@"%@/%@",model.cnname,model.enname];
        relateCell.relateType.text = [NSString stringWithFormat:@"%@/%@",model.category_title,model.country_name_cn];
        if (model.download > 10000) {
            relateCell.relateDownloadNum.text = [NSString stringWithFormat:@"%ld万次下载",(model.download/10000)];
        } else {
            relateCell.relateDownloadNum.text = [NSString stringWithFormat:@"%ld次下载",model.download];
        }
        
        long count = [model.update_time longLongValue];
        time_t it;
        it = (time_t)count;
        struct  tm *local;
        local = localtime(&it);
        char buf[80];
        strftime(buf, 80, "%Y-%m-%d", local);
        relateCell.relateUpdate.text = [NSString stringWithFormat:@"%s更新",buf];
        return relateCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return (45+self.titleHeight)*(Screen_Height/667.0);
        }else{
            
           return (100+self.authorIntroduceHeight)*(Screen_Height/667.0);
        
        }
    }else{
        return 140*(Screen_Height/667.0);
    }
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 懒加载
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSMutableArray *)relateArray {
    if (_relateArray == nil) {
        _relateArray = [[NSMutableArray alloc]init];
    }
    return _relateArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
