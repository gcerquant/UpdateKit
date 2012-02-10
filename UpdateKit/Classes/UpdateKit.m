//
//  UpdateKit.m
//  UpdateKit
//
//  Created by Guillaume Cerquant on 1/6/12.
//  Copyright (c) 2012 MacMation. All rights reserved.
//

#include "TargetConditionals.h"

#ifndef __has_feature
#define __has_feature(x) 0 /* for non-clang compilers */
#endif
#if ! __has_feature(objc_arc)
#warning The code of this file is ARC-enabled. Add the -f-objc-arc tag
#endif

//NSString const * kUpdateKitHostname = @"http://192.168.0.13:4200"; Keeping this around for debug
NSString const * kUpdateKitHostname = @"http://localhost:4242"; // Keeping this around for debug
//NSString * const kUpdateKitHostname = @"http://updateKit.com";

NSString * const kPreferenceProductURL = @"productURL";

#import "LambdaAlert.h"
#import "AFJSONRequestOperation.h"

#import "UpdateKit.h"


@implementation UpdateKit



+ (void)checkForUpdate {
    
    NSLog(@"Checking if update is published on AppStore, with UpdateKit. www.updatekit.com. (Library version: %@", kCurrentVersionNumber);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersionNumber = [infoDictionary valueForKey:@"CFBundleVersion"];
    
    NSURL *url = [NSURL URLWithString:[kUpdateKitHostname stringByAppendingFormat:@"/ios_applications/bundle_identifier/%@/update_info.json?version_number=%@&system_version=%@", [infoDictionary valueForKey:@"CFBundleIdentifier"], currentVersionNumber, [[UIDevice currentDevice] systemVersion]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        
//                                                                                            NSLog(@"json result: %@", json);
//                                                                                            NSLog(@"Update?: %d", [[json valueForKey:@"update_is_available"] boolValue]);
        if ([json valueForKey:@"error"]) {
            NSLog(@"Error while getting update information: %@", [json valueForKey:@"error"]);
            return;
        }
                                                                                            
                                                                                    
        if ([json valueForKey:@"product_url"]) {
            [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"product_url"] forKey:kPreferenceProductURL];
        }
        if ([[json valueForKey:@"update_is_available"] boolValue]) {
            
            LambdaAlert *updateAvailableAlert = [[LambdaAlert alloc] initWithTitle:@"Mise à jour disponible" message:[NSString stringWithFormat: @"Une mise à jour de l'application est disponible : version %@.\nVous avez actuellement la version %@", [json valueForKey:@"new_version_number"], currentVersionNumber]];
            
            [updateAvailableAlert addButtonWithTitle:@"Annuler" block:^{ // If you want to live in the past, it is your choice, Billy!
            }];
            
            [updateAvailableAlert addButtonWithTitle:@"Mettre à jour" block:^{

#if TARGET_IPHONE_SIMULATOR

                [[[UIAlertView alloc] initWithTitle:@"Update only on device" message:@"We do not update the application while running in the simulator.\nIf you were on the device, the update page would be opened." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
#else
                
                NSString *updateURL = [json valueForKey:@"update_url"];
                if (updateURL) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateURL]];
                } else {
                    NSLog(@"Invalid update url: %@", updateURL);
                }
#endif
            }];
            [updateAvailableAlert show];
        } else {
            // No update available
        }
        
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Error getting update information: %@", error);
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    
    
}

+ (NSString *) linkOfMyAppStorePage {
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kPreferenceProductURL]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:kPreferenceProductURL];
    } else {
        return [kUpdateKitHostname stringByAppendingFormat:@"/ios_applications/bundle_identifier/%@/redirect_to_product_page", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"]];
    }
}



@end
