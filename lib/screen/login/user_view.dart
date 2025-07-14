import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/screen/login/bloc/login_bloc.dart';
import 'package:flutter_application_2/screen/login/bloc/login_event.dart';
import 'package:flutter_application_2/screen/login/bloc/login_state.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc()..add(const GetUsersEvent()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetUsersSuccessState) {
            final users = state.users;
            if (users.isEmpty) {
              return const Center(child: Text('No users found'));
            }
            return ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(user.username[0].toUpperCase())),
                  title: Text(user.fullName),
                  subtitle: Text(user.email ?? ''),
                  trailing: Text(user.role),
                );
              },
            );
          }
          if (state is PostLoginFailedState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
