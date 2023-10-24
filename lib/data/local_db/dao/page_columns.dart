enum PageColumns {
  id('id'),
  title('title'),
  content('content'),
  date('date'),
  imagePath('image_path'),
  ;

  final String column;

  const PageColumns(this.column);
}
