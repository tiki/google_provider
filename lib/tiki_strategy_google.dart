import 'package:flutter/material.dart';
import 'package:httpp/httpp.dart';

import 'src/auth/auth_model.dart';
import 'src/auth/auth_service.dart';
import 'src/email/email_service.dart';
import 'tiki_strategy_google_model_email.dart';

export 'src/auth/auth_model.dart';
export 'src/info/info_model.dart';

class TikiStrategyGoogle {
  final AuthService _authService;
  late final EmailService _emailService;

  TikiStrategyGoogle(
      {Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh) {
    _emailService = EmailService(_authService);
  }

  TikiStrategyGoogle.loggedIn(
      {required String? token,
      String? email,
      String? displayName,
      String? refreshToken,
      Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            model: AuthModel(
              isLinked: true,
              email: email,
              token: token,
              displayName: displayName,
              refreshToken: refreshToken,
            ),
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh) {
    _emailService = EmailService(_authService);
  }

  Widget get authButton => _authService.presenter.authButton();

  String? get displayName => _authService.model.displayName;

  Future<void> update({Function(AuthModel)? onUpdate}) async =>
      await _authService.updateUserInfo(onSuccess: onUpdate);

  Future<void> sendEmail(
          {String? body,
          required String to,
          String? subject,
          Function(bool)? onResult}) =>
      _emailService.send(
          body: body, to: to, subject: subject, onResult: onResult);

  Future<void> fetchInbox(
          {DateTime? since,
          required Function(List<String> messagesIds) onResult,
          required Function() onFinish}) =>
      _emailService.fetchInbox(
          since: since, onResult: onResult, onFinish: onFinish);

  Future<void> fetchMessages(
          {required List<String> messageIds,
          required Function(TikiStrategyGoogleModelEmail message) onResult,
          required Function() onFinish}) =>
      _emailService.fetchMessages(
          messageIds: messageIds, onResult: onResult, onFinish: onFinish);
}
