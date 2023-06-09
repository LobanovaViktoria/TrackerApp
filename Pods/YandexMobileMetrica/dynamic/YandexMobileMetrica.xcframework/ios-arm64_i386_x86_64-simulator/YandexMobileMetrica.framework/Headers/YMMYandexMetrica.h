/*
 * Version for iOS
 * © 2012–2019 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import <Foundation/Foundation.h>

#if __has_include("YMMCompletionBlocks.h")
    #import "YMMCompletionBlocks.h"
    #import "YMMErrorRepresentable.h"
#else
    #import <YandexMobileMetrica/YMMCompletionBlocks.h>
    #import <YandexMobileMetrica/YMMErrorRepresentable.h>
#endif

@class CLLocation;
@class YMMYandexMetricaConfiguration;
@class YMMReporterConfiguration;
@class YMMUserProfile;
@class YMMRevenueInfo;
@class YMMECommerce;
@protocol YMMYandexMetricaReporting;
@protocol YMMYandexMetricaPlugins;
@class YMMAdRevenueInfo;
#if !TARGET_OS_TV
@class WKUserContentController;
#endif

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYMMYandexMetricaErrorDomain;

typedef NS_ENUM(NSInteger, YMMYandexMetricaEventErrorCode) {
    YMMYandexMetricaEventErrorCodeInitializationError = 1000,
    YMMYandexMetricaEventErrorCodeInvalidName = 1001,
    YMMYandexMetricaEventErrorCodeJsonSerializationError = 1002,
    YMMYandexMetricaEventErrorCodeInvalidRevenueInfo = 1003,
    YMMYandexMetricaEventErrorCodeEmptyUserProfile = 1004,
    YMMYandexMetricaEventErrorCodeNoCrashLibrary = 1005,
    YMMYandexMetricaEventErrorCodeInternalInconsistency = 1006,
    YMMYandexMetricaEventErrorCodeInvalidBacktrace = 1007,
    YMMYandexMetricaEventErrorCodeInvalidAdRevenueInfo = 1008,
};

@interface YMMYandexMetrica : NSObject

/** Starts the statistics collection process.

 @param configuration Configuration combines all AppMetrica settings in one place.
 Configuration initialized with unique application key that is issued during application registration in AppMetrica.
 Application key must be a hexadecimal string in format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.
 The key can be requested or checked at https://appmetrica.yandex.com
 */
+ (void)activateWithConfiguration:(YMMYandexMetricaConfiguration *)configuration;

/** Reports a custom event.

 @param message Short name or description of the event.
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportEvent:(NSString *)message
          onFailure:(nullable void (^)(NSError *error))onFailure;

/** Reports a custom event with additional parameters.

 @param message Short name or description of the event.
 @param params Dictionary of name/value pairs that should be sent to the server.
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportEvent:(NSString *)message
         parameters:(nullable NSDictionary *)params
          onFailure:(nullable void (^)(NSError *error))onFailure;

/** Reports custom error messages.

 @param message Short name or description of the error
 @param exception Exception contains an NSException object that must be passed to the server. It can take the nil value.
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportError:(NSString *)message
          exception:(nullable NSException *)exception
          onFailure:(nullable void (^)(NSError *error))onFailure
DEPRECATED_MSG_ATTRIBUTE("Use reportError:options:onFailure: or reportNSError:options:onFailure:");

/** Reports an error of the `NSError` type.
 AppMetrica uses domain and code for grouping errors.
 
 Limits for `NSError`:
 - 200 characters for `domain`;
 - 50 key-value pairs for `userInfo`. 100 characters for a key length, 2000 for a value length;
 - 10 underlying errors using `NSUnderlyingErrorKey` as a key in `userInfo`;
 - 200 stack frames in a backtrace using `YMMBacktraceErrorKey` as a key in `userInfo`.
 If the value exceeds the limit, AppMetrica truncates it.
 
 @note You can also report custom backtrace in `NSError`, see the `YMMBacktraceErrorKey` constant.

 @param error The error to report.
 @param onFailure Block to be executed if an error occurres while reporting, the error is passed as block argument.
 */
+ (void)reportNSError:(NSError *)error
            onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(nserror:onFailure:));

/** Reports an error of the `NSError` type.
 AppMetrica uses domain and code for grouping errors.
 Use this method to set the reporting options.
 
 Limits for `NSError`:
 - 200 characters for `domain`;
 - 50 key-value pairs for `userInfo`. 100 characters for a key length, 2000 for a value length;
 - 10 underlying errors using `NSUnderlyingErrorKey` as a key in `userInfo`;
 - 200 stack frames in a backtrace using `YMMBacktraceErrorKey` as a key in `userInfo`.
 If the value exceeds the limit, AppMetrica truncates it.
 
 @note You can also report custom backtrace in `NSError`, see the `YMMBacktraceErrorKey` constant.
 
 @param error The error to report.
 @param options The options of error reporting.
 @param onFailure Block to be executed if an error occurres while reporting, the error is passed as block argument.
 */
+ (void)reportNSError:(NSError *)error
              options:(YMMErrorReportingOptions)options
            onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(nserror:options:onFailure:));

/** Reports a custom error.
 @note See `YMMErrorRepresentable` for more information.

 @param error The error to report.
 @param onFailure Block to be executed if an error occurres while reporting, the error is passed as block argument.
 */
+ (void)reportError:(id<YMMErrorRepresentable>)error
          onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(error:onFailure:));

/** Reports a custom error.
 Use this method to set the reporting options.
 @note See `YMMErrorRepresentable` for more information.

 @param error The error to report.
 @param options The options of error reporting.
 @param onFailure Block to be executed if an error occurres while reporting, the error is passed as block argument.
 */
+ (void)reportError:(id<YMMErrorRepresentable>)error
            options:(YMMErrorReportingOptions)options
          onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(error:options:onFailure:));

/** Sends information about the user profile.
 
 @param userProfile The `YMMUserProfile` object. Contains user profile information.
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportUserProfile:(YMMUserProfile *)userProfile
                onFailure:(nullable void (^)(NSError *error))onFailure;

/** Sends information about the purchase.

 @param revenueInfo The `YMMRevenueInfo` object. Contains purchase information
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportRevenue:(YMMRevenueInfo *)revenueInfo
            onFailure:(nullable void (^)(NSError *error))onFailure;

/** Sets the ID of the user profile.

 @warning The value can contain up to 200 characters
 @param userProfileID The custom user profile ID
 */
+ (void)setUserProfileID:(nullable NSString *)userProfileID;

/** Enables/disables statistics sending to the AppMetrica server.

 @note Disabling this option also turns off data sending from the reporters that initialized for different apiKey.

 @param enabled Flag indicating whether the statistics sending is enabled. By default, the sending is enabled.
 */
+ (void)setStatisticsSending:(BOOL)enabled;

/** Enables/disables location reporting to AppMetrica.
 If enabled and location set via setLocation: method - that location would be used.
 If enabled and location is not set via setLocation,
 but application has appropriate permission - CLLocationManager would be used to acquire location data.
 
 @param enabled Flag indicating if reporting location to AppMetrica enabled
 Enabled by default.
 */
+ (void)setLocationTracking:(BOOL)enabled;

/** Sets location to AppMetrica.
 To enable AppMetrica to use this location trackLocationEnabled should be 'YES'

 @param location Custom device location to be reported.
 */
+ (void)setLocation:(nullable CLLocation *)location;

/** Retrieves current version of library.
 */
+ (NSString *)libraryVersion;

/** Retrieves unique AppMetrica device identifier. It is used to identify a device in the statistics.

 @note AppMetrica device ID is used in the Logs API and Post API as 'appmetrica_device_id'.

 @param queue Queue for the block to be dispatched to. If nil, main queue is used.
 @param block Block will be dispatched upon identifier becoming available or in a case of error.
 */
+ (void)requestAppMetricaDeviceIDWithCompletionQueue:(nullable dispatch_queue_t)queue
                                     completionBlock:(YMMAppMetricaDeviceIDRetrievingBlock)block;

/** Handles the URL that has opened the application.
 Reports the URL for deep links tracking.

 @param url URL that has opened the application.
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

/** Activates reporter with specific configuration.

 @param configuration Configuration combines all reporter settings in one place.
 Configuration initialized with unique application key that is issued during application registration in AppMetrica.
 Application key must be a hexadecimal string in format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.
 The key can be requested or checked at https://appmetrica.yandex.com
 */
+ (void)activateReporterWithConfiguration:(YMMReporterConfiguration *)configuration;

/** Returns id<YMMYandexMetricaReporting> that can send events to specific API key.
 To customize configuration of reporter activate with 'activateReporterWithConfiguration:' method first.

 @param apiKey Api key to send events to.
 @return id<YMMYandexMetricaReporting> that conforms to YMMYandexMetricaReporting and handles 
 sending events to specified apikey
 */
+ (nullable id<YMMYandexMetricaReporting>)reporterForApiKey:(NSString *)apiKey;

/**
 * Sets referral URL for this installation. This might be required to track some specific traffic sources like Facebook.
 * @param url referral URL value.
 */
+ (void)reportReferralUrl:(NSURL *)url;

/** Sends all stored events from the buffer.

 AppMetrica SDK doesn't send events immediately after they occurred. It stores events data in the buffer.
 This method sends all the data from the buffer and flushes it.
 Use the method to force stored events sending after important checkpoints of user scenarios.

 @warning Frequent use of the method can lead to increasing outgoing internet traffic and energy consumption.
 */
+ (void)sendEventsBuffer;

/** Resumes the last session or creates a new one if it has been expired.
 
 @warning You should disable the automatic tracking before using this method.
 See the sessionsAutoTracking property of YMMYandexMetricaConfiguration.
 */
+ (void)resumeSession;

/** Pauses the current session.
 All events reported after calling this method and till the session timeout will still join this session.

 @warning You should disable the automatic tracking before using this method.
 See the sessionsAutoTracking property of YMMYandexMetricaConfiguration.
 */
+ (void)pauseSession;

/** Sets a key-value pair associated with errors and crashes.
 @note
 AppMetrica uses it as additional information for further unhandled exceptions.
 If the value is nil, AppMetrica removes the previously set key-value pair.

 @param value Error environment value.
 @param key Error environment key.
 */
+ (void)setErrorEnvironmentValue:(nullable NSString *)value forKey:(NSString *)key;

/** Sends information about the E-commerce event.

 @note See `YMMEcommerce` for all possible E-commerce events.

 @param eCommerce The object of `YMMECommerce` class.
 @param onFailure Block to be executed if an error occurs while reporting, the error is passed as block argument.
 */
+ (void)reportECommerce:(YMMECommerce *)eCommerce
              onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(eCommerce:onFailure:));

#if !TARGET_OS_TV
/**
 * Adds interface named "AppMetrica" to WKWebView's JavaScript.
 * It enabled you to report events to AppMetrica from JavaScript code.
 * @note
 * This method must be called before adding any WKUserScript that uses AppMetrica interface or creating WKWebView.
 * Example:
 * ````
 * WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
 * WKUserContentController *userContentController = [WKUserContentController new];
 * [YMMYandexMetrica initWebViewReporting:userContentController
                                onFailure:nil];
 * [userContentController addUserScript:self.scriptWithAppMetrica];
 * webConfiguration.userContentController = userContentController;
 * self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webConfiguration];
 * ````
 * After web view reporting is initialized you can report event to AppMetrica from your JavaScript code the following way:
 * ````
 * function reportToAppMetrica(eventName, eventValue) {
 *     AppMetrica.reportEvent(eventName, eventValue);
 * }
 * ````
 * Here eventName is any non-empty String, eventValue is a JSON String, may be null or empty.
 *
 * @param userContentController UserContentController object used in WebView's configuration
 * @param onFailure Block to be executed if an error occurs while initializing web view reporting,
 *                  the error is passed as block argument.
 */
+ (void)initWebViewReporting:(WKUserContentController *)userContentController
                   onFailure:(nullable void (^)(NSError *error))onFailure;
#endif

/**
 * Creates a `YMMYandexMetricaPlugins` that can send plugin events to main API key.
 * Only one `YMMYandexMetricaPlugins` instance is created.
 * You can either query it each time you need it, or save the reference by yourself.
 * NOTE: to use this extension you must activate AppMetrica first
 * via `[YMMYandexMetrica activateWithConfiguration:]`.
 *
 * @return plugin extension instance
 */
+ (id<YMMYandexMetricaPlugins>)getPluginExtension;

/**
 * Sends information about ad revenue.
 * @note See `YMMAdRevenueInfo` for more info.
 *
 * @param adRevenue Object containing the information about ad revenue.
 * @param onFailure Block to be executed if an error occurs while sending ad revenue,
 *                  the error is passed as block argument.
 */
+ (void)reportAdRevenue:(YMMAdRevenueInfo *)adRevenue
              onFailure:(nullable void (^)(NSError *error))onFailure NS_SWIFT_NAME(report(adRevenue:onFailure:));
@end

NS_ASSUME_NONNULL_END
