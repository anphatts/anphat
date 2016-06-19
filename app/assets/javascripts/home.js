var ready;
ready = function () {
    $.ajaxSetup({ cache: false });
    $('#menu').metisMenu({
        toggle: true,
        doubleTapToGo: false,
        preventDefault: true,
        activeClass: 'active',
        collapseClass: 'collapse',
        collapseInClass: 'in',
        collapsingClass: 'collapsing',
        onTransitionStart: false,
        onTransitionEnd: false
    });

};
$(document).ready(ready);
$(document).on('page:load', ready);