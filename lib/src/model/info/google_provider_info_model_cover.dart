/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'google_provider_info_model_cover_header.dart';

class GoogleProviderInfoModelCover{
  final String? image;
  final String? subtitle;
  final String? bigTextLight;
  final String? bigTextDark;
  final String? text;
  final GoogleProviderInfoModelCoverHeader? header;

  const GoogleProviderInfoModelCover(
      {this.image,
      this.subtitle,
      this.bigTextLight,
      this.bigTextDark,
      this.text,
      this.header});

}