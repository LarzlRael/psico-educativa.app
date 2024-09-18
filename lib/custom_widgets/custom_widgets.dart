import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:psico_educativa_app/config/environment.dart';
import 'package:psico_educativa_app/constants/app_info.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/provider/map_provider.dart';
import 'package:psico_educativa_app/provider/menu_provider.dart';
import 'package:psico_educativa_app/screens/screens.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/text_utils.dart';
import 'package:psico_educativa_app/shared/validations.dart';

part 'text/simple_text.dart';
part 'text/app_bar_with_back_icon.dart';


part 'buttons/login_button.dart';
part 'buttons/button_icon.dart';


part 'forms/chip_choice.dart';
part 'forms/custom_dropdown.dart';
part 'forms/custom_formbuilder_fetch_dropdown.dart';
part 'forms/custom_formbuilder_text_field.dart';
part 'forms/input_container.dart';
part 'forms/custom_date_picker.dart';
part 'forms/custom_file_field.dart';
part 'forms/custom_formbuilder_text_area.dart';
part 'forms/custom_row_formbuilder_text_field.dart';
part 'forms/input_styles.dart';
part 'forms/global_form.dart';
part 'forms/custom_switch.dart';


part 'avatar/custom_circle_avatar.dart';

part 'cards/one_course_card.dart';

part 'delegates/search_location_delegate.dart';

part 'profile/profile_image_editable.dart';

part 'background/background_circle.dart';
part 'background/scaffold_with_background.dart';

part 'text/header_login_register.dart';
part 'tables/custom_data_row.dart';


part 'dialogs/loading_dialog.dart';
part 'dialogs/confirmation_dialog.dart';
