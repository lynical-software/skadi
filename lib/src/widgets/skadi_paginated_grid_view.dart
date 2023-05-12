import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';
import 'spacing.dart';

class SkadiPaginatedGridBuilder extends StatefulWidget {
  ///Delegate for GridView
  final SliverGridDelegate gridDelegate;

  ///Normal GridView padding
  final EdgeInsets padding;

  ///Normal GridView padding
  final int itemCount;

  ///Normal GridView padding
  final bool hasMoreData;

  ///Normal GridView padding
  final AsyncCallback dataLoader;

  ///If [SkadiPaginatedGridBuilder] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///GridView [physics]
  final ScrollPhysics physics;

  ///GridView [shrinkwrap]
  final bool shrinkWrap;

  ///Widget when loading for more data
  final Widget? loadingWidget;

  //
  final bool reverse;

  ///Widget to show when there is no data
  final Widget? onEmpty;

  ///Add provided scrollController to our PaginatedGridView
  ///Use case: Provided scroll controller usually happen when this GridView is inside another ListView,
  ///So we use provided scrollController to check for paginated trigger only but not attach to PaginatedList
  ///But sometime, provided ScrollController isn't attach to any parent ListView yet. So in that case it must be attach
  ///to our PaginatedList
  final bool attachProvidedScrollControllerToListView;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of ListView when there is an error
  final Widget Function()? errorWidget;

  ///Load more data if we reach this offset start from the bottom
  final double fetchOffset;

  ///Normal GridView itemBuilder
  final IndexedWidgetBuilder itemBuilder;

  ///
  final Axis scrollDirection;

  final bool autoFetchOnShortList;

  const SkadiPaginatedGridBuilder({
    Key? key,
    required this.gridDelegate,
    required this.dataLoader,
    required this.itemCount,
    required this.itemBuilder,
    required this.hasMoreData,
    this.onEmpty,
    this.shrinkWrap = false,
    this.fetchOffset = 0.0,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.physics = const ClampingScrollPhysics(),
    this.scrollController,
    this.attachProvidedScrollControllerToListView = false,
    this.hasError = false,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.errorWidget,
    this.autoFetchOnShortList = false,
  }) : super(key: key);
  @override
  State<SkadiPaginatedGridBuilder> createState() =>
      _SkadiPaginatedGridBuilderState();
}

class _SkadiPaginatedGridBuilderState extends State<SkadiPaginatedGridBuilder> {
  ScrollController? scrollController;
  int loadingState = 0;

  bool get _isPrimaryScrollView => widget.scrollController == null;

  void scrollListener(ScrollController controller) {
    if (widget.hasError) {
      return;
    }
    double offsetToFetch =
        controller.position.maxScrollExtent - widget.fetchOffset;
    if (controller.offset >= offsetToFetch) {
      loadingState += 1;
      onLoadingMoreData();
    }
  }

  void onLoadingMoreData() async {
    if (loadingState > 1) return;
    if (widget.hasMoreData) {
      await widget.dataLoader();
      if (mounted) {
        loadingState = 0;
      }
    }
  }

  void initController() {
    if (_isPrimaryScrollView) {
      scrollController = ScrollController();
      scrollController!.addListener(() => scrollListener(scrollController!));
    } else {
      widget.scrollController
          ?.addListener(() => scrollListener(widget.scrollController!));
    }
  }

  void checkInitialScrollPosition() {
    if (widget.autoFetchOnShortList) {
      Future.delayed(const Duration(milliseconds: 100)).then((timeStamp) {
        if (widget.itemCount > 0) {
          double maxExtents = _isPrimaryScrollView
              ? scrollController!.position.maxScrollExtent
              : widget.scrollController!.position.maxScrollExtent;
          if (maxExtents <= 0 && !widget.hasError) {
            onLoadingMoreData();
          }
        }
      });
    }
  }

  void removeListener() {
    if (_isPrimaryScrollView) {
      scrollController!.removeListener(() => scrollListener(scrollController!));
      scrollController?.dispose();
    } else {
      widget.scrollController
          ?.removeListener(() => scrollListener(widget.scrollController!));
    }
  }

  @override
  void initState() {
    initController();
    checkInitialScrollPosition();
    super.initState();
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SkadiProvider? skadiProvider = SkadiProvider.of(context);
    final bool isEmpty = widget.itemCount == 0;
    if (isEmpty) {
      if (widget.onEmpty != null) {
        return widget.onEmpty!;
      }
      if (skadiProvider?.noDataWidget != null) {
        return skadiProvider!.noDataWidget!.call(null);
      }
    }
    return CustomScrollView(
      controller: _isPrimaryScrollView
          ? scrollController
          : widget.attachProvidedScrollControllerToListView
              ? widget.scrollController
              : null,
      physics: widget.physics,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      slivers: [
        SliverPadding(
          padding: widget.padding,
          sliver: SliverGrid.builder(
            gridDelegate: widget.gridDelegate,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildBottomLoadingWidget(),
        ),
      ],
    );
  }

  Widget _buildBottomLoadingWidget() {
    if (widget.hasError) {
      return widget.errorWidget?.call() ??
          IconButton(
            onPressed: () => widget.dataLoader(),
            icon: const Icon(Icons.refresh),
          );
    }
    return widget.hasMoreData
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: widget.loadingWidget),
          )
        : emptySizedBox;
  }
}
