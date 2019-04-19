$(document).ready(function() {
  console.log('app run');
  $('.menu-btn').on('click', function() {
    console.log('You clicked on me');
    $('.sidebar-container').toggleClass('active');

  });
});
