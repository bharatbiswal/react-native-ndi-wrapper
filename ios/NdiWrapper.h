#import <React/RCTBridgeModule.h>
#include "Processing.NDI.Lib.h"

@interface NdiWrapper : NSObject <RCTBridgeModule>

@property(nonatomic) NDIlib_find_instance_t my_ndi_find;

@end
