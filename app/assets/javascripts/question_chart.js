function loadGApi(){
	// $.getScript("https://www.google.com/jsapi", function(){
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(setupChart);
	// });	
}

function setupChart() {
  questions_data = [];
  for( var i = 0; i < questions.length; i += 5 ){
  		
  	var number_questions = 5;
  	if((i + 5) > questions.length){
  		number_questions = questions.length - i;
  	}
	
	var array_data = []
	var questions_headers = ['Questions','Answers','Comments','Votes','Karma']
	array_data.push(questions_headers);
	for(var j = 0; j < number_questions; j++){
		var actual_question = questions[i + j];
		console.log(actual_question);
		var question_data = [actual_question.title,
			parseInt(actual_question.answers),
			parseInt(actual_question.comments),
			parseInt(actual_question.votes),
			parseInt(actual_question.karma)];
		array_data.push(question_data);
	}
	var index = i/5;
	questions_data[index] = google.visualization.arrayToDataTable(array_data);
	
  } 
  
  var options = {
	    title : 'Displying questions 1-' + number_questions +' / ' + questions.length,
	    vAxis: {title: ""},
	    hAxis: {title: "Questions"},
	    seriesType: "bars",
	    series: {5: {type: "line"}}
	  };
  drawChart(0,options);
}

function drawChart(index,options){
	var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	chart.draw(questions_data[index], options);
}

function searchQuestion(user_id){
	var url = "/users/" + user_id + "/questions"
	var search_by = $("#search_by").val();
	var description = $("#description").val();
	console.log(search_by + description);
	$.post(url,{search_by:search_by,description:description},function(response){
			if(response.length){
				questions = response;
				setupChart();
			} else {
				alert("Questions not found, check your search.");
			}
	});

}