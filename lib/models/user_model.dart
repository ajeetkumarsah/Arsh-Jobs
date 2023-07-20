import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  int? id;
  String? name;
  String? url;
  String? description;
  String? link;
  String? slug;

  Map<String, String>? avatarUrls;
  List<dynamic>? meta;
  bool? isSuperAdmin;
  WoocommerceMeta? woocommerceMeta;
  Cariera? cariera;
  Links? links;
  User({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
    this.meta,
    this.isSuperAdmin,
    this.woocommerceMeta,
    this.cariera,
    this.links,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: json["avatar_urls"] != null
            ? Map.from(json["avatar_urls"])
                .map((k, v) => MapEntry<String, String>(k, v))
            : null,
        meta: json["meta"] != null
            ? List<dynamic>.from(json["meta"].map((x) => x))
            : null,
        isSuperAdmin: json["is_super_admin"],
        woocommerceMeta: json["woocommerce_meta"] != null
            ? WoocommerceMeta.fromMap(json["woocommerce_meta"])
            : null,
        cariera:
            json["cariera"] != null ? Cariera.fromMap(json["cariera"]) : null,
        links: json["_links"] != null ? Links.fromMap(json["_links"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls": avatarUrls != null
            ? Map.from(avatarUrls!)
                .map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "is_super_admin": isSuperAdmin,
        "woocommerce_meta": woocommerceMeta!.toMap(),
        "cariera": cariera!.toMap(),
        "_links": links!.toMap(),
      };
}

class Cariera {
  Cariera(
      {this.jobsPublished,
      this.jobsPending,
      this.jobsExpired,
      this.resumesPublished,
      this.resumesPending,
      this.resumesExpired,
      this.monthlyViews,
      this.companiesPending,
      this.companiesPublished});

  String? jobsPublished;
  String? jobsPending;
  String? jobsExpired;
  String? resumesPublished;
  String? resumesPending;
  String? resumesExpired;
  int? monthlyViews;

  String? companiesPublished;
  String? companiesPending;
  factory Cariera.fromMap(Map<String, dynamic> json) => Cariera(
        jobsPublished: json["jobs_published"],
        jobsPending: json["jobs_pending"],
        jobsExpired: json["jobs_expired"],
        resumesPublished: json["resumes_published"],
        resumesPending: json["resumes_pending"],
        resumesExpired: json["resumes_expired"],
        monthlyViews: json["monthly_views"],
        companiesPublished: json['companies_published'],
        companiesPending: json['companies_pending'],
      );

  Map<String, dynamic> toMap() => {
        "jobs_published": jobsPublished,
        "jobs_pending": jobsPending,
        "jobs_expired": jobsExpired,
        "resumes_published": resumesPublished,
        "resumes_pending": resumesPending,
        "resumes_expired": resumesExpired,
        "monthly_views": monthlyViews,
        'companies_pending': companiesPending,
        'companies_published': companiesPublished
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromMap(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": List<dynamic>.from(self!.map((x) => x.toMap())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toMap())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
      };
}

class WoocommerceMeta {
  WoocommerceMeta({
    this.activityPanelInboxLastRead,
    this.activityPanelReviewsLastRead,
    this.categoriesReportColumns,
    this.couponsReportColumns,
    this.customersReportColumns,
    this.ordersReportColumns,
    this.productsReportColumns,
    this.revenueReportColumns,
    this.taxesReportColumns,
    this.variationsReportColumns,
    this.dashboardSections,
    this.dashboardChartType,
    this.dashboardChartInterval,
    this.dashboardLeaderboardRows,
    this.homepageLayout,
    this.homepageStats,
    this.taskListTrackedStartedTasks,
    this.helpPanelHighlightShown,
    this.androidAppBannerDismissed,
  });

  String? activityPanelInboxLastRead;
  String? activityPanelReviewsLastRead;
  String? categoriesReportColumns;
  String? couponsReportColumns;
  String? customersReportColumns;
  String? ordersReportColumns;
  String? productsReportColumns;
  String? revenueReportColumns;
  String? taxesReportColumns;
  String? variationsReportColumns;
  String? dashboardSections;
  String? dashboardChartType;
  String? dashboardChartInterval;
  String? dashboardLeaderboardRows;
  String? homepageLayout;
  String? homepageStats;
  String? taskListTrackedStartedTasks;
  String? helpPanelHighlightShown;
  String? androidAppBannerDismissed;

  factory WoocommerceMeta.fromMap(Map<String, dynamic> json) => WoocommerceMeta(
        activityPanelInboxLastRead: json["activity_panel_inbox_last_read"],
        activityPanelReviewsLastRead: json["activity_panel_reviews_last_read"],
        categoriesReportColumns: json["categories_report_columns"],
        couponsReportColumns: json["coupons_report_columns"],
        customersReportColumns: json["customers_report_columns"],
        ordersReportColumns: json["orders_report_columns"],
        productsReportColumns: json["products_report_columns"],
        revenueReportColumns: json["revenue_report_columns"],
        taxesReportColumns: json["taxes_report_columns"],
        variationsReportColumns: json["variations_report_columns"],
        dashboardSections: json["dashboard_sections"],
        dashboardChartType: json["dashboard_chart_type"],
        dashboardChartInterval: json["dashboard_chart_interval"],
        dashboardLeaderboardRows: json["dashboard_leaderboard_rows"],
        homepageLayout: json["homepage_layout"],
        homepageStats: json["homepage_stats"],
        taskListTrackedStartedTasks: json["task_list_tracked_started_tasks"],
        helpPanelHighlightShown: json["help_panel_highlight_shown"],
        androidAppBannerDismissed: json["android_app_banner_dismissed"],
      );

  Map<String, dynamic> toMap() => {
        "activity_panel_inbox_last_read": activityPanelInboxLastRead,
        "activity_panel_reviews_last_read": activityPanelReviewsLastRead,
        "categories_report_columns": categoriesReportColumns,
        "coupons_report_columns": couponsReportColumns,
        "customers_report_columns": customersReportColumns,
        "orders_report_columns": ordersReportColumns,
        "products_report_columns": productsReportColumns,
        "revenue_report_columns": revenueReportColumns,
        "taxes_report_columns": taxesReportColumns,
        "variations_report_columns": variationsReportColumns,
        "dashboard_sections": dashboardSections,
        "dashboard_chart_type": dashboardChartType,
        "dashboard_chart_interval": dashboardChartInterval,
        "dashboard_leaderboard_rows": dashboardLeaderboardRows,
        "homepage_layout": homepageLayout,
        "homepage_stats": homepageStats,
        "task_list_tracked_started_tasks": taskListTrackedStartedTasks,
        "help_panel_highlight_shown": helpPanelHighlightShown,
        "android_app_banner_dismissed": androidAppBannerDismissed,
      };
}
