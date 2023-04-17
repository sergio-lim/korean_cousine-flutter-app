import 'package:flutter/material.dart';

BoxDecoration minimalistDecoration = BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade500,
          offset: const Offset(6, 6),
          blurRadius: 15,
          spreadRadius: 1),
      const BoxShadow(
          color: Colors.white,
          offset: Offset(-6, -6),
          blurRadius: 15,
          spreadRadius: 1)
    ]);
