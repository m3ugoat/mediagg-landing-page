/* Folds the documentation sidebar away on narrow screens.
   The markup ships with the <details> open, because a closed one hides its own content and a
   reader without JavaScript would get no sidebar at all on a wide screen. So this only ever takes
   something away, and only where there is no room for it. */
(function () {
  var fold = document.querySelector('.sbfold');
  if (!fold || !window.matchMedia) return;
  var narrow = window.matchMedia('(max-width: 860px)');
  var touched = false;

  fold.addEventListener('toggle', function () { touched = true; });

  function apply() {
    // Once the reader has opened or closed it themselves, their choice stands.
    if (touched) return;
    if (narrow.matches) fold.removeAttribute('open');
    else fold.setAttribute('open', '');
  }
  apply();
  if (narrow.addEventListener) narrow.addEventListener('change', apply);
  else narrow.addListener(apply);
})();
