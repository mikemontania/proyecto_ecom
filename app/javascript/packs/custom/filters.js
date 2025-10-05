import $ from 'jquery';

window.set_filter_select = function() {

    $("#category-filter").on('change', function() {
        $("#preloader").css("display", "block");
        $("#contentPreload").hide();
    });

    $("#brand-filter").on('change', function() {
        $("#preloader").show();
        $("#preloader").css("display", "block");
        $("#contentPreload").hide();
    });
};
