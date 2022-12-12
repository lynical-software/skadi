## [2.0.1] - 12 December 2022
- 

## [2.0.0] - 15 November 2022

- **breaking change**
    - Remove `SkadiLoadingButton` because `SkadiAsyncButton` can now work the same way
    - Remove `separator` from PaginatedList, user `separatorBuilder` instead
- allow nullable parameter on some widgets (non breaking)
- fix `validateField` validator
- add `wrapRow`, `warpRowExpanded`, `wrapColumn`, `wrapColumnExpanded` on Widget extension

## [1.0.0] - 23 October 2022

- Add `catchNothing`
- Add `loadingNotifier` and `onSurface` to `SkadiAsyncButton`
- Add `positiveTextStyle` to `SkadiConfirmationDialog`
- **breaking change**
    - `SkadiLoadingButton` to follow new ElevatedButton parameter name
    - `SkadiAsyncButton` to follow new ElevatedButton parameter name
    - `SkadiConfirmationDialog` parameter behavior change:
      - `onConfirm` and `onCancel` no longer pop dialog by default
- Fix SkadiAsyncButton width
- add `listenChild` to ValueListenable extension
- fix logger bug
## [0.2.0] - 28 September 2022

- Improve README
- Add setting for `Logger`
- Add `SkadiBadge`
- **breaking change**
    - `SkadiAsyncButton` to follow ElevatedButton parameter name

## [0.1.2] - 13 September 2022

- Add `analyticCallBack` for `SkadiRouteObserver`

## [0.1.1] - 8 September 2022

- Fix `SkadiNavigator` popTime
- Add new BuildContext extension for `SkadiNavigator`
- Improve `Dot` widget
- Add more `Examples`

## [0.1.0] - 7 September 2022

- Fix `SkadiResponsive` value being negative
- Add new widgets

## [0.0.3] - 7 September 2022

- adjust default `SkadiResponsive` value breakpoint
- Fix `SkadiResponsive.isMobile` return wrong value

## [0.0.2] - 29 August 2022

- Add more widgets

## [0.0.1] - 25 August 2022

- Initial release