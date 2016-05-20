/*global $*/

'use strict';
var main = function(){
    var getHighschools = function(){

        $('#county_id').on('change', function(){
            var countyId = $('#county_id option:selected').val();
            $.ajax ({
               type: 'get',
               url: '/county_highschools',
               data: { county_id: countyId },
               success: function(data) {
                  var highschools = $('#highschool_id');

                  if (data.highschools.length == 0){
                      highschools.empty();
                      highschools.prop('disabled', true);
                      highschools.append(new Option('Highschool', ''))
                  }else{
                      highschools.empty();
                      highschools.prop('disabled', false);
                  }

                  for (var x = 0; x < data.highschools.length; x++) {
                      highschools.append(new Option(data.highschools[x].name, data.highschools[x].id));
                  }

               }
            });
        })
    }

    getHighschools();
}

$(function() {
    'use strict'
    if ($.turbo.isReady) {
        main();
    }
});
