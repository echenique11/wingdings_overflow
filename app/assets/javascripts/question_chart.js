function loadGApi(){
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(setupChart);	
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
  var options = new ChartOption(1,number_questions,questions.length);
  setupChartNavigation(options);
  drawChart(0,options);
}

var ChartOption = function(from,to,total){
	this.title = 'Displying questions ' + from + '-' + to +' / ' + total;
	this.vAxis = {title: ""};
	this.hAxis = {title: "Questions"};
	this.seriesType = "bars";
	this.series = {5: {type: "line"}};

}
function drawChart(index,options){
	var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	chart.draw(questions_data[index], options);
}

function searchQuestion(user_id){
	var url = "/users/" + user_id + "/questions";
	var search_by = $("#search_by").val();
	var description = $("#description").val();
	$.post(url,{search_by:search_by,description:description},function(response){
			if(response.length){
				questions = response;
				setupChart();
			} else {
				alert("Questions not found, check your search.");
			}
	});
}

function setupChartNavigation(options){
	if(questions.length > 5){
		for(var i = 0; i < questions.length; i += 5){
				var number_questions = 5;
		  	if((i + 5) > questions.length){
		  		number_questions = questions.length - i;
		  	}
		  	var index = i/5;
		  	options = new ChartOption(i+1,i+number_questions,questions.length);
		  	var label = i == 0? "first" : "next";
		  	$("#chart_nav").append(navButton(label,index,options));
		}
	}
}

function navButton(label,index,options){
	options = JSON.stringify(options);
	var action = "drawChart("+index+","+options.replace(/\"/g,"'") +")";
	var html = "<input type='button' value='";
	html += label + "' onClick=\"";
	html +=	 action + "\"/>";
	return html;
}

