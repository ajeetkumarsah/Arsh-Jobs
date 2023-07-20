import 'package:cariera/utils/colors.dart';
import 'package:flutter/material.dart';

class AppConstants {
  //Google API Key :)
  static const String googleApiKey = "AIzaSyCuQANPo-wvkwSVtzaZvqZrZTAnXE7b1Ak";
  //STRINGS
  static const String appName = 'Arsh Jobs';

  //URLS
  static const String baseURL = 'https://arshjobs.ae';

  static const String login = '$baseURL/wp-json/jwt-auth/v1/token';
  static const String register = '$baseURL/wp-json/wp/v2/users/register';
  static const String user = '$baseURL/wp-json/wp/v2/users/';
  static const String blogs = '$baseURL/wp-json/wp/v2/posts/?_embed=1';
  static const String jobCategories = '$baseURL/wp-json/wp/v2/job-categories';
  static const String resumeCategories =
      '$baseURL/wp-json/wp/v2/resume-categories';
  static const String companyCategories =
      '$baseURL/wp-json/wp/v2/company-categories';
  static const String updateUser = "$baseURL/wp-json/wp/v2/users/";

  static const String jobTypes = '$baseURL/wp-json/wp/v2/job-types';
  static const String jobs = '$baseURL/wp-json/wp/v2/job-listings?_embed=1';
  static const String searchBlogs = '$baseURL/wp-json/wp/v2/posts?search=';

  static const String searchJobs =
      '$baseURL/wp-json/wp/v2/job-listings?_embed=1&search=';
  static const String searchResumes =
      '$baseURL/wp-json/wp/v2/resumes?_embed=1&search=';
  static const String searchCompanies =
      '$baseURL/wp-json/wp/v2/companies?_embed=1&search=';

//WEBVIEW URLS

  static const String informationURL = 'https://gnodesign.com';
  static const String supportEmail = 'support@gnodesign.com';
  static const String privacyURL = 'https://gnodesign.com';

  //FEATURE LISTING
  static const String featuredJobs =
      '$baseURL/wp-json/wp/v2/job-listings?_embed=1&featured=1';
  static const String featuredCompanies =
      '$baseURL/wp-json/wp/v2/companies?_embed=1&featured=1';
  static const String featuredResumes =
      '$baseURL/wp-json/wp/v2/Resumes?_embed=1&featured=1';

//MY LISTING
  static const String myJobs =
      '$baseURL/wp-json/wp/v2/job-listings?_embed=1&author=';
  static const String myCompanies =
      '$baseURL/wp-json/wp/v2/companies?_embed=1&author=';
  static const String myResumes =
      '$baseURL/wp-json/wp/v2/resumes?_embed=1&author=';

//DELETE LISTING
  static const String deleteJobs = '$baseURL/wp-json/wp/v2/job-listings/';

  static const String deleteCompany = '$baseURL/wp-json/wp/v2/companies/';

  static const String deleteResume = '$baseURL/wp-json/wp/v2/resumes/';

  //UNFEATURE LISTING
  static const String unFeaturedJobs =
      '$baseURL/wp-json/wp/v2/job-listings?_embed=1&featured=0';
  static const String unFeaturedResumes =
      '$baseURL/wp-json/wp/v2/Resumes?_embed=1&featured=0';
  static const String unFeaturedCompanies =
      '$baseURL/wp-json/wp/v2/companies?_embed=1&featured=0';

//GENERIC LISTING
  static const String resumes = '$baseURL/wp-json/wp/v2/resumes?_embed=1';
  static const String companies = '$baseURL/wp-json/wp/v2/companies?_embed=1';

  static const String company = '$baseURL/wp-json/wp/v2/companies';

  //ASSETS
  static const String logo = 'assets/images/logo.png';
  static const String icon = 'assets/images/logo.png';
  static const String calendar = 'assets/images/calendar.png';
  static const String defaultImage = 'assets/images/default.jpg';
  static const String defaultCompanyImage = 'assets/images/company.png';
  static const String defaultResumeImage = 'assets/images/resume.png';
  static const String defaultJobImage = 'assets/images/company.png';

  //NO DATA
  static const String noSalary = '';

  //SYMBOLS
  static const String defaultCurrency = '\$';

  //SETTING
  static const bool isCurrencyLogoLeft =
      true; //if false then currency logo will show right side of amount

  //STRINGS
  static const String loadJobs = 'pull to load more jobs';
  static const String noJobs = 'no more jobs to load';
  static const String noListing =
      'You need to be logged in to view this listing!';
  static const String notLogin = 'You need to be logged in to view!';
  static const String loadPosts = 'pull to load more posts';
  static const String noPosts = 'no more jobs to post';
  static const String loading = 'please wait';
  static const String version = 'Version 1.1.0';
  static const String copyright = 'Copyright @ 2022 Gnodesign';

  //SHARED PREFERENCE
  static const String userID = 'user_id';
  static const String authToken = 'auth_token';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String email = 'email';
  static const String role = 'role';
  static const String displayName = 'display_name';
  static const String userImage = 'user_avatar';

  //MAP SETTING
  static const double zoom = 15.0;
  static const bool enableZoom = false;
}

//APPBAR STYLE
const TextStyle appBarStyle =
    TextStyle(color: dark, fontSize: 20, fontWeight: FontWeight.bold);

//PADING
const double pb13 = 13.0;
const double p10 = 10.0;
const double p15 = 15.0;
const double p5 = 5.0;

//DEFAULT ATTRIBUTES
const double defualtPadding = 20.0;
const double defualtRadius = 20.0;
const double appBarHeight = 160.0;
const double defaultAppBarHeight = 50.0;
const double defualtIcon = 20.0;
const double defaultJobDetailImage = 100.0;
const double defaultJobDetailIcon = 35.0;

//DEFAULT POSTS
const int blogsPerPage = 5;
const int jobsPerPage = 5;

const double pr = 18.0;

const double fs25 = 25.0;
const double fs18 = 18.0;
const double fs15 = 15.0;
const double fs13 = 13.0;
const double fs10 = 10.0;

const double fs20 = 20.0;
const double fs30 = 30.0;

const dp = 20.0;

const double ls10 = 10.0;

const double roundedBigButtonHeight = 50.0;

//STYLES
TextStyle grey12 = const TextStyle(color: Colors.grey, fontSize: 12);
TextStyle grey15 = const TextStyle(color: Colors.grey, fontSize: 15);

TextStyle s1 = const TextStyle(
    color: primary, fontSize: fs20, fontWeight: FontWeight.bold);
TextStyle s2 = const TextStyle(color: Colors.black, fontSize: fs15);
TextStyle s15boldark =
    const TextStyle(fontWeight: FontWeight.bold, color: dark, fontSize: fs15);

TextStyle sw = const TextStyle(color: onPrimary);
TextStyle bts = const TextStyle(fontSize: fs18);

TextStyle bts1 = const TextStyle(fontSize: fs13, color: primary);

TextStyle dark13 = const TextStyle(fontSize: fs13, color: dark);

TextStyle si = const TextStyle(color: Colors.blue, fontStyle: FontStyle.italic);

TextStyle onlyDark = const TextStyle(color: dark);
TextStyle s5 = const TextStyle(
    color: primary, fontWeight: FontWeight.bold, fontSize: fs10);
TextStyle s6 = const TextStyle(
    color: onPrimary, fontWeight: FontWeight.bold, fontSize: fs10);

TextStyle swb50 = const TextStyle(
    fontSize: 50, color: onPrimary, fontWeight: FontWeight.bold);

TextStyle swb20 =
    const TextStyle(fontSize: 20, color: dark, fontWeight: FontWeight.bold);

TextStyle swb25 =
    const TextStyle(fontSize: 25, color: dark, fontWeight: FontWeight.bold);
TextStyle swp25 =
    const TextStyle(fontSize: 25, color: primary, fontWeight: FontWeight.bold);

TextStyle sbb15 = const TextStyle(
    fontSize: 15,
    color: dark,
    fontWeight: FontWeight.bold); //Feature Jobs, Categories

TextStyle sww15 = const TextStyle(
    fontSize: 15, color: onPrimary, fontWeight: FontWeight.bold);

TextStyle swp15 =
    const TextStyle(fontSize: 15, color: primary, fontWeight: FontWeight.bold);

TextStyle sbw13 = const TextStyle(
    fontSize: 13,
    color: onPrimary,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.7); //Job Categories

TextStyle swb = const TextStyle(
    color: onPrimary, fontWeight: FontWeight.bold, letterSpacing: 1);

TextStyle sww20 = const TextStyle(
    fontSize: 20, color: onPrimary, fontWeight: FontWeight.bold);

TextStyle sdw20 =
    const TextStyle(fontSize: 20, color: dark, fontWeight: FontWeight.bold);
TextStyle swp20 =
    const TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.bold);

TextStyle wb5l11 = const TextStyle(
    color: Color(0xFFD6D6D6),
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5);

TextStyle gb5l11 = const TextStyle(
    color: Colors.grey,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5);

TextStyle pb5l11 = const TextStyle(
    color: primary,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5);

const TextStyle wb7l11 = TextStyle(
    color: onPrimary,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5);

const TextStyle wp7l11 = TextStyle(
    color: primary,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5);
