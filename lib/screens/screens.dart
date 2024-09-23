import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psico_educativa_app/constants/app_info.dart';

import 'package:psico_educativa_app/custom_widgets/custom_widgets.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';
import 'package:psico_educativa_app/provider/courses_provider.dart';
import 'package:psico_educativa_app/provider/map_provider.dart';
import 'package:psico_educativa_app/provider/menu_provider.dart';
import 'package:psico_educativa_app/provider/notification_provider.dart';
import 'package:psico_educativa_app/provider/socket/socket_provider.dart';
import 'package:psico_educativa_app/router/app_router.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/permission_util.dart';
import 'package:psico_educativa_app/shared/router_utils.dart';
import 'package:psico_educativa_app/shared/text_utils.dart';
import 'package:psico_educativa_app/shared/utils.dart';
import 'package:psico_educativa_app/shared/validations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

part 'splash_screen_page.dart';
part 'auth/signin_screen.dart';
part 'auth/register_screen.dart';
part 'auth/verification_code_screen.dart';
part 'auth/forgot_password_screen.dart';
part 'auth/home_page_screen.dart';

part 'maps/map_find_location_screen.dart';


part 'user/user_profile_screen.dart';
part 'user/user_update_profile_info_screen.dart';
part 'user/notifications_screen.dart';

part 'auth/check_out_status_screen.dart';
part 'courses/course_enrollment_screen.dart';
part 'courses/course_stuff.dart';

part 'notifications/handle_notification_interaction.dart';
