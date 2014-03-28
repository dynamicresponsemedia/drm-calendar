###############################################################################
# Adds a button for user to scroll to top immediately
###############################################################################
"use strict"

( ($) ->
    class window.DrmBackToTop
        constructor: (@button = $('button.back-to-top'), @content = $('body'), @speed = 300, @scrollSpeed = 900) ->
            @button.hide()
            $(window).on 'scroll', @showButton
            @button.on 'click', @toTop
            
        showButton: =>
            scroll = $('body').scrollTop()
            height = $(window).height()

            if scroll > height
                @button.fadeIn @speed
            else if scroll < height
                @button.fadeOut @speed 

        toTop: =>
            @content.stop().animate {
                'scrollTop': @content.position().top
            }, @scrollSpeed, 'swing'

    new DrmBackToTop()

) jQuery