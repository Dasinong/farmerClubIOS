//
//  CPersonalController.m
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import "CPersonalController.h"
#import "CPersonalCache.h"
#import "CUpdateProfileModel.h"
#import "CMyAddressController.h"
#import "CLogoutModel.h"
#import "CChangePasswordController.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import <PEPhotoCropEditor/PECropViewController.h>
#import <AVFoundation/AVFoundation.h>
#import "CStoresViewController.h"
#import "CSalesViewController.h"
#import "CUploadAvaterModel.h"


#define kDefaultAvatarSize CGSizeMake(256, 256)

@interface CPersonalController ()<CMyAddressControllerDelegate, QBImagePickerControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UINavigationControllerDelegate,PECropViewControllerDelegate>

@end

@implementation CPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+ (NSString *)cacheDir
{
	
	NSString * dir = [CPersonalController getAppDocPath];
	if(NO == [[NSFileManager defaultManager] fileExistsAtPath:dir])
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	return dir;
}

+ (NSString*) getAppDocPath
{
	static NSString* sAPPDOCPATH = nil;
	if (sAPPDOCPATH == nil)
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		if ([paths count] > 0)
		{
			sAPPDOCPATH = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
		}
	}
	return sAPPDOCPATH;
}

- (void)reloadData
{
	CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
	// Do any additional setup after loading the view.
	UITableViewModel* tableModel = [UITableViewModel new];
	[tableModel addRow:TABLEVIEW_ROW(@"headcell", object.pictureId?object.pictureId:@"") forSection:0];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @{@"手机号":object.cellPhone?object.cellPhone:@""}) forSection:1];
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @{@"修改密码":@""}) forSection:1];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @{@"姓名":object.userName?object.userName:@""}) forSection:2];
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @{@"我的住址":object.address?object.address:@""}) forSection:2];
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @{@"住宅电话":object.telephone?object.telephone:@""}) forSection:2];
	
	if (object) {
//		UIColor* btnColor = ;
		if (object.userType == nil) {
			NSDictionary* content =  @{@"title":@"农资商户认证",@"color":COLOR(0xF5964F)};
			[tableModel addRow:TABLEVIEW_ROW(@"btncell",content) forSection:3];
			
			content =  @{@"title":@"合作机构员工认证",@"color":COLOR(0x1EB1ED)};
			[tableModel addRow:TABLEVIEW_ROW(@"btncell", content) forSection:3];
		}

		NSDictionary* content  =  @{@"title":@"退出登录",@"color":COLOR(0x329A2A)};

		[tableModel addRow:TABLEVIEW_ROW(@"btncell", content) forSection:3];

	}
	
	[self updateModel:tableModel];
}

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	if (indexPath.section == 0) {
		CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
		if (object == nil) {
			[MBProgressHUD alert:@"请先登录"];
			return;
		}
		[self clickAvatar:nil];
	}
	else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			SCLAlertView *alert = [[SCLAlertView alloc] init];

			UITextField *textField = [alert addTextField:@"请输入手机号"];
			[alert addButton:@"确定" actionBlock:^(void) {
				
				CUpdateProfileParams* params = [CUpdateProfileParams new];
				params.cellphone = textField.text;
				[CUpdateProfileModel requestWithParams:params completion:^(CUpdateProfileModel* model, JSONModelError *err) {
					if (model && err == nil) {
						if ([model isKindOfClass:[CUpdateProfileModel class]]) {
							[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
							[self reloadData];
						}
						[MBProgressHUD alert:@"更新成功"];
					}
				}];
				
			}];

			
			[alert showEdit:self title:@"手机号" subTitle:@"请输入手机号" closeButtonTitle:@"取消" duration:0.0f];
		}
		if (indexPath.row == 1) {
			CChangePasswordController* controller = [self.storyboard controllerWithID:@"CChangePasswordController"];
			[self.navigationController pushViewController:controller animated:YES];
		}
	}
	else if (indexPath.section == 2) {
		if (indexPath.row == 0) {
			SCLAlertView *alert = [[SCLAlertView alloc] init];
			
			UITextField *textField = [alert addTextField:@"请输入姓名"];
			
			[alert addButton:@"确定" actionBlock:^(void) {
				
				CUpdateProfileParams* params = [CUpdateProfileParams new];
				params.username = textField.text;
				[CUpdateProfileModel requestWithParams:params completion:^(CUpdateProfileModel* model, JSONModelError *err) {
					if (model && err == nil) {
						if ([model isKindOfClass:[CUpdateProfileModel class]]) {
							[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
							[self reloadData];
						}
						[MBProgressHUD alert:@"更新成功"];
					}
				}];
				
			}];
			
			[alert showEdit:self title:@"姓名" subTitle:@"请输入姓名" closeButtonTitle:@"取消" duration:0.0f];

		}
		else if (indexPath.row == 1) {
			CMyAddressController* webController  = [self.storyboard controllerWithID:@"CMyAddressController"];
			webController.delegate = self;
			[self.navigationController pushViewController:webController animated:YES];
		}
		else if (indexPath.row == 2)
		{
			SCLAlertView *alert = [[SCLAlertView alloc] init];
			
			UITextField *textField = [alert addTextField:@"请输入住宅电话"];
			
			[alert addButton:@"确定" actionBlock:^(void) {
				
				CUpdateProfileParams* params = [CUpdateProfileParams new];
				params.telephone = textField.text;
				[CUpdateProfileModel requestWithParams:params completion:^(CUpdateProfileModel* model, JSONModelError *err) {
					if (model && err == nil) {
						if ([model isKindOfClass:[CUpdateProfileModel class]]) {
							[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
							[self reloadData];
						}
						[MBProgressHUD alert:@"更新成功"];
					}
				}];
				
			}];
			
			[alert showEdit:self title:@"住宅电话" subTitle:@"请输入住宅电话" closeButtonTitle:@"取消" duration:0.0f];
		}
	}
	else if (indexPath.section == 3)
	{
		if (indexPath.row == 0) {
			
			if (data) {
				NSString* title = data[@"title"];
				if ([title isEqualToString:@"退出登录"]) {
					[self logout];

				}
				else
				{
					CStoresViewController* controller = [self.storyboard controllerWithID:@"CStoresViewController"];
					[self.navigationController pushViewController:controller animated:YES];
				}

			}


			
		}
		else if (indexPath.row == 1){
		CSalesViewController* controller = [self.storyboard controllerWithID:@"CSalesViewController"];
		[self.navigationController pushViewController:controller animated:YES];		
			
		}
		else if (indexPath.row == 2) {
			[self logout];
		}
			}
}

- (void)logout
{
	CLogoutParams* params = [CLogoutParams new];
	[CLogoutModel requestWithParams:POST params:params completion:^(CLogoutModel* model, JSONModelError *err) {
		if (model && err ==nil) {
			if ([model.respCode isEqualToString: @"200"]) {
				[MBProgressHUD alert:@"退出成功"];
				[[CPersonalCache defaultPersonalCache] clearUserInfo];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else if ([model.respCode isEqualToString: @"110"])
			{
				[MBProgressHUD alert:@"登录过期，请重新登录"];
				
				[[CPersonalCache defaultPersonalCache] clearUserInfo];
				[self.navigationController popViewControllerAnimated:YES];
			}
		}
	}];

}

- (void)clickAvatar:(id)sender
{

	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
																 delegate:self
														cancelButtonTitle:nil
												   destructiveButtonTitle:nil
														otherButtonTitles:
									  NSLocalizedStringWithDefaultValue(@"TBImagePickerControllerSelectionCamera", nil, [NSBundle mainBundle], @"相机", nil),
									  NSLocalizedStringWithDefaultValue(@"TBImagePickerControllerSelectionLibrary", nil, [NSBundle mainBundle], @"从图片库中选取", nil),
									  @"取消",
									  nil];
		
		[actionSheet showInView:self.view];
	}
	else
	{
		[self showImagePickerView:UIImagePickerControllerSourceTypePhotoLibrary];
	}
} /* clickAvatar */
- (void)showImagePickerView:(UIImagePickerControllerSourceType)type
{

	if (type == UIImagePickerControllerSourceTypePhotoLibrary)
	{
		// Create the image picker
		QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
		imagePickerController.delegate                 = self;
		imagePickerController.allowsMultipleSelection  = NO;
//		imagePickerController.mediaType               = QBImagePickerMediaTypeImage;
		imagePickerController.maximumNumberOfSelection = 1;

		[self presentViewController:imagePickerController animated:YES completion:NULL];
		// Present modally
	}
	else
	{
		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
		
		pickerController.delegate   = self;
		pickerController.sourceType = type;
		Info(@"%@", self);
		[self presentViewController:pickerController animated:YES completion:nil];
	}
} /* showImagePickerView */
#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
		PHAsset    *asset     = [assets at:0];
	
	
	PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
	[imageManager requestImageForAsset:asset
							targetSize:PHImageManagerMaximumSize
						   contentMode:PHImageContentModeAspectFill
							   options:nil
						 resultHandler:^(UIImage *result, NSDictionary *info) {
							 [self cropImage:imagePickerController image:result];

							 // 得到一张 UIImage，展示到界面上
							 
						 }];
	
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
	[self dismissViewControllerAnimated:NO completion:nil];

}
//- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset
//{
//	ALAsset    *asset     = [assets at:0];
//	
//	// [self dismissViewControllerAnimated:NO completion:nil];
//	
//	CGImageRef  ratioThum = [asset aspectRatioThumbnail];
//	UIImage    *image     = [UIImage imageWithCGImage:ratioThum];
//	
//	[self cropImage:imagePickerController image:image];
//} /* imagePickerController */

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self showImagePickerView:UIImagePickerControllerSourceTypeCamera];
	}
	else if(buttonIndex == 1)
	{
		[self showImagePickerView:UIImagePickerControllerSourceTypePhotoLibrary];
	}
	else
	{
	}
} /* actionSheet */

- (void )actionSheetCancel:(UIActionSheet*)actionSheet
{
}

#pragma mark - helper
- (void)cropImage:(UIViewController*)controller image:(UIImage*)original_image
{
	PECropViewController *cropController = [[PECropViewController alloc] init];
	
	cropController.delegate = self;
	cropController.image    = original_image;
    
	cropController.keepingCropAspectRatio = YES;
	cropController.toolbarHidden          = YES;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cropController];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    cropController.cropAspectRatio = 1.0;
    
    [controller presentViewController:navigationController animated:YES completion:NULL];
} /* cropImage */

- (void)saveAvatar:(UIImage*)avatar
{
	// 缩放图片
    avatar = [avatar scaleToSize:kDefaultAvatarSize];
//	[self.avatarView setBackgroundImage:avatar forState:UIControlStateNormal];
//	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSData *data = UIImageJPEGRepresentation(avatar, 0.7);
		NSString* path = [NSString stringWithFormat:@"%@//avatar.jpg",[CPersonalController cacheDir]];
		
		[data writeToFile:path atomically:YES];
		NSURL* url = [NSURL fileURLWithPath:path];
		NSString* fileUrl = [url absoluteString];
		UITableViewRowModel* model = [self.tableViewModel modelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
		model.data = fileUrl;
		[self performSelectorOnMainThread:@selector(updateModel:) withObject:self.tableViewModel waitUntilDone:NO];
//		CUploadAvaterParams* params = [CUploadAvaterParams new];
		NSArray* contents =@[@{@"data":data, @"name":@"file" , @"filename":@"avatar.jpg"}];
		[CUploadAvaterModel postWithPath:@"uploadAvater" attachments:contents params:nil completion:^(CUploadAvaterModel *uploadAvaterModel, JSONModelError *err) {
			if (uploadAvaterModel && err == nil) {
                
                CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
                object.pictureId = uploadAvaterModel.data;
                
                UITableViewRowModel* model = [self.tableViewModel modelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                model.data = uploadAvaterModel.data;
                [self performSelectorOnMainThread:@selector(updateModel:) withObject:self.tableViewModel waitUntilDone:NO];
                [[CPersonalCache defaultPersonalCache] saveCacheUserInfo:object];
				[MBProgressHUD alert:@"上传成功"];
			}
		}];
	});
} /* saveAvatar */

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
	[self dismissViewControllerAnimated:NO completion: ^{
		// 如果是 来自照相机的image，那么先保存
		UIImage *original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
		UIImageWriteToSavedPhotosAlbum(original_image, self,
            @selector(image:didFinishSavingWithError:contextInfo:),
            nil);
		PECropViewController *controller = [[PECropViewController alloc] init];
		controller.delegate = self;
		controller.image = original_image;
		
        
		controller.keepingCropAspectRatio = YES;
        controller.cropAspectRatio = 1.0;
		controller.toolbarHidden = YES;
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
		}
		
		[self presentViewController:navigationController animated:YES completion:NULL];
	}];
	
	
	Info(@"%@", info);
} /* imagePickerController */

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
	if (!error)
	{
		NSLog(@"picture saved with no error.");
	}
	else
	{
		NSLog(@"error occured while saving the picture%@", error);
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
#pragma warning --- 点击头像,选择从相册中浏览, 然后取消,程序奔溃
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PECropViewControllerDelegate methods
- (void)cropViewController:(PECropViewController*)controller
	didFinishCroppingImage:(UIImage*)croppedImage
{
	[controller dismissViewControllerAnimated:NO completion:NULL];
	[self dismissViewControllerAnimated:NO completion:nil];
	[self saveAvatar:croppedImage];
}

- (void)cropViewControllerDidCancel:(PECropViewController*)controller
{
	[controller dismissViewControllerAnimated:NO completion:NULL];
	// [self saveAvatar:controller.image];
}



-(void)addressSelected:(NSString *)address
{
	CUpdateProfileParams* params = [CUpdateProfileParams new];
	params.address = address;
	[CUpdateProfileModel requestWithParams:params completion:^(CUpdateProfileModel* model, JSONModelError *err) {
		if (model && err == nil) {
			if ([model isKindOfClass:[CUpdateProfileModel class]]) {
				[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
				[self reloadData];
			}
			[MBProgressHUD alert:@"更新成功"];
		}
	}];
}

@end
