import $ from 'jquery';
require("../bxslider_min");

var config = {
    adaptiveHeight: true,
    touchEnabled: false,
    oneToOneTouch: false,
    controls: false,
    auto: true
}

window.set_slider = function () {
    $('#slider-desktop').bxSlider(config);
    $('#slider-mobile').bxSlider(config);
};
