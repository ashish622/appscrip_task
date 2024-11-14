

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../widgets/user_details_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Users List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) => UserBloc()..add(LoadUsers()),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<UserBloc>().add(LoadUsers());
                  },
                  child: ListView.builder(
                    itemCount: state.users.length,
                    physics: const BouncingScrollPhysics(
                      parent: ScrollPhysics()
                    ),
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                          child: UserDetailsCard(user: user),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is UserError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
