function loadGApi(){
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(setupChart);	
}

var QUESTION_PER_PAGE = 5;

function setupChart() {	
  chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
  $list = $("#list").html('');
  questions_data = [];
  for( var i = 0; i < questions.length; i += QUESTION_PER_PAGE ){
  		
  	var number_questions = QUESTION_PER_PAGE;
  	if((i + QUESTION_PER_PAGE) > questions.length){
  		number_questions = questions.length - i;
  	}
	
		var array_data = []
		var questions_headers = ['Questions','Answers','Comments','Votes','Karma']
		array_data.push(questions_headers);
		for(var j = 0; j < number_questions; j++){
			var actual_question = questions[i + j];
			var question_data = [actual_question.title,
				parseInt(actual_question.answers),
				parseInt(actual_question.comments),
				parseInt(actual_question.votes),
				parseInt(actual_question.karma)];
			array_data.push(question_data);
		}
		var index = i/QUESTION_PER_PAGE;
		questions_data[index] = google.visualization.arrayToDataTable(array_data);
		
  } 
    
  google.visualization.events.addListener(chart, 'select', selectHandler);  
  var options = new ChartOption(1,number_questions,questions.length);
  setupChartNavigation(options);
  drawChart(0,options);
}

function selectHandler() {
  var selectedItem = chart.getSelection()[0];
  if (selectedItem) {
   // var topping = questions_data.getValue(selectedItem.row, 0);
    alert('The user selected ' + JSON.stringify(selectedItem));
  }
}

var ChartOption = function(from,to,total){
	this.title = 'Displying questions ' + from + '-' + to +' / ' + total;
	this.vAxis = {title: ""};
	this.hAxis = {title: "Questions"};
	this.seriesType = "bars";
	//this.series = {3: {type: "line"}};
	this.animation = { duration: 1000, easing: 'in'};

}

function drawChart(index,options){
	chart.draw(questions_data[index], options);
	$list.html(questionList(index));
}

function questionList(index){
	var list_size = questions.length - (index * QUESTION_PER_PAGE);
	if(list_size > QUESTION_PER_PAGE){
		list_size = QUESTION_PER_PAGE;
	}
	var list_html = "<ul>";
	for(var i = 0; i < list_size; i++){
		var at = (index * QUESTION_PER_PAGE) + i;
		list_html += "<li><h3><a href=\"javascript:showAnswersForQuestion("+ questions[at].question_id;
		list_html += ",'" + questions[at].title + "')\">";
		list_html += questions[at].title + "</a></h3></li>";
	}
	list_html += "</ul>";
	return list_html;

}

function showAnswersForQuestion(question_id,question){
	var url = "/questions/" + question_id + "/answers";
	$.get(url,function(response){
			if(response.length){
				listAnswers(response,question);
			} else {
				alert("No answers were found for this question.");
			}
	});
}

function listAnswers(answers,question){
	var list_html = "<h2>Answers for : " + question + "</h2>";
	list_html += "<ul>";
	for(var i = 0; i < answers.length; i++){
		list_html += "<li><div>" + answers[i].body + "</div>";
		list_html += "<button  onClick='markAsBestAnswer(";
		list_html += answers[i].id;
		list_html += ")'>Mark as best answer</button>"
		list_html += "</li>";
	}
	list_html += "</ul>";
	$("#answers_container").html(list_html);
	scrollTo("#answers_container",100);
}

var scrollTo = function(container,delay){
	$("html, body").delay(delay).animate({
        scrollTop: $(container).offset().top 
    }, delay);
}

function markAsBestAnswer(answer_id){
	console.log("best : " + answer_id);
	//TODO mark as best answer
}

function searchQuestion(user_id){
	var url = "/users/" + user_id + "/questions";
	var search_by = $("#search_by").val();
	var description = $("#description").val();
	$.get(url,{search_by:search_by,description:description},function(response){
			if(response.length){
				questions = response;
				setupChart();
			} else {
				alert("Questions not found, check your search.");
			}
	});
}

function setupChartNavigation(options){
	$("#chart_nav").html('');
	if(questions.length > QUESTION_PER_PAGE){
		for(var i = 0; i < questions.length; i += QUESTION_PER_PAGE){
				var number_questions = QUESTION_PER_PAGE;
		  	if((i + QUESTION_PER_PAGE) > questions.length){
		  		number_questions = questions.length - i;
		  	}
		  	var index = i/QUESTION_PER_PAGE;
		  	options = new ChartOption(i+1,i+number_questions,questions.length);
		  	var label = i == 0? "first" : "next";
		  	$("#chart_nav").append(navButton(label,index,options));
		}
	}
}

function navButton(label,index,options){
	options = JSON.stringify(options);
	var action = "drawChart("+index+","+options.replace(/\"/g,"'") +")";
	
	var html = "<span class='input-group-btn input-group-addon'>";
	html += "<button type='button' class='btn btn-default' ";
	html += " onClick=\"";
	html +=	 action + "\">";
	html += label + "</button>"
	html += "</span>";
	return html;
}

function searchAllQuestionsBy(){
	var search_by = $("#search_by").val();
	var description = $("#description").val();
	var url = "/?search_by=" + search_by + "&description=" + description;
	window.location = url;
}

