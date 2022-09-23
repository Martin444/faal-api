import 'package:faal_new2/controllers/notifications_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/styles_context.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/button_primary.dart';
import '../../../widgets/text_input_field.dart';

class SenderNotify extends StatefulWidget {
  const SenderNotify({Key? key}) : super(key: key);

  @override
  State<SenderNotify> createState() => _SenderNotifyState();
}

class _SenderNotifyState extends State<SenderNotify> {
  var titleNotify = TextEditingController();
  var desciptionNotify = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsControllers>(
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: decorationMethod,
          child: Column(
            children: [
              Text(
                'Crea un anuncio',
                style: titleAppBar,
              ),
              TextInputField(
                labelText: 'Titulo',
                controller: titleNotify,
                inputType: TextInputType.name,
                visibleText: false,
                isPass: false,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputField(
                labelText: 'Descripción',
                controller: desciptionNotify,
                inputType: TextInputType.name,
                visibleText: false,
                isPass: false,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonPrimary(
                title: 'Enviar notificación',
                onPressed: () {
                  _
                      .sendnotificationusers(
                        titleNotify.text,
                        desciptionNotify.text,
                      )
                      .then((value) => {
                            titleNotify.clear(),
                            desciptionNotify.clear(),
                          });
                },
                load: _.isSending,
                disabled: _.isSending,
              )
            ],
          ),
        );
      },
    );
  }
}
