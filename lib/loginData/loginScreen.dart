import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/loginData/login.dart';
import 'package:mansourarestaurants/restaurant/RestaurantHomeScreen.dart';
import 'package:mansourarestaurants/widget/logo.dart';
import '../general.dart';
import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Login login = Login();

  bool errorUser = false;
  bool errorPassword = false;

  String errorU = '';
  String errorP = '';

  var height;
  var width;

  bool obscureTextValue = true;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: accentColor,
      appBar: AppBar(
        backgroundColor: accentColor,
        title: Text(
          appLocalizations.translate("sign in"), //  'تسجيل الدخول',
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            alignment: Alignment.center,
            width: width,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Text(
                      appLocalizations.translate("you have an account ?"),
                      //  "لديك حساب ؟",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        errorText: errorUser ? errorU : null,
                        prefixIcon: Icon(Icons.email),
                        labelText: appLocalizations
                            .translate("Enter your email or phone number"),
                        //'ادخل البريد الاكتروني او رقم الهاتف',
                        labelStyle: TextStyle(
                          fontFamily: "GE_Dinar_One_Light",
                        )),
                    style: TextStyle(
                      fontFamily: "",
                    ),
                    onChanged: (input) {
                      login.restaurantName = input;
                    },
                    onSubmitted: (input) {
                      setState(() {
                        errorUser = false;
                        errorPassword = false;
                      });
                      FocusScope.of(context).requestFocus(focusNode);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: TextStyle(
                      fontFamily: "",
                    ),
                    focusNode: focusNode,
                    obscureText: obscureTextValue,
                    decoration: InputDecoration(
                      errorText: errorPassword ? errorP : null,
                      prefixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureTextValue = !obscureTextValue;
                          });
                        },
                        child: obscureTextValue
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      labelText: appLocalizations.translate("password"),
                      // 'كلمة المرور',
                      labelStyle: TextStyle(
                        fontFamily: "GE_Dinar_One_Light",
                      ),
                    ),
                    onChanged: (input) {
                      login.password = input;
                    },
                    onSubmitted: (input) {
                      setLogin();
                    },
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  InkWell(
                    onTap: setLogin,
                    child: Container(
                      width: width / 1.3,
                      height: height / 100 * 5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: textColor,
                      ),
                      child: Text(
                        appLocalizations.translate("sign in"),
                        //  'تسجيل الدخول',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  /*   Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Text(
                                  appLocalizations
                                      .translate("Forgot your password ?"),
                                  // 'نسيت كلمة المرور ؟',
                                  style: TextStyle(
                                    fontFamily: "GE_Dinar_One_Light",
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setLogin() async {
    if (connected) {
      setState(() {
        errorUser = false;
        errorPassword = false;
      });
      if (login.restaurantName.isNotEmpty &&
          login.password.isNotEmpty &&
          login.password.length > 4) {
        progress(context: context, isLoading: true);
        bool _isLogin = await login.setLogin();
         progress(context: context, isLoading: false);
        if (_isLogin) {
          print("BoooooooooooooM");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RestaurantHomeScreen()));
        } else {
          switch (login.error) {
            case 'emailORPhoneNumber':
              errorUser = true;
              errorU = AppLocalizations.of(context).translate(
                  "This account is not already registered"); //'هذا الحساب غير مسجل من قبل';
              break;
            case 'password':
              errorPassword = true;
              errorP = AppLocalizations.of(context).translate(
                  "The password is incorrect"); //'كلمة المرور غير صحيحة';
              break;

          }
          setState(() {});
        }
      } else {
        if (login.restaurantName.isEmpty) {
          errorUser = true;
          errorU = AppLocalizations.of(context).translate(
              "Email or phone number is required"); //'اليريد الاكتروني او رقم الهاتف مطلوب';
        }
        /*else if (!login.userName.contains("@")) {
        errorUser = true;
        errorU = 'Make Sure This Email Is Correct';
      }*/
        if (login.password.isEmpty) {
          errorPassword = true;
          errorP = AppLocalizations.of(context)
              .translate("Password is required"); //'كلمة المرور مطلوبة';
        } else if (login.password.length <= 4) {
          errorPassword = true;
          errorP = AppLocalizations.of(context).translate(
              "The password is incorrect"); //'كلمة المرور غير صحيحة';
        }

        setState(() {});
      }
    } else {
      notConnected(context: context);
    }
  }
}
