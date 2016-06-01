/*global $*/

'use strict';
var validations = function(){

    var searchFromValidations = function(){
        var searchForm, county, highschool, section, evaluation_rate, overall_grade;

        searchForm = $('#percentage_form');

        searchForm.on('submit', function(e){
            county = $('#county_id');
            highschool = $('#highschool_id');
            section = $('#section_id');
            evaluation_rate = $('#evaluation_rate');
            overall_grade = $('#overall_grade')

            if(evaluation_rate.val() == ""){
                evaluation_rate.siblings('.field_with_errors').remove();
                overall_grade.siblings('.field_with_errors').remove();
                section.siblings('.field_with_errors').remove();
                county.siblings('.field_with_errors').remove();
                evaluation_rate.parent().append('<div class="field_with_errors"><label for="evaluation_rate" class="message">can\'t be blank</label></div>')
                e.preventDefault();
            }else if(overall_grade.val() == ""){
                overall_grade.siblings('.field_with_errors').remove();
                evaluation_rate.siblings('.field_with_errors').remove();
                section.siblings('.field_with_errors').remove();
                county.siblings('.field_with_errors').remove();
                overall_grade.parent().append('<div class="field_with_errors"><label for="overall_grade" class="message">can\'t be blank</label></div>')
                e.preventDefault();
            }else if(county.val() == ""){
                overall_grade.siblings('.field_with_errors').remove();
                evaluation_rate.siblings('.field_with_errors').remove();
                section.siblings('.field_with_errors').remove();
                county.siblings('.field_with_errors').remove();
                county.parent().append('<div class="field_with_errors"><label for="county_id" class="message">can\'t be blank</label></div>')
                e.preventDefault();
            }else if (section.val() == ""){
                overall_grade.siblings('.field_with_errors').remove();
                evaluation_rate.siblings('.field_with_errors').remove();
                section.siblings('.field_with_errors').remove();
                county.siblings('.field_with_errors').remove();
                section.parent().append('<div class="field_with_errors"><label for="section_id" class="message">can\'t be blank</label></div>')
                e.preventDefault();
            }
        });
    };

    searchFromValidations();
};

$(function() {
    'use strict'
    if ($.turbo.isReady) {
        validations();
    }
});
