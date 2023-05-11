import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiSliverPaginatedListView extends StatefulWidget {
  ///Normal List view itemCount
  final int itemCount;

  ///Normal ListView itemBuilder
  final IndexedWidgetBuilder itemBuilder;

  ///Provider a widget if there's no item
  final Widget? onEmpty;

  ///
  final ScrollController scrollController;

  ///callback for getting more data when ScrollController reach max scrollExtends
  final AsyncCallback dataLoader;

  ///condition to check if we still have more data to fetch
  ///Example: currentItems == totalItems or currentPage == totalPages
  final bool hasMoreData;

  ///widget to show when we're fetching more data
  final Widget? loadingWidget;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of ListView when there is an error
  final Widget Function()? errorWidget;

  ///Load more data if we reach this offset start from the bottom
  ///Make sure to calculate with loading widget height
  final double fetchOffset;

  const SkadiSliverPaginatedListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.dataLoader,
    required this.hasMoreData,
    required this.scrollController,
    this.fetchOffset = 0.0,
    this.loadingWidget = const CircularProgressIndicator(),
    this.hasError = false,
    this.errorWidget,
    this.onEmpty,
  }) : super(key: key);
  @override
  State<SkadiSliverPaginatedListView> createState() =>
      _SkadiSliverPaginatedListViewState();
}

class _SkadiSliverPaginatedListViewState
    extends State<SkadiSliverPaginatedListView> {
  int loadingState = 0;

  void scrollListener() {
    if (widget.hasError) {
      return;
    }
    double offsetToFetch =
        widget.scrollController.position.maxScrollExtent - widget.fetchOffset;
    if (widget.scrollController.offset >= offsetToFetch) {
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
    assert(widget.scrollController.hasClients);
    if (!widget.scrollController.hasClients) {
      throw FlutterError("Please attach ScrollController to CustomScrollView");
    }
    widget.scrollController.addListener(scrollListener);
  }

  void checkInitialScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double maxExtents = widget.scrollController.position.maxScrollExtent;
      if (maxExtents <= 0 && !widget.hasError) {
        onLoadingMoreData();
      }
    });
  }

  void removeListener() {
    widget.scrollController.removeListener(scrollListener);
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
        return skadiProvider!.noDataWidget!.call(widget.dataLoader);
      }
    }
    return SliverList(
      key: widget.key,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == widget.itemCount) {
            return _buildBottomLoadingWidget();
          }
          return widget.itemBuilder(context, index);
        },
        childCount: widget.itemCount + 1,
      ),
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
