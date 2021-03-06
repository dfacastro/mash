
$(document).ready(

function initAudio() {
	
	if ($('input#file_url').length == 0) {
		return false;
		}
		
	var file_url = $('input#file_url').val();
    
    var supportsAudio = !!document.createElement('audio').canPlayType,
            audio,
            loadingIndicator,
            positionIndicator,
            timeleft,
            loaded = false,
            manualSeek = false;

    if (supportsAudio) {
        
        var episodeTitle = $('body')[0].id;
        
        var player = '<p class="player">\
                                      <span id="playtoggle" />\
                                      <span id="gutter">\
                                        <span id="loading" />\
                                        <span id="handle" class="ui-slider-handle" />\
                                      </span>\
                                      <span id="timeleft" />\
                                      <audio preload="metadata">\
                                            <source src="saved/' + file_url + '" type="audio/mpeg"></source>\
                                        </audio>\
                                    </p>';                                  
        
        //$(player).insertAfter("#login");
        $(player).prependTo("#player");
        
        audio = $('.player audio').get(0);
        loadingIndicator = $('.player #loading');
        positionIndicator = $('.player #handle');
        timeleft = $('.player #timeleft');
        
        if ((audio.buffered != undefined) && (audio.buffered.length != 0)) {
            $(audio).bind('progress', function() {
                var loaded = parseInt(((audio.buffered.end(0) / audio.duration) * 100), 10);
                loadingIndicator.css({width: loaded + '%'});
            });
        }
        else {
            loadingIndicator.remove();
        }
        
        $(audio).bind('timeupdate', function() {
            
            var rem = parseInt(audio.duration - audio.currentTime, 10),
                    pos = (audio.currentTime / audio.duration) * 100,
                    mins = Math.floor(rem/60,10),
                    secs = rem - mins*60;
            
            timeleft.text('-' + mins + ':' + (secs < 10 ? '0' + secs : secs));
            if (!manualSeek) { positionIndicator.css({left: pos + '%'}); }
            if (!loaded) {
                loaded = true;
                
                $('.player #gutter').slider({
                        value: 0,
                        step: 0.01,
                        orientation: "horizontal",
                        range: "min",
                        max: audio.duration,
                        animate: true,                  
                        slide: function(){                          
                            manualSeek = true;
                        },
                        stop:function(e,ui){
                            manualSeek = false;                 
                            audio.currentTime = ui.value;
                        }
                    });
            }
            
        }).bind('play',function(){
            $("#playtoggle").addClass('playing');       
        }).bind('pause ended', function() {
            $("#playtoggle").removeClass('playing');        
        });     
        
        $("#playtoggle").click(function() {         
            if (audio.paused) { audio.play();   } 
            else { audio.pause(); }         
        });

    }
});