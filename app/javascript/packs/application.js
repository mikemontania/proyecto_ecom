require("jquery");
require("cocoon");
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require('bootstrap');
require("inputmask");

require('data-confirm-modal');
global.toastr = require("toastr")

import "controllers"
//require("trix");
//require("@rails/actiontext");
require("./jquery.bxslider.min");
require("./flickity.pkgd.min");
require("./jquery.lazyload");
require("./panel/bootstrap-datepicker-min");
require("./panel/bootstrap-datepicker-es-min");

var config = {
    adaptiveHeight: true,
    auto: true,
    pause: 6000,
    touchEnabled: false,
    controls: false,
    autoHover: true
}

var configMobile = {
    adaptiveHeight: true,
    auto: true,
    pause: 6000,
    touchEnabled: true,
    controls: false,
    autoHover: true
}

window.countdownTimer = (date) => {
    console.log(date);
    var countDownDate = new Date(date).getTime();

    // Update the count down every 1 second
    var x = setInterval(function() {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Display the result in the element with id="demo"
        document.getElementById("countdownTimer").innerHTML = days + "d " + hours + "h "
            + minutes + "m " + seconds + "s ";

        // If the count down is finished, write some text
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("countdownTimer").innerHTML = "EXPIRED";
        }
    }, 1000);
}

window.set_slider = function () {
    $('#slider-desktop').bxSlider(config);
    $('#slider-mobile').bxSlider(configMobile);
};

window.datepicker = function() {
    $("#multi-dates").datepicker({
        language: "es",
        multidate: true
    });
    $("#countdownStartDate").datepicker({
        language: "es",
        multidate: false
    });
    $("#countdownEndDate").datepicker({
        language: "es",
        multidate: false
    });
};

document.addEventListener("turbolinks:load", function () {
    //Call cookie modal
    $("#cookieModal").modal("show");

    window.onscroll = function () {
        scrollFunction()
    };

    //Call datepicker function.
    datepicker();
    // When the user clicks on the button, scroll to the top of the document
    function goToTop() {
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
    }

    // Add event click to the button.
    var myBtn = document.getElementById("myBtn");
    if(myBtn) {
        myBtn.addEventListener('click', goToTop);
    }

    function scrollFunction() {
        if (document.body.scrollTop > 40 || document.documentElement.scrollTop > 40) {
            document.getElementById("myBtn").style.display = "flex";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    }

    //Lazy Loading images.
    //var lazyloadImages = document.querySelectorAll("img.lazy");
    //var lazyloadThrottleTimeout;

    //function lazyload () {
    //    if(lazyloadThrottleTimeout) {
    //        clearTimeout(lazyloadThrottleTimeout);
    //    }

    //    lazyloadThrottleTimeout = setTimeout(function() {
    //        var scrollTop = window.pageYOffset;
    //        lazyloadImages.forEach(function(img) {
    //            if(img.offsetTop < (window.innerHeight + scrollTop)) {
    //                img.src = img.dataset.src;
    //                img.classList.remove('lazy');
    //            }
    //        });
    //        if(lazyloadImages.length == 0) {
    //            document.removeEventListener("scroll", lazyload);
    //            window.removeEventListener("resize", lazyload);
    //            window.removeEventListener("orientationChange", lazyload);
    //        }
    //    }, 20);
    //}

    //document.addEventListener("scroll", lazyload);
    //window.addEventListener("resize", lazyload);
    //window.addEventListener("orientationChange", lazyload);
    //End Lazy Loading images.

    $("#addCart").click(function() {
        var dataInternalProduct = $(this).attr('data-internal-product-id');

        $.ajax({
            url: "/get-product-information",
            type: 'POST',
            dataType: 'json',
            data: { id: dataInternalProduct },
            success: function(response) {
                console.log("enviando gtag add_to_cart...");
                gtag('event', 'add_to_cart', {
                  currency: 'PYG',
                  items: [response],
                  value: 0
                });
                console.log("gtag enviado.");
            }
        });

    });

    //$("#removeItemFromCart").click(function() {
    //    var dataInternalProduct = $(this).attr('data-internal-product-id');

    //    $.ajax({
    //        url: "/get-product-information",
    //        type: 'POST',
    //        dataType: 'json',
    //        data: { id: dataInternalProduct },
    //        success: function(response) {
    //            console.log("enviando gtag remove_from_cart...");
    //            gtag('event', 'remove_from_cart', {
    //              currency: 'PYG',
    //              items: [response],
    //              value: 0
    //            });
    //            console.log("gtag enviado.");
    //        }
    //    });

    //});

    $(function() {
        $("#buttonTableProducts").on("click", function() {
            var validateFields = $(".validation").length;
            var value = $(".validation").filter(function() {
                return this.value != '';
            });

            if(value.length >= 0 && (value.length !== validateFields)) {
                alert('Por favor, completa los campos de código y precio');
            }
            else {
                $("#internal-products-modal").modal('hide');
                $(".modal-backdrop").hide();
            }
        });

        $("img.img-lazy").lazyload({
            effect: 'fadeIn',
            threshold: 0.01
        });

        var inputTax = document.getElementById("order_tax_number");
        var chkdoc = $('#order_tax_number_type');
        var userPhone = $("#user_phone");
        var orderPhone = $("#order_shipping_phone");

        var inputMaskRuc = new Inputmask({"mask": "9{+}-9"});
        var inputMask = new Inputmask({mask: "9{*}"});
        var inputPhone = new Inputmask({mask: "(9999) 999-999", placeholder: "(09**) ***-***"});

        if(userPhone.length) {
            inputPhone.mask(userPhone);
        }

        if(orderPhone.length) {
            inputPhone.mask(orderPhone);
        }

        if(chkdoc.length) {

            var chkdocSelected = $("#order_tax_number_type option:selected").val();

            if(chkdocSelected.length) {
                if(chkdocSelected == "RUC") {
                    inputMaskRuc.mask(inputTax);
                }
                if(chkdocSelected == "CI") {
                    inputMask.mask(inputTax);
                }
            }

            chkdoc.change(function() {
                if(this.value == "RUC") {
                    inputMaskRuc.mask(inputTax);
                }

                if(this.value == "CI") {
                    inputMask.mask(inputTax);
                }
            });
        }

        var inputTaxUser = document.getElementById("user_id_number");
        var chkdocUser = $('#user_id_type');

        var inputMaskRucUser = new Inputmask({"mask": "9{+}-9"});
        var inputMaskUser = new Inputmask({mask: "9{*}"});

        if(chkdocUser.length) {

            var chkdocSelectedUser = $("#user_id_type option:selected").val();

            if(chkdocSelectedUser.length) {
                if(chkdocSelectedUser == "RUC") {
                    inputMaskRucUser.mask(inputTaxUser);
                }
                if(chkdocSelectedUser == "CI") {
                    inputMaskUser.mask(inputTaxUser);
                }
            }

            chkdocUser.change(function() {
                if(this.value == "RUC") {
                    inputMaskRucUser.mask(inputTaxUser);
                }

                if(this.value == "CI") {
                    inputMaskUser.mask(inputTaxUser);
                }
            });
        }

        $("#formSearch").on("submit", function(e) {
            if($("#inputSearch").val() == "") {
                e.preventDefault();
            }
        });

        // Back button search
        $("#buttonSearch").click(function () {
            $("#formSearchWrap").animate({
                top: 0
            }, 100, function () {
                $(".input-text-search").focus();
            });
        });

        $("#backButtonSearch").click(function () {
            $("#formSearchWrap").animate({
                top: "-100px"
            }, 100);
        });
        // Open Contact modal.
        $("#btnContact").click(function () {
            $(".overlay").css("height", $(document).height()).fadeIn(100);
            $("body").css("overflow", "hidden");
            $("#modalContact").animate({
                bottom: "0"
            }, 100);
        });
        // Close contact modal.
        $("#closeModalContact").click(function () {
            $(".overlay").css("height", "0").fadeIn(100);
            $(".overlay").fadeOut(100);
            $("body").css("overflow", "inherit");
            $("#modalContact").animate({
                bottom: "-1000px"
            }, 100);
        })

        $("#button-back").on('click', function (e) {
            history.go(-1);
            return false;
        });
    });

    // Mostrar flechita en el collapse del menu mobile.
    $('.collapse').on('show.bs.collapse', function () {
        $(this).siblings('.arrow-collapse').addClass('active');
    });

    $('.collapse').on('hide.bs.collapse', function () {
        $(this).siblings('.arrow-collapse').removeClass('active');
    });

    // Contactos
    $('#numeros').on('show.bs.collapse', function () {
        $('#show-more-numeros').html('Ver menos');
    });
    $('#numeros').on('hidden.bs.collapse', function () {
        $('#show-more-numeros').html('Ver más');
    });

    $('#direccion').on('show.bs.collapse', function () {
        $('#show-more-direccion').html('Ver menos');
    });
    $('#direccion').on('hidden.bs.collapse', function () {
        $('#show-more-direccion').html('Ver más');
    });

});
