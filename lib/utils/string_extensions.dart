extension StringExtensions on String {
  String get svg => 'assets/svg/$this.svg';
  String get png => 'assets/png/$this.png';
  String get riv => 'assets/riv/$this.riv';
  String get json => 'assets/png/$this.json';

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
