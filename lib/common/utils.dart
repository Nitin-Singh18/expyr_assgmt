import 'package:flutter/material.dart';

SizedBox hGap(double width) => SizedBox(width: width);

Widget progressIndicator() => const Center(child: CircularProgressIndicator());

Widget messageWidget(String description) => Center(child: Text(description));
