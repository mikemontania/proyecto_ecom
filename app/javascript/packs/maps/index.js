const polygonCoords = [
    [-25.0974296642218,-57.5036600708723 ],
    [-25.102306950462,-57.5174144387007 ],
    [-25.1140233013446,-57.5270489334822 ],
    [-25.145533351391,-57.536018240428 ],
    [-25.1719085077579,-57.5376061081648 ],
    [-25.19361808855,-57.5553301453352 ],
    [-25.244789222479,-57.5990179657698 ],
    [-25.2568606066943,-57.6291874527693 ],
    [-25.2782445825731,-57.6634768128157 ],
    [-25.2905066508731,-57.6701716065169 ],
    [-25.3134752895453,-57.6706865906477 ],
    [-25.3310868024238,-57.6627043366194 ],
    [-25.3439252993684,-57.6477268814802 ],
    [-25.3561419391164,-57.6457956909895 ],
    [-25.3601750983735,-57.6471582531691 ],
    [-25.3642081230704,-57.6444009423018 ],
    [-25.3682410131915,-57.6364830612898 ],
    [-25.3825101589569,-57.620303976512 ],
    [-25.4174004216528,-57.5757578491926 ],
    [-25.4362757225454,-57.5571325897932 ],
    [-25.4574729965521,-57.5477770447493 ],
    [-25.4701624483289,-57.5521973252058 ],
    [-25.4744920542307,-57.5584415077925 ],
    [-25.479751298703,-57.5626257538557 ],
    [-25.4996433025107,-57.5693634629011 ],
    [-25.5032988505442,-57.5740948796034 ],
    [-25.5085035779427,-57.5764230370283 ],
    [-25.5198418401254,-57.5699213623762 ],
    [-25.5264642065599,-57.559793341136 ],
    [-25.518931720269,-57.5415114044905 ],
    [-25.5106241370772,-57.5234011292219 ],
    [-25.5031487573847,-57.4985102295637 ],
    [-25.5009409137543,-57.4753359436751 ],
    [-25.5088424826018,-57.4271849274397 ],
    [-25.5212360529035,-57.391393530345 ],
    [-25.5238114311351,-57.3699787735701 ],
    [-25.5214296922862,-57.3506239533186 ],
    [-25.5337057912149,-57.3301104187727 ],
    [-25.5644486120427,-57.3024729370833 ],
    [-25.6512911888619,-57.1476343750715 ],
    [-25.6403039050582,-57.1211985230208 ],
    [-25.598047606764,-57.1430853485823 ],
    [-25.5771461150015,-57.1795633911848 ],
    [-25.5484974021086,-57.2042826294661 ],
    [-25.51697590744,-57.2324350952864 ],
    [-25.4538305861302,-57.273977148509 ],
    [-25.4245322996275,-57.2769812226057 ],
    [-25.3979406526627,-57.2707155823469 ],
    [-25.3555214411346,-57.2362116455794 ],
    [-25.2409851294118,-57.3275354981184 ],
    [-25.2170709612428,-57.3634127259016 ],
    [-25.2054227482025,-57.3689917206526 ],
    [-25.1962587038877,-57.3883036255598 ],
    [-25.1571096008267,-57.4157694458723 ],
    [-25.1412599617095,-57.4270990967512 ],
    [-25.1125078166929,-57.4633196472883 ],
    [-25.1006164390069,-57.4876097321272]
];

window.initMap = function () {

    var lat_field = document.getElementById("order_latitude");
    var lng_field = document.getElementById("order_longitude");
    var previous_lat = lat_field.value;
    var previous_lng = lng_field.value;
    var lat = previous_lat;

    //Modal for message.
    var myModal = new bootstrap.Modal(document.getElementById('alertModal'), {
      keyboard: false
    })

    if (!previous_lat) {
        lat = -25.3098518;
    }
    var lng = previous_lng;
    if (!previous_lng) {
        lng = -57.6079531;
    }

    var icon = {
        url: 'http://maps.google.com/mapfiles/kml/paddle/orange-blank.png',
        scaledSize: new google.maps.Size(45,45)
    };

    map = new GMaps({
        div: '#gmap',
        lat: lat,
        lng: lng,
        zoom: 13,
        streetViewControl: false,
        mapTypeControl: false,
        fullscreenControl: false,
        rotateControl: false,

        click: function (e) {
            var lat = e.latLng.lat();
            var lng = e.latLng.lng();

            if(checkGeofence(map, lat, lng)){
                map.removeMarkers();

                map.addMarker({
                    lat: lat,
                    lng: lng,
                    icon: icon,
                    draggable: true,

                    dragend: function(event) {
                        dragLat = event.latLng.lat();
                        dragLng = event.latLng.lng();

                        if(checkGeofence(map, dragLat, dragLng)) {
                            setLocationFields(dragLat, dragLng);
                        }

                        else {
                            //TODO: Revisar si vale la pena esta opción.
                            map.removeMarkers();
                            myModal.show();
                        }
                    }
                });

                setLocationFields(lat, lng);
            }else{
                myModal.show();
            }
        }
    });

    // Create the search box and link it to the UI element.
    const input = document.getElementById("address");
    const searchBox = new google.maps.places.SearchBox(input);
    //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
    // Bias the SearchBox results towards current map's viewport.
    let markers = [];

    $("#address").focusout(function() {
        GMaps.geocode({
            address: $("#address").val(),
            callback: function(results, status) {
                map.removeMarkers();
                if (status == 'OK') {
                    var latlng = results[0].geometry.location;
                    if(checkGeofence(map, latlng.lat(), latlng.lng())) {
                        var geoLat = latlng.lat();
                        var geoLng = latlng.lng();

                        map.setCenter(geoLat, geoLng);
                        setLocationFields(geoLat, geoLng);

                        map.addMarker({
                            lat: geoLat,
                            lng: geoLng,
                            icon: icon,
                            draggable: true,

                            dragend: function(event) {
                                dragLat = event.latLng.lat();
                                dragLng = event.latLng.lng();

                                if(checkGeofence(map, dragLat, dragLng)) {
                                    setLocationFields(dragLat, dragLng);
                                }

                                else {
                                    //TODO: Revisar si vale la pena esta opción.
                                    map.removeMarkers();
                                    myModal.show();
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    polygon = map.drawPolygon({
        paths: polygonCoords,
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35,
        clickable: false
    });
    var fence = map.polygons[0];

    if (previous_lat && previous_lng) {
        if(checkGeofence(map, lat, lng)){

            map.addMarker({
                lat: lat,
                lng: lng,
                icon: icon
            })

        }

    };

};

window.initMapUser = function () {

    var lat_field = document.getElementById("user_latitude");
    var lng_field = document.getElementById("user_longitude");
    var previous_lat = lat_field.value;
    var previous_lng = lng_field.value;
    var lat = previous_lat;

    var icon = {
        url: 'http://maps.google.com/mapfiles/kml/paddle/orange-blank.png',
        scaledSize: new google.maps.Size(45,45)
    };

    if (!previous_lat) {
        lat = -25.3098518;
    }
    var lng = previous_lng;
    if (!previous_lng) {
        lng = -57.6079531;
    }


    map = new GMaps({
        div: '#gmap',
        lat: lat,
        lng: lng,
        zoom: 12,
        click: function (e) {

            var lat = e.latLng.lat();
            var lng = e.latLng.lng();

            map.removeMarkers();

            map.addMarker({
                lat: lat,
                lng: lng,
                icon: icon
            });

            setLocationFieldsUser(lat, lng);
        }
    });

    if (previous_lat && previous_lng) {
        map.addMarker({
            lat: lat,
            lng: lng,
            icon: icon
        })
    };
};

window.initMapCobertura = function () {

    map = new GMaps({
        div: '#gmap_cobertura',
        lat: -25.3098518,
        lng: -57.6079531,
        zoom: 10,
    });

    polygon = map.drawPolygon({
        paths: polygonCoords,
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35,
        clickable: false
    });

};


function setLocationFields(lat, lng) {
    var lat_field = document.getElementById("order_latitude");
    var lng_field = document.getElementById("order_longitude");

    lat_field.value = lat;
    lng_field.value = lng;

}

function setLocationFieldsUser(lat, lng) {
    var lat_field = document.getElementById("user_latitude");
    var lng_field = document.getElementById("user_longitude");

    lat_field.value = lat;
    lng_field.value = lng;

}

function checkGeofence(map, lat, lng){
    fence = map.polygons[0];

    return map.checkGeofence(lat, lng, fence);
}
