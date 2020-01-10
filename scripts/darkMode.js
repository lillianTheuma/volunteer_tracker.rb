function dark() { // This is a basic dark mode-light mode toggle and can/will be used on all attached pages. Simply point a button to it through onClick and watch it do its work. Add any elements that are not affected as needed.
  console.log("success");
  $('.container').toggleClass("bg-dark");
  $('.navbar').toggleClass("navbar-light bg-light bg-secondary");
  $('.card.jumbotron').toggleClass('');
  $('#header').toggleClass("bg-secondary");
  $('.card-header').toggleClass('bg-info');
  $('.card-body').toggleClass('bg-secondary');
  $('.card').toggleClass('bg-secondary');
  $('.card-footer').toggleClass('bg-info');
  $('.input').toggleClass('bg-info');
  $('body').toggleClass('bg-dark text-light');
  $('button').toggleClass('bg-info');
  $('a').toggleClass('text-light');
  $('.list-group-item').toggleClass('bg-secondary');
  $('.dropdown-menu').toggleClass('bg-dark');
}
