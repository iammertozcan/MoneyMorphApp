//
//  ViewController.m
//  MoneyMorphApp
//
//  Created by Mert Özcan on 24.05.2024.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"0.0 EUR", @"0.0 JPY", @"0.0 BGN", @"0.0 CZK", @"0.0 DKK", @"0.0 GBP", @"0.0 HUF", @"0.0 PLN", @"0.0 RON", @"0.0 SEK", @"0.0 CHF", @"0.0 INR", @"0.0 MXN"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Optional: Register a default UITableViewCell class for reuse
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (IBAction)buttonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
}

// UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Bold" size:15.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row: %ld", (long)indexPath.row);
}

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = YES;
    
    double inputValue = [self.inputField.text doubleValue];
        
        // Calculate the converted values
        double euroValue = inputValue * currencies.EUR;
        double jpyValue = inputValue * currencies.JPY;
        double bgnValue = inputValue * currencies.BGN;
        double czkValue = inputValue * currencies.CZK;
        double dkkValue = inputValue * currencies.DKK;
        double gbpValue = inputValue * currencies.GBP;
        double hufValue = inputValue * currencies.HUF;
        double plnValue = inputValue * currencies.PLN;
        double ronValue = inputValue * currencies.RON;
        double sekValue = inputValue * currencies.SEK;
        double chfValue = inputValue * currencies.CHF;
        double inrValue = inputValue * currencies.INR;
        double mxnValue = inputValue * currencies.MXN;
        
        // Update the data array with the new values
        self.data = @[
            [NSString stringWithFormat:@"%.2f EUR", euroValue],
            [NSString stringWithFormat:@"%.2f JPY", jpyValue],
            [NSString stringWithFormat:@"%.2f BGN", bgnValue],
            [NSString stringWithFormat:@"%.2f CZK", czkValue],
            [NSString stringWithFormat:@"%.2f DKK", dkkValue],
            [NSString stringWithFormat:@"%.2f GBP", gbpValue],
            [NSString stringWithFormat:@"%.2f HUF", hufValue],
            [NSString stringWithFormat:@"%.2f PLN", plnValue],
            [NSString stringWithFormat:@"%.2f RON", ronValue],
            [NSString stringWithFormat:@"%.2f SEK", sekValue],
            [NSString stringWithFormat:@"%.2f CHF", chfValue],
            [NSString stringWithFormat:@"%.2f INR", inrValue],
            [NSString stringWithFormat:@"%.2f MXN", mxnValue]
        ];
        
        // Reload the table view to reflect the updated data
        [self.tableView reloadData];
}

@end
