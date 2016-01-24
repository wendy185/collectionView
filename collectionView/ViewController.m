//
//  ViewController.m
//  collectionView
//
//  Created by 何白 on 15/12/29.
//  Copyright © 2015年 hebai. All rights reserved.
//

#import "ViewController.h"
#import "HBCollectionViewCell.h"
#import "HBCircularLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray *images;

//static NSString *const ID  = @"hebaiCollectionView";
@property  (assign, nonatomic) UICollectionView *collectionView ; 

@end

@implementation ViewController

//static 只有当前文件访问  const 不能修改的
static NSString *const ID = @"image";



- (NSMutableArray *)images{
    
    if (!_images) {
        self.images = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
    }
    return _images;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat w = self.view.frame.size.width;
    
    CGRect rect = CGRectMake(0, 100, w, 200);

    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[HBLineLayout new]];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;

//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:@"HBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    
    
}

#pragma mark - 数据源方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.images.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];

//    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
//    UIImage *image = [UIImage imageNamed:imageName];
//    cell.imageView.image = image;
    
    //传值过去 在cell里面 利用重写set方法赋值
    cell.imageNage = self.images[indexPath.item];
    
    
    return cell;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[HBLineLayout class]]) {
        
//        self.collectionView.collectionViewLayout = [UICollectionViewFlowLayout new];切换布局 collection 的set
//        [self.collectionView setCollectionViewLayout:[UICollectionViewFlowLayout new] animated:YES completion:^(BOOL finished) {
        
        [self.collectionView setCollectionViewLayout:[HBCircularLayout new] animated:YES completion:^(BOOL finished) {
            //
            NSLog(@"换成圆形布局了");
            
        }];
        
    }else{
   
//        self.collectionView.collectionViewLayout = [HBLineLayout new];
        [self.collectionView setCollectionViewLayout:[HBLineLayout new] animated:YES completion:^(BOOL finished) {
            NSLog(@"换成了白哥的自定义左右相册布局");
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%zd",indexPath.item);
    [self.images removeObjectAtIndex:indexPath.item];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
