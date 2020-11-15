import 'package:confnect/view/pages/HomePage.dart';
import 'package:confnect/view/pages/PostPage.dart';
import '../controller/Controller.dart';
import './pages/Register.dart';
import './pages/Login.dart';
import './pages/UserSection.dart';
import 'package:flutter/material.dart';

class PageFactory {
  Controller controller;
  PageFactory(this.controller);

  Widget createLoginPage() {
    return Login(controller);
  }

  Widget createRegisterPage() {
    return Register(controller);
  }

  Widget createHomePage() {
    return HomePage(controller);
  }

  Widget createUserPage() {
    return UserSection(controller);
  }

  Widget createPostPage() {
    return PostPage(controller);
  }
}
