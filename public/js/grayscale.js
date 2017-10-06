/*!
 * Start Bootstrap - Grayscale Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */


//Window width
var initialWindowWidth
var initialTop
var initialLineHeight
var initalTopMargin

//Boolean For Reload
var reload = true;

//Browser type
navigator.sayswho = (function(){
    var ua= navigator.userAgent, tem,
    M= ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if(/trident/i.test(M[1])){
        tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
        return 'IE '+(tem[1] || '');
    }
    if(M[1]=== 'Chrome'){
        tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
        if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
    }
    M= M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
    if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
    return M.join(' ');
})();

var browserType = (navigator.sayswho).toLowerCase()

console.log(browserType);

// jQuery to collapse the navbar on scroll
function collapseNavbar() {
    if ($(".navbar").offset().top > 50) {
        $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
        $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }
}

$(window).scroll(collapseNavbar);
$(document).ready(collapseNavbar);

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

$(window).ready(function(){
  $("#resume-div").load("file:///views/resume.html");
});

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $(".navbar-collapse").collapse('hide');
});

//Function for resizing Portfolio background to be consistent
//with flip containers
$(window).resize(function() {
  if ($(".backImage3").length){
    var photoPosition = $(".backImage3").offset().top;
    photoPosition = photoPosition + $(".backImage3").height();
    var containerPosition = $(".download-section").offset().top;
    containerPosition = containerPosition + $(".download-section").height();
    var distanceBetweenConPhoto = containerPosition - photoPosition;
    var desiredDistance = $(window).height() * .05; //Percentage of View Height
    var addedDist = distanceBetweenConPhoto - desiredDistance;
    var backGroundHeight = $(".download-section").height();
    $(".download-section").height(backGroundHeight-addedDist);

    //Overlay Portfolio Resize
    var proportionalResizePercent = $(window).width()/initialWindowWidth;
    console.log(initialTop,proportionalResizePercent);
    var adjustedTop  = initialTop * proportionalResizePercent;

    adjustedTop = Math.ceil(adjustedTop);

    $(".text").css("top", adjustedTop + "px");
    $(".text1").css("top", adjustedTop + "px");
    $(".text2").css("top", adjustedTop +"px");
    $(".text3").css("top", adjustedTop +"px");
    $(".text4").css("top", adjustedTop +"px");
    $(".text5").css("top", adjustedTop + "px");

    //Button Centering for Portfolio
    var lineHeight = initialLineHeight * proportionalResizePercent;
    $(".text").css("line-height", lineHeight + "px");
    $(".text2").css("line-height", lineHeight + "px");
    $(".text3").css("line-height", lineHeight + "px");
    $(".text4").css("line-height", lineHeight + "px");

    var topMargin = initalTopMargin * proportionalResizePercent;
    $(".rd").css("margin-top", topMargin + "px");
    $(".pp").css("margin-top", topMargin + "px");

  }
  else{
    console.log("Unable To Resize Effectively");
  }
});

//Initial Portfolio Resize
$(document).ready(function(){
  //Get window width and save as global var
  initialWindowWidth = $(window).width();
  if ($(".backImage3").length){
    var photoPosition = $(".backImage3").offset().top;
    photoPosition = photoPosition + $(".backImage3").height();
    var containerPosition = $(".download-section").offset().top;
    containerPosition = containerPosition + $(".download-section").height();
    var distanceBetween = containerPosition - photoPosition;
    var desiredDistance = $(window).height() * .05; //Percentage of View Height
    var addedDist = distanceBetween - desiredDistance;
    var backGroundHeight = $(".download-section").height();
    $(".download-section").height(backGroundHeight-addedDist);

    //Bottom Alignment for Portfolio Overlay Left
    var photoTop = $('.backImage4').offset().top;
    var textTop = $(".text2").offset().top;
    var shiftUp = textTop - photoTop;
    if (browserType.search("safari") != -1 || browserType.search("firefox") != -1){
      console.log("Not Chrome browser identified.");
      shiftUp = shiftUp + ($(".backImage3").height());
    };

    $(".text").css("top", shiftUp + "px");
    $(".text1").css("top", shiftUp + "px");
    $(".text2").css("top", shiftUp + "px");
    $(".text3").css("top", shiftUp + "px");
    $(".text4").css("top", shiftUp + "px");
    $(".text5").css("top", shiftUp + "px");

    //Button Alignment
    var lineHeight = $(".text4").height();
    initialLineHeight = lineHeight;
    $(".text").css("line-height", lineHeight + "px");
    $(".text2").css("line-height", lineHeight + "px");
    $(".text3").css("line-height", lineHeight + "px");
    $(".text4").css("line-height", lineHeight + "px");

    var marginheight = $(".text1").height()/5;
    $(".rd").css("margin-top", marginheight + "px");
    $(".pp").css("margin-top", marginheight + "px");
    initalTopMargin = marginheight;


    console.log("Successfully attempted to reposition Portfolio overlay");
    if ($('.backImage2').offset().top <= $(".text2").offset().top-7.5 || $('.backImage2').offset().top >= $(".text2").offset().top+7.5){
      console.log("Failed to adjust overlay");
        if (reload) {
            location.reload();
            reload = false;
        } else {
            window.location.href = '/404';
        }
    }
    else{
      console.log("Success");
    }
    //Universal top for adjustments to Overlay Portfolio
    initialTop = shiftUp;
  }
  else{
    console.log("Unable To Resize Effectively");
  }
});


// Google Maps Scripts
var map = null;
// When the window has finished loading create our google map below
google.maps.event.addDomListener(window, 'load', init);
google.maps.event.addDomListener(window, 'resize', function() {
    map.setCenter(new google.maps.LatLng(40.6700, -73.9400));
});

function init() {
    // Basic options for a simple Google Map
    // For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
    var mapOptions = {
        // How zoomed in you want the map to start at (always required)
        zoom: 15,

        // The latitude and longitude to center the map (always required)
        center: new google.maps.LatLng(40.6700, -73.9400), // New York

        // Disables the default Google Maps UI components
        disableDefaultUI: true,
        scrollwheel: false,
        draggable: false,

        // How you would like to style the map.
        // This is where you would paste any style found on Snazzy Maps.
        styles: [{
            "featureType": "water",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 17
            }]
        }, {
            "featureType": "landscape",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 20
            }]
        }, {
            "featureType": "road.highway",
            "elementType": "geometry.fill",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 17
            }]
        }, {
            "featureType": "road.highway",
            "elementType": "geometry.stroke",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 29
            }, {
                "weight": 0.2
            }]
        }, {
            "featureType": "road.arterial",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 18
            }]
        }, {
            "featureType": "road.local",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 16
            }]
        }, {
            "featureType": "poi",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 21
            }]
        }, {
            "elementType": "labels.text.stroke",
            "stylers": [{
                "visibility": "on"
            }, {
                "color": "#000000"
            }, {
                "lightness": 16
            }]
        }, {
            "elementType": "labels.text.fill",
            "stylers": [{
                "saturation": 36
            }, {
                "color": "#000000"
            }, {
                "lightness": 40
            }]
        }, {
            "elementType": "labels.icon",
            "stylers": [{
                "visibility": "off"
            }]
        }, {
            "featureType": "transit",
            "elementType": "geometry",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 19
            }]
        }, {
            "featureType": "administrative",
            "elementType": "geometry.fill",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 20
            }]
        }, {
            "featureType": "administrative",
            "elementType": "geometry.stroke",
            "stylers": [{
                "color": "#000000"
            }, {
                "lightness": 17
            }, {
                "weight": 1.2
            }]
        }]
    };

    // Get the HTML DOM element that will contain your map
    // We are using a div with id="map" seen below in the <body>
    var mapElement = document.getElementById('map');

    // Create the Google Map using out element and options defined above
    map = new google.maps.Map(mapElement, mapOptions);

    // Custom Map Marker Icon - Customize the map-marker.png file to customize your icon
    var image = 'img/map-marker.png';
    var myLatLng = new google.maps.LatLng(40.6700, -73.9400);
    var beachMarker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        icon: image
    });
}
