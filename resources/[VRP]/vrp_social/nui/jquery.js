let page = 'Twitter';
let focus = false

$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButtom = $("#actionbutton");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				actionContainer.fadeIn(500);
				actionButtom.fadeIn(500);
			break;

			case "hideMenu":
				actionContainer.fadeOut(500);
				actionButtom.fadeOut(500);
			break;

			case "addTwitter":
				updateTwitter(item.data)
			break;

			case "add911":
				update911(item.data)
			break;

			case "add112":
				update112(item.data)
			break;

			case "addMechanic":
				updateMechanic(item.data)
			break;

			case "addTaxi":
				updateTaxi(item.data)
			break;

			case "addAnonymous":
				updateAnonymous(item.data)
			break;
		}
	});

	requestFunction('Twitter');

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_social/close");
		}
	};
});
/* ----------CLOSEBUTTON---------- */
$('#actionbutton').click(function(e){
	$.post("http://vrp_social/close");
});
/* ----------REQUESTTWITTER---------- */
const requestFunction = (data) => {
	page = data;
	$("#inicio").html("")
	$.post("http://vrp_social/request"+data,JSON.stringify({}),(data) => {
		$.each(JSON.parse(data),(k,v) => {
			$('#inicio').prepend(`<div class="tweet">${v.text}</div>`);
		})
	});
	$('#inicio').append(`<textarea maxlength="120" spellcheck="false" value="" placeholder="Digite sua mensagem...">`);

	$('textarea').focus(function(){
		focus = true
	}).blur(function(){
		focus = false
	})

	$("textarea").keydown(function(e){
		if (e.keyCode == 13) {
			e.preventDefault()
			if (focus){
				$.post('http://vrp_social/sendMessage',JSON.stringify({ text: $('textarea').val(), page: page }))
				$('textarea').blur()
				$('textarea').val("")
			}
		}
	})
}
/* ----------UPDATETWITTER---------- */
const updateTwitter = data => {
	if (page == 'Twitter'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}
/* ----------UPDATETWITTER---------- */
const update911 = data => {
	if (page == '911'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}
/* ----------UPDATETWITTER---------- */
const update112 = data => {
	if (page == '112'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}
/* ----------UPDATETWITTER---------- */
const updateMechanic = data => {
	if (page == 'Mechanic'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}
/* ----------UPDATETWITTER---------- */
const updateTaxi = data => {
	if (page == 'Taxi'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}
/* ----------UPDATETWITTER---------- */
const updateAnonymous = data => {
	if (page == 'Anonymous'){
		$('#inicio').prepend(`<div class="tweet">${data.text}</div>`);
	}
}