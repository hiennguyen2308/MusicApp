String stripVN(String str) {
  String input = str.toLowerCase().replaceAll(" ", "");
  List<List<String>> withDia = [
    ['à', 'á', 'ạ', 'ả', 'ã', 'â', 'ầ', 'ấ', 'ậ', 'ẩ', 'ẫ', 'ă', 'ằ', 'ắ', 'ặ', 'ẳ', 'ẵ'],
    ['è', 'é', 'ẹ', 'ẻ', 'ẽ', 'ê', 'ề', 'ế', 'ệ', 'ể', 'ễ'],
    ['ì', 'í', 'ị', 'ỉ', 'ĩ'],
    ['ò', 'ó', 'ọ', 'ỏ', 'õ', 'ô', 'ồ', 'ố', 'ộ', 'ổ', 'ỗ', 'ơ', 'ờ', 'ớ', 'ợ', 'ở', 'ỡ'],
    ['ù', 'ú', 'ụ', 'ủ', 'ũ', 'ư', 'ừ', 'ứ', 'ự', 'ử', 'ữ'],
    ['ỳ', 'ý', 'ỵ', 'ỷ', 'ỹ'],
    ['đ']
  ];
  List<String> withoutDia = ['a', 'e', 'i', 'o', 'u', 'y', 'd'];
  for (int i = 0; i < withDia.length; i++) {
    for (int j = 0; j < withDia[i].length; j++) {
      input = input.replaceAll(withDia[i][j], withoutDia[i]);
    }
  }
  return input;
}