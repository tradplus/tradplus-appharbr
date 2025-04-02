//
//  TPListViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2025/4/2.
//  Copyright © 2025 tradplus. All rights reserved.
//

#import "TPListViewController.h"
#import "TradPlusAdInterstitialViewController.h"

@interface TPListViewController ()
@property (nonatomic,assign)NSInteger adType; //0 = Interstitial
@property (nonatomic,strong)NSArray *pidList;
@property (nonatomic,strong)NSArray *nameList;
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation TPListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameList = @[@"Admob",
                      @"Pangle",
                      @"Mintegral",
                      @"Liftoff",
                      @"Bigo"];
    if(self.adType == 0)
    {
        self.pidList = @[@"43F3398FDB1DD36D4E79EC3F5898B952",
                         @"41F804F627EBF1E7F664076C97E14F6F",
                         @"D3F296A555262A4AC294E220C964F5E0",
                         @"BDEA8C4C60388A6E167D89AC40FDDEAB",
                         @"EC652B7445BA679E88CEFCF16332517E"];
    }
    self.tableView.rowHeight = 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.pidList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row < self.nameList.count)
    {
        cell.textLabel.text = self.nameList[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0.42 green:0.66 blue:0.85 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.adType == 0)
    {
        if(indexPath.row < self.pidList.count)
        {
            TradPlusAdInterstitialViewController *viewController = [[TradPlusAdInterstitialViewController alloc] initWithNibName:@"TradPlusAdInterstitialViewController" bundle:nil];
            viewController.pid = self.pidList[indexPath.row];
            viewController.name = self.nameList[indexPath.row];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

@end
