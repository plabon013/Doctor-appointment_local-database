import 'package:doctor_appointment/providers/user_handler_provider.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const Text('Search'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline4?.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: 'Filter'),
              Consumer<UserHandlerProvider>(
                  builder: (context, userHandlerProvider, child) {
                print(userHandlerProvider.selectedFilter);

                return userHandlerProvider.selectedFilter != null
                    ? DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        value: userHandlerProvider.selectedFilter,
                        items: userHandlerProvider.searchFilter
                            .map(
                              (filter) => DropdownMenuItem(
                                onTap: () {},
                                value: filter,
                                child: CustomText(
                                  text: filter,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          userHandlerProvider.setFilter(value!);
                          print(value);
                        },
                      )
                    : CustomText(text: 'Unavailable');
              }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoSearchTextField(),
          ),
          SizedBox(
            // height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => CustomText(
                text: 'data',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
