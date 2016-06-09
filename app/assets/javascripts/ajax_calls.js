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
                  var sections = $("#section_id");
                  if (data.highschools.length == 0){
                      highschools.empty();
                      highschools.prop('disabled', true);
                      highschools.append(new Option('---', ''))
                      sections.empty();
                      sections.prop('disabled', true);
                      sections.append(new Option('---', ''))
                  }else{
                      highschools.empty();
                      highschools.prop('disabled', false);
                      highschools.append(new Option('---', ''))
                  }

                  for (var x = 0; x < data.highschools.length; x++) {
                      highschools.append(new Option(data.highschools[x].name, data.highschools[x].id));
                  }

               }
            });
        })
    };

    var getSections = function(){
      $('#highschool_id').on('change blur', function(){
          var highschoolId = $('#highschool_id option:selected').val();
          $.ajax ({
             type: 'get',
             url: '/highschool_sections',
             data: { highschool_id: highschoolId },
             success: function(data) {
                var sections = $('#section_id');
                if (data.sections.length == 0){
                    sections.empty();
                    sections.prop('disabled', true);
                    sections.append(new Option('---', ''))
                }else{
                    sections.empty();
                    sections.prop('disabled', false);
                    sections.append(new Option('---', ''))
                }

                for (var x = 0; x < data.sections.length; x++) {
                    sections.append(new Option(data.sections[x].name, data.sections[x].id));
                }

             }
          });
      })
    };

    getHighschools();
    getSections();
}

$(function() {
    'use strict'
    if ($.turbo.isReady) {
        main();
    }
});
