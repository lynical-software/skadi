import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:skadi/skadi.dart';

class PaginationExample extends StatefulWidget {
  const PaginationExample({Key? key}) : super(key: key);

  @override
  State<PaginationExample> createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample>
    with DeferDispose {
  late FutureManager<UserResponse> userManager =
      FutureManager(reloading: false);
  late ScrollController scrollController =
      createDefer(() => ScrollController());
  late PaginationHandler<UserResponse, UserModel> paginationHandler =
      PaginationHandler(userManager);
  int maxTimeToShowError = 0;
  bool grid = true;

  Future fetchData([bool reload = false]) async {
    if (reload) {
      paginationHandler.reset();
    }
    await userManager.execute(
      () async {
        await SkadiUtils.wait(3000);
        infoLog("Page", paginationHandler.page);
        // if (paginationHandler.page > 2 && maxTimeToShowError < 2) {
        //   maxTimeToShowError++;
        //   throw "Expected error thrown from execute";
        // }

        final response = await Dio().get(
          "https://express-boilerplate-dev.lynical.com/api/user/all",
          queryParameters: {
            "page": paginationHandler.page,
            "count": 15,
          },
        );
        return UserResponse.fromJson(response.data);
      },
      reloading: reload,
      onSuccess: paginationHandler.handle,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pagination Example"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  grid = !grid;
                  fetchData(true);
                });
              },
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
        body: FutureManagerBuilder<UserResponse>(
          futureManager: userManager,
          ready: (context, UserResponse response) {
            if (grid) {
              return SkadiPaginatedGridBuilder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: response.data.length,
                hasMoreData: paginationHandler.hasMoreData,
                dataLoader: fetchData,
                fetchOptions: const SkadiListViewFetchOptions(
                  autoFetchOnShortList: true,
                  recursiveAutoFetch: true,
                  fetchOffset: 550,
                ),
                padding: EdgeInsets.zero,
                hasError: userManager.hasError,
                itemBuilder: (context, index) {
                  final user = response.data[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                            "${index + 1}: ${user.firstName} ${user.lastName}"),
                      ),
                    ),
                  );
                },
                errorWidget: () => Column(
                  children: [
                    Text(userManager.error.toString()),
                    IconButton(
                      onPressed: () {
                        userManager.clearError();
                        fetchData();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            }
            return SkadiPaginatedListView(
              itemCount: response.data.length,
              hasMoreData: paginationHandler.hasMoreData,
              dataLoader: fetchData,
              fetchOptions: const SkadiListViewFetchOptions(
                autoFetchOnShortList: true,
                recursiveAutoFetch: true,
                fetchOffset: 550,
              ),
              padding: EdgeInsets.zero,
              hasError: userManager.hasError,
              itemBuilder: (context, index) {
                final user = response.data[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  onTap: () {},
                  title:
                      Text("${index + 1}: ${user.firstName} ${user.lastName}"),
                  subtitle: Text(user.email!),
                );
              },
              errorWidget: () => Column(
                children: [
                  Text(userManager.error.toString()),
                  IconButton(
                    onPressed: () {
                      userManager.clearError();
                      fetchData();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class Pagination {
  Pagination({
    required this.page,
    required this.totalItems,
    required this.totalPage,
  });

  int page;
  int totalItems;
  int totalPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] ?? 0,
        totalItems: json["total_items"] ?? 0,
        totalPage: json["total_page"] ?? 0,
      );
}

///Extend this class from your response with pagination
class PaginationResponse<T> {
  final int totalRecord;
  List<T> data;
  PaginationResponse({required this.totalRecord, required this.data});
}

///Use this class with FutureManager to handle pagination automatically
class PaginationHandler<T extends PaginationResponse<M>, M extends Object> {
  //
  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  //
  int _page = 1;
  int get page => _page;

  final FutureManager<T> manager;
  PaginationHandler(this.manager);

  void reset() {
    _hasMoreData = true;
    _page = 1;
  }

  bool hasMoreDataCondition(T response, int lastResponseCount) {
    return response.data.length < response.totalRecord && lastResponseCount > 0;
  }

  T handle(T response) {
    var count = response.data.length;
    if (manager.hasData && page > 1) {
      response.data = [...manager.data!.data, ...response.data];
    }
    _hasMoreData = hasMoreDataCondition(response, count);
    _page += 1;
    debugPrint(
        "${manager.data.runtimeType} total length: ${response.data.length}");
    return response;
  }
}

class UserResponse extends PaginationResponse<UserModel> {
  final Pagination? pagination;

  UserResponse({this.pagination, required super.data})
      : super(
          totalRecord: pagination!.totalItems,
        );

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: json["data"] == null
            ? []
            : List<UserModel>.from(
                json["data"].map((x) => UserModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["profile_img"],
      );
}
