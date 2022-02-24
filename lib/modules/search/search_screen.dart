
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchControllar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state) {  },
      builder: ( context, state) {
        var list =NewsCubit.get(context).searchResualt;
        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defualtTextFormField(
                  controller: searchControllar,
                  type: TextInputType.text,
                  validate: (value){
                    if(value.isEmpty){
                      return'search must not bre empty';
                    }return null;
                  },
                  onChange: (value){
                    NewsCubit.get(context).getResualt(value);
                  },
                  label: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                  child: articlelBuilder(list,context,isSearch: true)
              ),
            ],
          ),
        );
      },

    );
  }
}
