#import <Foundation/Foundation.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>
#import <notify.h>
#include <substrate.h>

static void rebootSpringBoard(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	[(SpringBoard *)[UIApplication sharedApplication] reboot];
}

static void relaunchSpringBoard(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	[(SpringBoard *)[UIApplication sharedApplication] relaunchSpringBoard];
}

static void languageChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	notify_post("com.apple.language.changed");
}

static void enterSafeMode(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	[(SpringBoard *)[UIApplication sharedApplication] performSelector:@selector(enterSafeMode)];
}

static void powerOff(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	[(SpringBoard *)[UIApplication sharedApplication] powerDown];
}

extern "C" void TweakInitialize() {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, rebootSpringBoard, CFSTR("com.philippe.springboard.reboot"), NULL, 0);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, relaunchSpringBoard, CFSTR("com.philippe.springboard.respring"), NULL, 0);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, languageChanged, CFSTR("com.philippe.springboard.langChanged"), NULL, 0);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, enterSafeMode, CFSTR("com.philippe.springboard.safeMode"), NULL, 0);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, powerOff, CFSTR("com.philippe.springboard.powerOff"), NULL, 0);
}