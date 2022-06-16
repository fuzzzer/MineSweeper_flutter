import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 245, 245, 245),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 15),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: """
you can select cell either by tapping on the
desired cell or sliding on the screen.

once you select the desired cell,
 you can tap twice on the screen to open that cell.
""",
                style: GoogleFonts.mPlusCodeLatin(
                    color: const Color.fromARGB(203, 49, 48, 48),
                    fontSize: 20,
                    fontWeight: FontWeight.w400))
          ]),
        ),
      ),
    );
  }
}
