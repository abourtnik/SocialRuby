//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

(function ($) {

    console.log('cououc');

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });


    // Follow

    $(document).on('click', '.follow', function() {

        var $button = $(this);

        var user_id = $(this).attr('user-id');

        $.post("/users/follow/"+ user_id , function (response) {

            if (response.error) console.log(response.message);

            else {

                $button.removeClass('btn-warning').addClass('btn-danger');
                $button.removeClass('follow').addClass('unfollow');
                $button.find('i').removeClass('fa-user-plus').addClass('fa-user-times');
                $button.find('span').text('Ne plus suivre');
            }

        } , 'json');
    });

    // UnFollow

    $(document).on('click', '.unfollow', function() {

        var $button = $(this);

        var user_id = $(this).attr('user-id');

        $.post("/users/unfollow/"+ user_id , function (response) {

            if (response.error) console.log(response.message);

            else {

                $button.removeClass('btn-danger').addClass('btn-warning');
                $button.removeClass('unfollow').addClass('follow');
                $button.find('i').removeClass('fa-user-times').addClass('fa-user-plus');
                $button.find('span').text('Suivre');
            }

        } , 'json');
    });


    // Like

    $(document).on('click', '.btn-like', function() {

        var $button = $(this);

        var post_id = $(this).attr('post_id');

        $.post("/posts/like/"+ post_id , function (response) {

            if (response.error) console.log(response.message);

            else {

                $(".btn-like[post_id='"+ post_id +"']").find('span').text(response.like_count);
                $button.removeClass('btn-like').addClass('btn-unlike');
                $button.find('i').css('color' , 'blue');

            }

        } , 'json');
    });

    // Unlike

    $(document).on('click', '.btn-unlike', function() {

        var $button = $(this);

        var post_id = $(this).attr('post_id');

        $.post("/posts/unlike/"+ post_id , function (response) {

            if (response.error) console.log(response.message);

            else {

                $(".btn-unlike[post_id='"+ post_id +"']").find('span').text(response.like_count);
                $button.removeClass('btn-unlike').addClass('btn-like');
                $button.find('i').css('color' , 'inherit');
            }

        } , 'json');
    });



})(jQuery);
