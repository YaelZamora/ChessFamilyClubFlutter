import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:chess_family_club/helpers/ejercicios.dart';

import 'package:http/http.dart' as http;

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final controller = ChessBoardController();
  final List<String> pgn = pgnLista;

  @override
  Widget build(BuildContext context) {
    http.get(Uri.parse('https://lichess.org/api/puzzle/daily'));

    var randomPgn = Random().nextInt(pgn.length);

    controller.loadPGN(
      pgn[randomPgn],
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ejercicio',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.darkBrown,
              ),
            ),
            const Text(
              'Calendario',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 400,
              height: 400,
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                headerVisible: false,
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
