import 'package:faal/controllers/search_controller.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/text_input_search.dart';
import 'section/search_section.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset('assets/back.svg'),
                        ),
                      ),
                      Flexible(
                        child: TextInputSearch(
                            labelText: 'Buscar articulo',
                            controller: _searchController,
                            inputType: TextInputType.emailAddress,
                            visibleText: false,
                            isPass: false,
                            autoFocus: true,
                            functionSubmited: (value) {
                              _.search(value);
                            }),
                      ),
                    ],
                  ),
                  _.searching!
                      ? const SearchSection()
                      : Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              Text(
                                'Mirá todo lo que tenemos para ofrecerte',
                                textAlign: TextAlign.center,
                                style: titleSecundary,
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
