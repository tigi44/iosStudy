//
//  ISDebugLog.h
//  iosStudy
//
//  Created by tigi on 2018. 2. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#ifndef ISDebugLog_h
#define ISDebugLog_h

#if DEBUG
#   define ISDebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define ISDebugLog(...)
#endif

#endif /* ISDebugLog_h */
