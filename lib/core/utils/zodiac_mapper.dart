class ZodiacMapper {
  static String getZodiacSign(DateTime birthday) {
    if ((birthday.month == 1 && birthday.day >= 20) || (birthday.month == 2 && birthday.day <= 18)) {
      return 'Aquarius';
    } else if ((birthday.month == 2 && birthday.day >= 19) || (birthday.month == 3 && birthday.day <= 20)) {
      return 'Pisces';
    } else if ((birthday.month == 3 && birthday.day >= 21) || (birthday.month == 4 && birthday.day <= 19)) {
      return 'Aries';
    } else if ((birthday.month == 4 && birthday.day >= 20) || (birthday.month == 5 && birthday.day <= 20)) {
      return 'Taurus';
    } else if ((birthday.month == 5 && birthday.day >= 21) || (birthday.month == 6 && birthday.day <= 20)) {
      return 'Gemini';
    } else if ((birthday.month == 6 && birthday.day >= 21) || (birthday.month == 7 && birthday.day <= 22)) {
      return 'Cancer';
    } else if ((birthday.month == 7 && birthday.day >= 23) || (birthday.month == 8 && birthday.day <= 22)) {
      return 'Leo';
    } else if ((birthday.month == 8 && birthday.day >= 23) || (birthday.month == 9 && birthday.day <= 22)) {
      return 'Virgo';
    } else if ((birthday.month == 9 && birthday.day >= 23) || (birthday.month == 10 && birthday.day <= 22)) {
      return 'Libra';
    } else if ((birthday.month == 10 && birthday.day >= 23) || (birthday.month == 11 && birthday.day <= 21)) {
      return 'Scorpio';
    } else if ((birthday.month == 11 && birthday.day >= 22) || (birthday.month == 12 && birthday.day <= 21)) {
      return 'Sagittarius';
    } else if ((birthday.month == 12 && birthday.day >= 22) || (birthday.month == 1 && birthday.day <= 19)) {
      return 'Capricorn';
    }
    return 'Unknown';
  }
}
