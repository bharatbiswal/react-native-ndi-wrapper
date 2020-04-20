#import "NdiWrapper.h"
#import <React/RCTLog.h>

#import <AFNetworking/AFNetworking.h>

@implementation NdiWrapper

RCT_EXPORT_MODULE()

// RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
// {
// 	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
// 	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
// 	[manager GET:@"https://httpstat.us/200" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
// 			callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@ resp: %@", numberArgument, stringArgument, responseObject]]);
// 	} failure:^(NSURLSessionTask *operation, NSError *error) {
// 			callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@ err: %@", numberArgument, stringArgument, error]]);
// 	}];
// }

RCT_REMAP_METHOD(findSources,
                 findSourcesWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  
  if (!self.my_ndi_find) {
    NDIlib_find_destroy(self.my_ndi_find);
    self.my_ndi_find = nil;
  }
  self.my_ndi_find = NDIlib_find_create_v2(nil);
  
  if (!self.my_ndi_find) {
      NSLog(@"ERROR: Failed to create finder");
  } else {
      NSLog(@"Successfully created finder");
  }
  
  bool source_list_has_changed = NDIlib_find_wait_for_sources(self.my_ndi_find, 3000/* 3 seconds */);
  
  uint32_t no_srcs; // This will contain how many senders have been found so far.
  const NDIlib_source_t* p_senders = NDIlib_find_get_current_sources(self.my_ndi_find, &no_srcs);
  
  NSMutableArray * sources = [[NSMutableArray alloc] init];
  for (int i=0; i< no_srcs; i++) {
    NDIlib_source_t aSender = p_senders[i];
    NSMutableDictionary * aSource = [[NSMutableDictionary alloc] init];
    [aSource setObject:[[NSString alloc] initWithUTF8String:aSender.p_ndi_name] forKey:@"p_ndi_name"];
    if (aSender.p_ip_address) {
      [aSource setObject:[[NSString alloc] initWithUTF8String:aSender.p_ip_address] forKey:@"p_ip_address"];
    }
    if (aSender.p_url_address) {
      [aSource setObject:[[NSString alloc] initWithUTF8String:aSender.p_url_address] forKey:@"p_url_address"];
    }
      [sources addObject:aSource];
  }
  
  NSLog(@"%@",sources);
  if (sources) {
      // if ([sources count] < 1) {
      //     // Sample test data
      //     [sources addObject:@{ @"p_ndi_name" : @"Test Name 1", @"p_ip_address" : @"128.11.234.12" }];
      //     [sources addObject:@{ @"p_ndi_name" : @"Test Name 2", @"p_url_address" : @"ndi://128.11.234.18" }];
      // }
    resolve(sources);
  } else {
    NSError *error = [NSError errorWithDomain:@"NdiSDKManager" code:400 userInfo:nil];
    reject(@"no_sources", @"There were no sources", error);
  }
}


@end
