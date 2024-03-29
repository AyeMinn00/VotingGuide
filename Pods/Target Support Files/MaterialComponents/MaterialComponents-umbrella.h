#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MaterialActivityIndicator.h"
#import "MDCActivityIndicator.h"
#import "MDCActivityIndicatorDelegate.h"
#import "CAMediaTimingFunction+MDCAnimationTiming.h"
#import "MaterialAnimationTiming.h"
#import "UIView+MDCTimingFunction.h"
#import "MaterialAppBar.h"
#import "MDCAppBar.h"
#import "MDCAppBarContainerViewController.h"
#import "MDCAppBarNavigationController.h"
#import "MDCAppBarNavigationControllerToBeDeprecatedDelegate.h"
#import "MDCAppBarViewController.h"
#import "MDCAppBarViewControllerAccessibilityPerformEscapeDelegate.h"
#import "MaterialAvailability.h"
#import "MDCAvailability.h"
#import "MaterialBottomNavigation.h"
#import "MDCBottomNavigationBar.h"
#import "MDCBottomNavigationBarControllerDelegate.h"
#import "MDCBottomNavigationBarDelegate.h"
#import "MaterialButtonBar.h"
#import "MDCButtonBar.h"
#import "MDCButtonBarButton.h"
#import "MDCButtonBarDelegate.h"
#import "MaterialButtons.h"
#import "MDCButton.h"
#import "MDCFlatButton.h"
#import "MDCFloatingButton+Animation.h"
#import "MDCFloatingButton.h"
#import "MDCRaisedButton.h"
#import "MaterialElevation.h"
#import "MDCElevatable.h"
#import "MDCElevationOverriding.h"
#import "UIColor+MaterialElevation.h"
#import "UIView+MaterialElevationResponding.h"
#import "MaterialFlexibleHeader.h"
#import "MDCFlexibleHeaderContainerViewController.h"
#import "MDCFlexibleHeaderSafeAreaDelegate.h"
#import "MDCFlexibleHeaderView+ShiftBehavior.h"
#import "MDCFlexibleHeaderView.h"
#import "MDCFlexibleHeaderViewAnimationDelegate.h"
#import "MDCFlexibleHeaderViewController.h"
#import "MDCFlexibleHeaderViewDelegate.h"
#import "MDCFlexibleHeaderViewLayoutDelegate.h"
#import "MaterialFlexibleHeader+ShiftBehavior.h"
#import "MDCFlexibleHeaderShiftBehavior.h"
#import "MaterialFlexibleHeader+ShiftBehaviorEnabledWithStatusBar.h"
#import "MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar.h"
#import "MaterialHeaderStackView.h"
#import "MDCHeaderStackView.h"
#import "MaterialInk.h"
#import "MDCInkGestureRecognizer.h"
#import "MDCInkTouchController.h"
#import "MDCInkTouchControllerDelegate.h"
#import "MDCInkView.h"
#import "MDCInkViewDelegate.h"
#import "MaterialNavigationBar.h"
#import "MDCNavigationBar.h"
#import "MaterialPageControl.h"
#import "MDCPageControl.h"
#import "MaterialPalettes.h"
#import "MDCPalettes.h"
#import "MaterialRipple.h"
#import "MDCRippleTouchController.h"
#import "MDCRippleTouchControllerDelegate.h"
#import "MDCRippleView.h"
#import "MDCRippleViewDelegate.h"
#import "MDCStatefulRippleView.h"
#import "MaterialShadowElevations.h"
#import "MDCShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MDCShadowLayer.h"
#import "MaterialShapeLibrary.h"
#import "MDCCornerTreatment+CornerTypeInitalizer.h"
#import "MDCCurvedCornerTreatment.h"
#import "MDCCurvedRectShapeGenerator.h"
#import "MDCCutCornerTreatment.h"
#import "MDCPillShapeGenerator.h"
#import "MDCRoundedCornerTreatment.h"
#import "MDCSlantedRectShapeGenerator.h"
#import "MDCTriangleEdgeTreatment.h"
#import "MaterialShapes.h"
#import "MDCCornerTreatment.h"
#import "MDCEdgeTreatment.h"
#import "MDCPathGenerator.h"
#import "MDCRectangleShapeGenerator.h"
#import "MDCShapedShadowLayer.h"
#import "MDCShapedView.h"
#import "MDCShapeGenerating.h"
#import "MaterialTypography.h"
#import "MDCFontScaler.h"
#import "MDCFontTextStyle.h"
#import "MDCTypography.h"
#import "UIFont+MaterialScalable.h"
#import "UIFont+MaterialSimpleEquality.h"
#import "UIFont+MaterialTypography.h"
#import "UIFontDescriptor+MaterialTypography.h"
#import "MaterialApplication.h"
#import "UIApplication+MDCAppExtensions.h"
#import "MaterialColor.h"
#import "UIColor+MaterialBlending.h"
#import "UIColor+MaterialDynamic.h"
#import "MaterialIcons.h"
#import "MDCIcons+BundleLoader.h"
#import "MDCIcons.h"
#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialMath.h"
#import "MDCMath.h"
#import "MaterialUIMetrics.h"
#import "MDCLayoutMetrics.h"

FOUNDATION_EXPORT double MaterialComponentsVersionNumber;
FOUNDATION_EXPORT const unsigned char MaterialComponentsVersionString[];

