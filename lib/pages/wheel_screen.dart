import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/wheel_cubit/wheel_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/create_wheel_screen.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlertDialog _deleteConfirmationDialog(int index) {
      return AlertDialog(
        backgroundColor: Color(0xFF8D1527),
        title: Text(
          'Remove This Wheel from the Show?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Once it`s gone, there’s no encore. Are you sure you want to delete this fabulous creation from your collection?',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Keep It',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<WheelCubit>().deleteWheel(index);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Color(0xFFF1B016), fontSize: 18.0),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              color: Colors.white.withOpacity(0.5),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "The Decision Wheel",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "When you just can’t choose, let the magic wheel help!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateWheelScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF1B016),
                      Color(0xFFFFE898),
                      Color(0xFFDE7519),
                      Color(0xFFDE7519),
                      Color(0xFFDE7519),
                    ],
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Wheel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Previous Decisions",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: BlocBuilder<WheelCubit, List<DecisionWheel>>(
                builder: (context, wheels) {
                  if (wheels.isEmpty) {
                    return const Center(
                      child: Text(
                        'No wheels yet...',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: wheels.length,
                    itemBuilder: (context, index) {
                      final wheel = wheels[index];

                      return Container(
                        height: 85,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF761520),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFF1B016),
                            width: 3,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                wheel.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog<bool>(
                                  context: context,
                                  builder:
                                      (_) => _deleteConfirmationDialog(index),
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFF1B016),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
