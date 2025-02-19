import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_project/controllers/add_post_controller.dart';
import 'package:search_project/views/screens/add_post/add_post_screen_one.dart';

import 'controllers/community_controller.dart';
import 'controllers/community_model_controller.dart';
import 'controllers/create_community_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/internet_controller.dart';
import 'controllers/sign_in_controller.dart';

import 'models/user_model.dart';
import 'views/screens/Home/home_page.dart';
import 'views/screens/Popular/popular_page.dart';
import 'views/screens/add_post/add_post_screen_three.dart';
import 'views/screens/add_post/add_post_screen_two.dart';
import 'views/screens/authentication/email_signup_w.dart';
import 'views/screens/create_community/create_community_screen.dart';

import 'views/screens/search/search_screen_one.dart';
import 'views/screens/search/search_screen_two.dart';
import 'controllers/search_controller.dart' as searchCtrl;

import 'models/post_model.dart';
import 'controllers/profile_controller.dart';
import 'controllers/profile_model_controller.dart';
import 'views/screens/authentication/about_you.dart';
import 'views/screens/authentication/choose_profilepicture.dart';
import 'views/screens/authentication/choose_username.dart';
import 'views/screens/authentication/email_login.dart';
import 'views/screens/authentication/email_signup.dart';

import 'views/screens/authentication/email_signup_w_2.dart';
import 'views/screens/authentication/forget_password.dart';
import 'views/screens/authentication/forget_username.dart';
import 'views/screens/authentication/interests.dart';
import 'views/screens/authentication/sign_up_page.dart';
import 'views/screens/authentication/splash_screen.dart';
import 'controllers/mobile_settings_view_controller.dart';
import 'views/screens/settings/account_setting_screen.dart';
import 'views/screens/settings/setting_menu.dart';
import './views/screens/settings/change_password_screen.dart';
import './views/screens/settings/manage_emails.dart';
import './views/screens/settings/update_email_screen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'views/screens/temphome.dart';

void main() async {
  // initial the application

  WidgetsFlutterBinding.ensureInitialized();
  (kIsWeb) ? null : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                ProfileProvider(profileService: ProfileService())),
        ChangeNotifierProvider(
            create: ((context) => ProfileModelProvider()
              ..getProfileAbout("t2_hamada")
              ..getProfileComments("t2_hamada")
              ..getProfilePosts("t2_hamada")
              ..getUserSavedPosts()
              ..getUserUpVotedPosts('t2_hamada'))),
        ChangeNotifierProvider(create: ((context) => SignInController())),
        ChangeNotifierProvider(create: ((context) => AddPostController())),
        ChangeNotifierProvider(create: ((context) => InternetController())),
        ChangeNotifierProvider(
            create: (context) => CommunityModelProvider()
              ..getCommunityPosts("t5_imagePro235", "hot", [], 2, 40)
              ..getCommunityAbout("t5_imagePro235")
              ..getCommunityInfo("t5_imagePro235")
              ..getCommunityFlairs("t5_imagePro235")),
        ChangeNotifierProvider(
            create: (context) =>
                CommunityProvider(communityService: CommunityService())),
        ChangeNotifierProvider(
          create: (context) => searchCtrl.SearchController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsViewModelMobileController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateCommunityViewModelController(),
        ),
        ChangeNotifierProvider(create: (context) => HomeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reddit',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white, //<-- SEE HERE
          ),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: (kIsWeb)
              ? ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: Colors.deepOrange)
              : ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
                  .copyWith(secondary: Colors.lightBlue),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
        ),
        initialRoute: '/',
        home:
            // CommunityHome(commName: 't5_imagePro45',userName: currentUser!.username!,posts: communityPostsList,),
            //     ProfilePage(
            //   userID: 't2_hamada',
            //   context: context,
            // ),
            (kIsWeb) ? const EmailSignupW() : const SplashScreen(),
        routes: {
          Home.routeName: (ctx) => HomePage(
                userName: currentUser!.username!,
              ),
          Popular.routeName: (ctx) => const Popular(),
          //HomePage.routeName: (ctx) => const HomePage(),
          SignUpPage.routeName: (ctx) => const SignUpPage(),
          EmailLogin.routeName: (ctx) => const EmailLogin(),
          EmailSignup.routeName: (ctx) => const EmailSignup(),
          EmailSignupW2.routeName: (ctx) => const EmailSignupW2(),
          ForgetPassword.routeName: (ctx) => const ForgetPassword(),
          ForgetUserName.routeName: (ctx) => const ForgetUserName(),
          ChooseUserName.routeName: (ctx) => const ChooseUserName(),
          Interests.routeName: (ctx) => const Interests(),
          ChooseProfilePicture.routeName: (ctx) => const ChooseProfilePicture(),
          AboutYou.routeName: (ctx) => const AboutYou(),
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          // CommunityHome.routeName: (ctx) => const CommunityHome(),
          SearchScreenTwo.routeName: (ctx) => const SearchScreenTwo(),
          SearchScreenOne.routeName: (ctx) => const SearchScreenOne(),
          SettingsHomePage.routeName: (context) => const SettingsHomePage(),
          AccountSettingsScreen.routeName: (context) =>
              const AccountSettingsScreen(),
          ManageEmailsScreen.routeName: (context) => const ManageEmailsScreen(),
          UpdateEmailAddress.routeName: (context) => UpdateEmailAddress(),
          ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
          CreateCommunityScreen.routeName: (context) => CreateCommunityScreen(),
          AddPostScreenOne.routeName: (context) => const AddPostScreenOne(),
          AddPostScreenTwo.routeName: (context) => const AddPostScreenTwo(),
          AddPostScreenThree.routeName: (context) => const AddPostScreenThree(),
          //ProfilePage.routeName: (context) => const ProfilePage(),
          // AddComment.routeName: (context) => AddComment(),
        },
      ),
    );
  }
}
