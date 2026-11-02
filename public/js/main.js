// Progressive enhancement: active nav link, mobile menu, header shadow.
(function () {
  document.documentElement.classList.add('js');

  document.addEventListener('DOMContentLoaded', function () {
    var path = window.location.pathname.replace(/\/+$/, '') || '/';
    var nav = document.getElementById('site-nav');
    var toggle = document.querySelector('.nav-toggle');
    var header = document.querySelector('.site-header');

    // Mark the current page in the navigation
    document.querySelectorAll('.site-nav a').forEach(function (link) {
      if (link.getAttribute('href') === path) {
        link.setAttribute('aria-current', 'page');
      }
    });

    // Mobile menu
    if (toggle && nav) {
      toggle.addEventListener('click', function () {
        var open = nav.classList.toggle('is-open');
        toggle.setAttribute('aria-expanded', String(open));
      });
      document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && nav.classList.contains('is-open')) {
          nav.classList.remove('is-open');
          toggle.setAttribute('aria-expanded', 'false');
          toggle.focus();
        }
      });
    }

    // Subtle shadow once the page is scrolled
    if (header) {
      var onScroll = function () { header.classList.toggle('is-scrolled', window.scrollY > 8); };
      onScroll();
      window.addEventListener('scroll', onScroll, { passive: true });
    }
  });
})();
