import 'package:flutter/material.dart';
import 'package:grad_app/components/custom_field.dart';
import 'package:grad_app/components/default_button.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:grad_app/resources/app_images.dart';
import 'package:grad_app/views/home_layout.dart';
import 'package:grad_app/views/login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String route = 'register_screen';

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              //repeat: ImageRepeat.repeat,
              image: const AssetImage(AppImages.formBackground),
              colorFilter: ColorFilter.mode(
                Colors.indigo.withOpacity(.9),
                BlendMode.modulate,
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Welcome !',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              spreadRadius: 10,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Sign up to use our services.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.white60,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(30),
                        topRight: Radius.circular(45),
                      )),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Register !',
                              style: TextStyle(
                                fontSize: 27,
                                fontFamily: 'Poppins',
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            CustomField(
                              labelText: 'Name',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              inputType: TextInputType.text,
                              obscure: false,
                              controller: nameController,
                              prefixIcon: Icons.person_outlined,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            CustomField(
                              labelText: 'Email',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                              inputType: TextInputType.emailAddress,
                              obscure: false,
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            CustomField(
                              labelText: 'Age',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Age is required';
                                }
                                return null;
                              },
                              inputType: TextInputType.number,
                              obscure: false,
                              controller: ageController,
                              prefixIcon: Icons.date_range,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            IntlPhoneField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Phone Number'),
                              controller: phoneController,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            CustomField(
                              labelText: 'Password',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                              inputType: TextInputType.text,
                              obscure: true,
                              controller: passwordController,
                              prefixIcon: Icons.lock,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            CustomField(
                              labelText: 'Confirm Password',
                              validator: (value) {
                                if (confirmController.text !=
                                    passwordController.text) {
                                  return 'Password isn\'t match';
                                }
                                return null;
                              },
                              inputType: TextInputType.text,
                              obscure: true,
                              controller: confirmController,
                              prefixIcon: Icons.lock,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            DefaultButton(
                              text: 'Register',
                              iconData: Icons.login,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeLayout();
                                  }));
                                }
                              },
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 18),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
