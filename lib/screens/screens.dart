import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:psico_educativa_app/custom_widgets/custom_widgets.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';
import 'package:psico_educativa_app/provider/notification_provider.dart';
import 'package:psico_educativa_app/router/app_router.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/router_utils.dart';

part 'splash_screen_page.dart';
part 'auth/signin_screen.dart';
part 'auth/register_screen.dart';
part 'auth/home_page_screen.dart';
part 'auth/check_out_status_screen.dart';
part 'courses/new_course_promo.dart';

part 'notifications/handle_notification_interaction.dart';
