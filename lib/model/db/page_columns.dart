enum PageColumns {
  id('id'),
  title('title'),
  content('content'),
  date('date'),
  image('image'),
  imageName('image_name'),
  ;

  final String column;

  const PageColumns(this.column);
}
