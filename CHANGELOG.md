## [4.6.0] - 2 August 2024
- Bump intl version to 0.19.0

## [4.5.0] - 9 April 2024
- add new extension
- Improve Paginated View

## [4.4.0] - 28 February 2024
- add route validator to `SkadiNavigator`

## [4.3.2] - 15 December 2023
- fix debouncer dispose `SkadiPaginatedView`

## [4.3.1] - 14 December 2023
- add Debouncer to `SkadiPaginatedView`
- add `dispose` to `Debouncer`

## [4.3.0] - 13 December 2023
- Flutter 3.16 update

## [4.2.4] - 1 December 2023
- improve SkadiInjector

## [4.2.3] - 30 November 2023
- Code improvement
- New extension
  -  `zeroNumberReplacement` : **num**
  
## [4.2.2] - 22 November 2023
- Fix `SkadiSimpleDialog` content cutout on iOS
- Add `error` constructor to `SkadiSimpleDialog`
- New extension
  -  `rfs` : **TextStyle**

## [4.2.0] - 7 November 2023
- add `titleBuilder` for `SkadiAccordion`
  

## [4.1.0] - 26 October 2023
- Fix `SkadiConfirmationDialog` content cutout on iOS
- Improve `ReadmoreText` param
- New extension
  -  `responsive`, `beforeLast` : **List**
  -  `logObj` : **Object**
  -  `toBool`,`toDateTime`: **String**

## [4.0.0] - 5 October 2023
- fix export `SkadiInjector` and `SkadiLocator`
- New extension
  -  `formatUSDate` : **DateTime**
  -  `nullIfZero` : **num**
  -  `nullIfEmpty` **String**
- Now required dart `>= 3.0.0`

## [3.4.0] - 2 October 2023
- Add `ReadMoreText`

## [3.3.0] - 18 August 2023
- Improve `SkadiPaginatedListView` and `SkadiPaginatedGridView` loading mechanism
- Fix `SeparatorRow` and `SeparatorColumn` separator builder index

## [3.2.0] - 02 August 2023
- Breaking changes:
    - `SkadiPaginatedListView` and `SkadiPaginatedGridView` has a new param call `fetchOptions`.
- Support recursive fetch for `SkadiPaginatedListView` and `SkadiPaginatedGridView` if the List isn't scrollable while having more data

## [3.1.0] - 12 July 2023
- add `SeparatorRow`
- Rework SkadiAsyncIconButton style
- Fix Form validator empty space

## [3.0.1] - 7 July 2023
- add new param to SkadiRouteObserver
- Rework SkadiAsyncIconButton to use SkadiAsyncButton instead
- Small improvement

## [3.0.0] - 13 June 2023
- Update dependencies
- add `SkadiInjector` and `SkadiLocator`
- add new extension on number

## [2.7.4] - 12 May 2023
- Fix `PaginatedGridView` and `PaginatedListView` bugs 

## [2.7.2] - 12 May 2023
- Rename `TabAlignment` to `TabBarAlignment` to fix issue with Flutter 3.10

## [2.7.1] - 12 May 2023
- Fix `PaginatedGridView` and `PaginatedListView` bugs while item is empty

## [2.7.0] - 11 May 2023
- Improve `PaginatedGridView` and `PaginatedListView`
- Add `SkadiSliverPaginatedListView`

## [2.6.0] - 26 April 2023
- tweak some value in SkadiResponsive
- add new provider param for EllipsisText
- Improve parameter variable name

## [2.5.0] - 29 March 2023
- Bring back what's remove in SkadiResponsive in 2.4.0
- Add more extension and method for SkadiResponsive

## [2.4.2] - 27 March 2023
- fix SkadiAsyncButton loading notifier

## [2.4.1] - 21 March 2023
- fix extension name

## [2.4.0] - 18 March 2023
- Add `valueOf` to SkadiResponsive
- Add `responsive` to BuildContext extension
- remove screen size check from SkadiResponsive and add them to `BuildContext` extension instead

## [2.3.4] - 15 March 2023
- Add `get` in `ListExtension`
- Add `buildWhenTrue` in `ListenableExtension`

## [2.3.2] - 13 March 2023
- Fix `SeparatorColumn` bug

## [2.3.0] - 13 March 2023
- add `WillPopDisable`, `WillPopPrompt` and `CircularLoading`
- add `emptyReplacement` extension on `String`
- add `center` extension on `Widget`
- add `navigatorKey` to `SkadiNavigator`
- add `keepAlive` widget (AutomaticKeepAliveClientMixin)
- add `JsonMap` type

## [2.2.3] - 24 February 2023
- add `switchPosition` method to LoadingOverlayProvider
- `SkadiScaffold` now allow `PreferredSizeWidget` instead of `AppBar`

## [2.2.2] - 15 February 2023
- add `fetchOffset` to SkadiPaginatedWidget

## [2.2.1] - 1 February 2023
- fix `debugLog` log
- add `TimeOfDay` utils

## [2.2.0] - 27 January 2023
- bump `intl` down
- Fix types

## [2.1.1] - 27 January 2023
- fix pub score

## [2.1.0] - 26 January 2023
- **breaking change**
    - SkadiProvider `noDataWidget` has an onRefresh param callback

## [2.0.9] - 6 January 2023
- fix `SkadiScaffold` bugs

## [2.0.8] - 6 January 2023
- fix `SkadiAsyncIconButton` loading bugs

## [2.0.7] - 6 January 2023
- fix issue #3
- Add `SkadiScaffold`

## [2.0.6] - 5 January 2023
- export `kTs`

## [2.0.5] - 26 December 2022
- add TextStyle utils: `kTs`
- add `debugLog`
## [2.0.4] - 13 December 2022
- add `onDismiss` in KeyboardDismiss

## [2.0.3] - 13 December 2022
- `isTheSameDay` extension on DateTime is now nullable
- **breaking change**
    - update `semibold` to `semiBold` on Textstyle extension

## [2.0.2] - 12 December 2022
- add confirmPassword related method to SkadiFormMixin

## [2.0.1] - 12 December 2022
- fix issue [#2](https://github.com/lynical-software/skadi/issues/2) and [#3](https://github.com/lynical-software/skadi/issues/3)

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