import 'package:flutter/material.dart';

class ColorPrimitives {
  // Brand/Main Colors
  static const Color green10 = Color(0xFF001F07);
  static const Color green20 = Color(0xFF004216);
  static const Color green30 = Color(0xFF006E2A);
  static const Color green40 = Color(0xFF009B3E);
  static const Color green50 = Color(0xFF32BB58);
  static const Color green60 = Color(0xFF4DCC6A);
  static const Color green70 = Color(0xFF61DE7B);
  static const Color green80 = Color(0xFF74F08D);
  static const Color green90 = Color(0xFF98FFA9);
  static const Color green100 = Color(0xFFE0FFE3);

  // Grayscale colors
  static const Color black = Color(0x00000000);
  static const Color grey10 = Color(0xFF0F0F12);
  static const Color grey20 = Color(0xFF1F1F21);
  static const Color grey30 = Color(0xFF46464A);
  static const Color grey40 = Color(0xFF75757E);
  static const Color grey50 = Color(0xFF9B9BA7);
  static const Color grey60 = Color(0xFFC6C6CE);
  static const Color grey70 = Color(0xFFD4D4D8);
  static const Color grey80 = Color(0xFFE0E0E2);
  static const Color grey90 = Color(0xFFEDEDED);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFffffff);

  // Transparent colors
  static const Color trspBlack00 = Color.fromARGB(0, 0, 0, 0);
  static const Color trspBlack05 = Color(0x0D000000);
  static const Color trspBlack10 = Color(0x1A000000);
  static const Color trspBlack20 = Color(0x33000000);
  static const Color trspBlack30 = Color(0x4D000000);
  static const Color trspBlack40 = Color(0x66000000);
  static const Color trspBlack50 = Color(0x80000000);
  static const Color trspBlack60 = Color(0x99000000);
  static const Color trspBlack67 = Color(0xAB000000);
  static const Color trspBlack80 = Color(0xCC000000);
  static const Color trspBlack90 = Color(0xE6000000);
  static const Color trspBlack95 = Color(0xF2000000);

  static const Color trspWhite00 = Color.fromARGB(0, 255, 255, 255);
  static const Color trspWhite07 = Color(0x12FFFFFF);
  static const Color trspWhite10 = Color(0x1AFFFFFF);
  static const Color trspWhite20 = Color(0x33FFFFFF);
  static const Color trspWhite30 = Color(0x4DFFFFFF);
  static const Color trspWhite40 = Color(0x66FFFFFF);
  static const Color trspWhite50 = Color(0x80FFFFFF);
  static const Color trspWhite58 = Color(0x94FFFFFF);
  static const Color trspWhite65 = Color(0xA6FFFFFF);
  static const Color trspWhite75 = Color(0xBFFFFFFF);
  static const Color trspWhite82 = Color(0xD1FFFFFF);
  static const Color trspWhite95 = Color(0xF2FFFFFF);

  // Transparent colored variants
  static const Color trspGreen10 = Color(0x1A32BB58);
  static const Color trspGreen20 = Color(0x3332BB58);
  static const Color trspGreen30 = Color(0x4D32BB58);
  static const Color trspGreen40 = Color(0x6632BB58);

  static const Color trspRed10 = Color(0x1AFC6660);
  static const Color trspRed20 = Color(0x33FC6660);
  static const Color trspRed30 = Color(0x4DFC6660);
  static const Color trspRed40 = Color(0x66FC6660);

  static const Color trspAmber10 = Color(0x1AE1831E);
  static const Color trspAmber20 = Color(0x33E1831E);
  static const Color trspAmber30 = Color(0x4DE1831E);
  static const Color trspAmber40 = Color(0x66E1831E);

  static const Color trspBlue10 = Color(0x1A16ABE6);
  static const Color trspBlue20 = Color(0x3316ABE6);
  static const Color trspBlue30 = Color(0x4D16ABE6);
  static const Color trspBlue40 = Color(0x6616ABE6);

  static const Color trspPurple10 = Color(0x1AA489F3);
  static const Color trspPurple20 = Color(0x33A489F3);
  static const Color trspPurple30 = Color(0x4DA489F3);
  static const Color trspPurple40 = Color(0x66A489F3);

  static const Color trspPink10 = Color(0x1AE8709A);
  static const Color trspPink20 = Color(0x33E8709A);
  static const Color trspPink30 = Color(0x4DE8709A);
  static const Color trspPink40 = Color(0x66E8709A);

  static const Color trspTeal10 = Color(0x1A00BC97);
  static const Color trspTeal20 = Color(0x3300BC97);
  static const Color trspTeal30 = Color(0x4D00BC97);
  static const Color trspTeal40 = Color(0x6600BC97);

  static const Color trspLime10 = Color(0x1A8EAD04);
  static const Color trspLime20 = Color(0x338EAD04);
  static const Color trspLime30 = Color(0x4D8EAD04);
  static const Color trspLime40 = Color(0x668EAD04);

  // Error colors (updated from JSON)
  static const Color red10 = Color(0xFF360003);
  static const Color red20 = Color(0xFF6B000B);
  static const Color red30 = Color(0xFFAC0019);
  static const Color red40 = Color(0xFFE33438);
  static const Color red50 = Color(0xFFFC6660);
  static const Color red60 = Color(0xFFFF867E);
  static const Color red70 = Color(0xFFFFA49C);
  static const Color red80 = Color(0xFFFFBFB9);
  static const Color red90 = Color(0xFFFFD9D5);
  static const Color red100 = Color(0xFFFFF2F0);

  // Warning colors (updated from JSON)
  static const Color amber10 = Color(0xFF281200);
  static const Color amber20 = Color(0xFF522A00);
  static const Color amber30 = Color(0xFF864900);
  static const Color amber40 = Color(0xFFBB6800);
  static const Color amber50 = Color(0xFFE1831E);
  static const Color amber60 = Color(0xFFF2953C);
  static const Color amber70 = Color(0xFFFFAA5F);
  static const Color amber80 = Color(0xFFFFC393);
  static const Color amber90 = Color(0xFFFFDCBF);
  static const Color amber100 = Color(0xFFFFF3E9);

  // Teal colors
  static const Color teal10 = Color(0xFF001E17);
  static const Color teal20 = Color(0xFF004034);
  static const Color teal30 = Color(0xFF006A57);
  static const Color teal40 = Color(0xFF00967C);
  static const Color teal50 = Color(0xFF00BC97);
  static const Color teal60 = Color(0xFF00CBA8);
  static const Color teal70 = Color(0xFF17DFB9);
  static const Color teal80 = Color(0xFF3EF1CB);
  static const Color teal90 = Color(0xFF7AFFDD);
  static const Color teal100 = Color(0xFFD9FFF3);

  // Purple colors
  static const Color purple10 = Color(0xFF1E0047);
  static const Color purple20 = Color(0xFF410088);
  static const Color purple30 = Color(0xFF6632BF);
  static const Color purple40 = Color(0xFF8865DF);
  static const Color purple50 = Color(0xFFA489F3);
  static const Color purple60 = Color(0xFFB49CFF);
  static const Color purple70 = Color(0xFFC3B3FF);
  static const Color purple80 = Color(0xFFD3C9FF);
  static const Color purple90 = Color(0xFFE4DEFF);
  static const Color purple100 = Color(0xFFF5F3FF);

  // Blue colors
  static const Color blue10 = Color(0xFF001B2B);
  static const Color blue20 = Color(0xFF003A57);
  static const Color blue30 = Color(0xFF00618E);
  static const Color blue40 = Color(0xFF008AC6);
  static const Color blue50 = Color(0xFF06A9F1);
  static const Color blue60 = Color(0xFF3FBAFF);
  static const Color blue70 = Color(0xFF77CAFF);
  static const Color blue80 = Color(0xFFA1D9FF);
  static const Color blue90 = Color(0xFFC7E8FF);
  static const Color blue100 = Color(0xFFECF7FF);

  // Pink colors
  static const Color pink10 = Color(0xFF340017);
  static const Color pink20 = Color(0xFF670033);
  static const Color pink30 = Color(0xFFA60056);
  static const Color pink40 = Color(0xFFD0467C);
  static const Color pink50 = Color(0xFFE8709A);
  static const Color pink60 = Color(0xFFFA83AB);
  static const Color pink70 = Color(0xFFFF9FBD);
  static const Color pink80 = Color(0xFFFFBCCF);
  static const Color pink90 = Color(0xFFFFD7E2);
  static const Color pink100 = Color(0xFFFFF1F5);

  // Lime colors
  static const Color lime10 = Color(0xFF151C00);
  static const Color lime20 = Color(0xFF2F3C00);
  static const Color lime30 = Color(0xFF516400);
  static const Color lime40 = Color(0xFF738D00);
  static const Color lime50 = Color(0xFF8EAD04);
  static const Color lime60 = Color(0xFF9EBE31);
  static const Color lime70 = Color(0xFFAFD047);
  static const Color lime80 = Color(0xFFC0E25B);
  static const Color lime90 = Color(0xFFD2F46E);
  static const Color lime100 = Color(0xFFEBFFBE);
}
