// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
    $('.js-add_choice').click(function(event){
        console.log("ADD CHOICE");
        var i = $('.choices p').size();
        $('<p><input id="question_choices_attributes_' + i + '_name" type="text" ' +
            'size="30" placeholder="Choice" name="question[choices_attributes][' + i + '][name]"></p>').appendTo($('.choice_card'));
        event.preventDefault();

    });

    $('.js-select_choice').change(function () {
        var question = $(this).attr('name');
        var selectedChoice = $(this).val();

        $.ajax({
            url: url,
            type: 'POST',
            data: {
                choice: selectedChoice,
                question: question
            },
            success: function(data) {
            }
        });
        if($(this).hasClass('js-remove_question')){
            $(this).closest('.questions').remove();
        }
        else if($(this).hasClass('js-disable_question')) {
            $('input[name='+ question + ']').attr('disabled', 'disabled');
        }
    });

    $('#js-date_time_picker').datetimepicker({
        language: 'en',
        format: 'yyyy-MM-dd hh:mm:ss TZ',
        TimeZone: true
    });
});