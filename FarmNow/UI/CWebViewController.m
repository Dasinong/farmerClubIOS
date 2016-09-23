//
//  CWebViewController.m
//  FarmNow
//
//  Created by zheliang on 15/11/4.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWebViewController.h"

@interface CWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webVIew;
@property (nonatomic, assign) BOOL previousNavigationControllerToolbarHidden, previousNavigationControllerNavigationBarHidden;
@property (nonatomic, strong) UIBarButtonItem *backButton, *forwardButton, *refreshButton, *stopButton, *fixedSeparator, *flexibleSeparator;
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL showsURLInNavigationBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeight;
@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;
@end

@implementation CWebViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		self.showsURLInNavigationBar = NO;
		self.showsPageTitleInNavigationBar = YES;
		self.hideToolbar = YES;

		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	if (self.hideToolbar) {
		self.toolbarHeight.constant = 0;
		self.toolbar.hidden = self.hideToolbar;
	}
	else{
		self.toolbarHeight.constant = 44.f;
		self.toolbar.hidden = self.hideToolbar;
	}
	[self.webVIew setMultipleTouchEnabled:YES];
	[self.webVIew setAutoresizesSubviews:YES];
	[self.webVIew setScalesPageToFit:YES];
	[self.webVIew.scrollView setAlwaysBounceVertical:YES];
	
	self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
	[self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
	[self.progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-self.progressView.frame.size.height, self.view.frame.size.width, self.progressView.frame.size.height)];
	[self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
	if (self.address) {
		[self loadURLString:self.address];
	}
    
    if (self.title) {
        self.title = [self.title stringByStrippingHTML];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	
	[self.navigationController.navigationBar addSubview:self.progressView];
	
	[self updateToolbarState];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    self.webVIew.delegate = nil;
	[self.progressView removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setAddress:(NSString *)address
{
	_address = address;
	[self loadURLString:address];
}
- (void)loadRequest:(NSURLRequest *)request {
	if(self.webVIew) {
		[self.webVIew loadRequest:request];
	}
}

- (void)loadURL:(NSURL *)URL {
	[self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
	NSURL *URL = [NSURL URLWithString:URLString];
	[self loadURL:URL];
}
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(webView == self.webVIew) {
		
		if(![self externalAppRequiredToOpenURL:request.URL]) {
			self.uiWebViewCurrentURL = request.URL;
			self.uiWebViewIsLoading = YES;
			[self updateToolbarState];
			
			[self fakeProgressViewStartLoading];
			

			return YES;
		}
		else {
			[self launchExternalAppWithURL:request.URL];
			return NO;
		}
	}
	return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	if(webView == self.webVIew) {
		if(!self.webVIew.isLoading) {
			self.uiWebViewIsLoading = NO;
			[self updateToolbarState];
			
			[self fakeProgressBarStopLoading];
		}
		
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if(webView == self.webVIew) {
		if(!self.webVIew.isLoading) {
			self.uiWebViewIsLoading = NO;
			[self updateToolbarState];
			
			[self fakeProgressBarStopLoading];
		}

	}
}
#pragma mark - Toolbar State

- (void)updateToolbarState {
	
	BOOL canGoBack = self.webVIew.canGoBack;
	BOOL canGoForward = self.webVIew.canGoForward;
	
	[self.backButton setEnabled:canGoBack];
	[self.forwardButton setEnabled:canGoForward];
	
	if(!self.backButton) {
		[self setupToolbarItems];
	}
	
	NSArray *barButtonItems;
	if(self.uiWebViewIsLoading) {
		barButtonItems = @[self.backButton, self.fixedSeparator, self.forwardButton, self.fixedSeparator, self.stopButton, self.flexibleSeparator];
		
		if(self.showsURLInNavigationBar) {
			NSString *URLString;
			if(self.webVIew) {
				URLString = [self.uiWebViewCurrentURL absoluteString];
			}
			
			URLString = [URLString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
			URLString = [URLString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
			URLString = [URLString substringToIndex:[URLString length]-1];
			if (self.title == nil) {
				self.navigationItem.title = URLString;

			}
		}
	}
	else {
		barButtonItems = @[self.backButton, self.fixedSeparator, self.forwardButton, self.fixedSeparator, self.refreshButton, self.flexibleSeparator];
		
		if(self.showsPageTitleInNavigationBar) {
			if(self.webVIew) {
				if (self.title == nil) {
                    NSLog(@"%@",[self.webVIew stringByEvaluatingJavaScriptFromString:@"document.title"]);
					self.navigationItem.title = [self.webVIew stringByEvaluatingJavaScriptFromString:@"document.title"];

				}
			}
		}
	}
	
	
	[self.toolbar setItems:barButtonItems animated:YES];
	

	
	
}

- (void)setupToolbarItems {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	
	self.refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
	self.stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopButtonPressed:)];
	
	UIImage *backbuttonImage = [UIImage imageWithContentsOfFile: [bundle pathForResource:@"backbutton" ofType:@"png"]];
	self.backButton = [[UIBarButtonItem alloc] initWithImage:backbuttonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
	
	UIImage *forwardbuttonImage = [UIImage imageWithContentsOfFile: [bundle pathForResource:@"forwardbutton" ofType:@"png"]];
	self.forwardButton = [[UIBarButtonItem alloc] initWithImage:forwardbuttonImage style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonPressed:)];
	self.fixedSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	self.fixedSeparator.width = 50.0f;
	self.flexibleSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

#pragma mark - Done Button Action

- (void)doneButtonPressed:(id)sender {
	[self dismissAnimated:YES];
}

#pragma mark - UIBarButtonItem Target Action Methods

- (void)backButtonPressed:(id)sender {
	
	if(self.webVIew) {
		[self.webVIew goBack];
	}
	[self updateToolbarState];
}

- (void)forwardButtonPressed:(id)sender {
	if(self.webVIew) {
		[self.webVIew goForward];
	}
	[self updateToolbarState];
}

- (void)refreshButtonPressed:(id)sender {
	if(self.webVIew) {
		[self.webVIew stopLoading];
		[self.webVIew reload];
	}
}

- (void)stopButtonPressed:(id)sender {
	if(self.webVIew) {
		[self.webVIew stopLoading];
	}
}





#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
	[self.progressView setProgress:0.0f animated:NO];
	[self.progressView setAlpha:1.0f];
	
	if(!self.fakeProgressTimer) {
		self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
	}
}

- (void)fakeProgressBarStopLoading {
	if(self.fakeProgressTimer) {
		[self.fakeProgressTimer invalidate];
	}
	
	if(self.progressView) {
		[self.progressView setProgress:1.0f animated:YES];
		[UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
			[self.progressView setAlpha:0.0f];
		} completion:^(BOOL finished) {
			[self.progressView setProgress:0.0f animated:NO];
		}];
	}
}

- (void)fakeProgressTimerDidFire:(id)sender {
	CGFloat increment = 0.005/(self.progressView.progress + 0.2);
	if([self.webVIew isLoading]) {
		CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
		if(self.progressView.progress < 0.95) {
			[self.progressView setProgress:progress animated:YES];
		}
	}
}

#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
	NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
	return ![validSchemes containsObject:URL.scheme];
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
	self.URLToLaunchWithPermission = URL;
	if (![self.externalAppPermissionAlertView isVisible]) {
		[self.externalAppPermissionAlertView show];
	}
	
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(alertView == self.externalAppPermissionAlertView) {
		if(buttonIndex != alertView.cancelButtonIndex) {
			[[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
		}
		self.URLToLaunchWithPermission = nil;
	}
}

#pragma mark - Dismiss

- (void)dismissAnimated:(BOOL)animated {

	[self.navigationController dismissViewControllerAnimated:animated completion:nil];
}
#pragma mark - Dealloc

- (void)dealloc {
	[self.webVIew setDelegate:nil];
    self.progressView = nil;

}
@end
