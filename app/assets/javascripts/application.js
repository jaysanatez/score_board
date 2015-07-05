//= require jquery
//= require jquery_ujs
//= require_tree .

$(window).resize(function() {
	showOrHideNavOptions();
	showFullNameOrAbbreviation();
});

$(window).load(function() {
	showOrHideNavOptions();
	showFullNameOrAbbreviation();
});

$(document).ready(function() {
	// current event scroll
	if($('#show').length > 0) {
		// $('html, body').animate({ scrollTop: $('#show').offset().top - 100 }, 750);
	}

	// edit event animations
	$('#edit-event').click(function() {
		$('.flip-card').toggleClass('flipped');
		$('.winner').css('visibility', 'hidden');
	});

	$('#save-event').click(function() {
		$('#away-score').text($('#event_away_score').val());
		$('#home-score').text($('#event_home_score').val());
		
		// update ribbon bar values

		var p = $('#event_period').find(":selected").val();
		var s = $('#event_status').find(":selected").val();
		var pd = "";

		if (s == '1') {
			switch (p) {
				case '1':
					pd = "1st";
					break;
				case '2':
					pd = "2nd";
					break;
				case '3':
					pd = "Half";
					break;
				case '4':
					pd = "3rd";
					break;
				case '5':
					pd = "4th";
					break;
				case '6':
					pd = "OT";
					break;
			}
		} else if (s == '2') {
			pd = p == 6 ? "Final/OT" : "Final";
		} else if (s == '3') {
			pd = "Postponed";
		}

		$('.period-display').text(pd);

		$('.flip-card').toggleClass('flipped');
		$('.winner').css('visibility', 'visible');

		$('#update-event').submit();
	});

	$('#undo-flip').click(function() {
		$('.flip-card').toggleClass('flipped');
		$('.winner').css('visibility', 'visible');
	});
});

function showOrHideNavOptions() {
	var o = $('#nav-options');
	if (o.length > 0) { 
		if ($(window).width() >= 750) { o.show(); } else { o.hide(); } 
	}
}

function showFullNameOrAbbreviation() {
	var a = $('.away-display');
	var h = $('.home-display');
	if(a.length > 0 && h.length > 0) {
		if ($(window).width() >= 700) {
			$.each(a, function(i, v) { $(v).html($(v).attr('data-display').split(';')[0]); });
			$.each(h, function(i, v) { $(v).html($(v).attr('data-display').split(';')[0]); });
		} else {
			$.each(a, function(i, v) { $(v).html($(v).attr('data-display').split(';')[1]); });
			$.each(h, function(i, v) { $(v).html($(v).attr('data-display').split(';')[1]); });
		}
	}
}