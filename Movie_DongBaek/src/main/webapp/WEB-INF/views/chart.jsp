<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
<script>
// 	let labels = [];
// 	let rate = [];
// 	let pieChartData = "";
	
// 	window.onload = function () {
// 		pieChartDraw();
// 	}

// 	$(function(){
// 		$.ajax({
//             type : "post", 
//             url : "ChartSixUp", 
//             dataType : "json", 
//          })
//          .done(function(chartSixUp) {
            
//             for(let i = 0; i < chartSixUp.length; i++){
//                labels.push(chartSixUp[i].movie_genre);
//                rate.push(chartSixUp[i].rate);
//             }
//             console.log(labels);
//             console.log(rate);
                        
//          })
//          .fail(function() { // 요청 실패 시
//            alert("요청 실패!");
//          });

	
// 	pieChartData = {
// 	    labels: labels,
// 	    datasets: [{
// 	        data: [rate],
// 	        backgroundColor: ['rgb(255, 99, 132)', 'rgb(255, 159, 64)']
// 	    }] 
// 	};
	
// 	console.log(labels);
//     console.log(rate);
	
// 	});
	
// // 	let pieChartDraw = functioCn () {
// 	function pieChartDraw(){
		
// 	    let ctx = document.getElementById('pieChartCanvas').getContext('2d');
	    
// 	    window.pieChart = new Chart(ctx, {
// 	        type: 'pie',
// 	        data: pieChartData,
// 	        options: {
// 	            responsive: false
// 	        }
// 	    });
// 	};
	
	$(function(){
    $.ajax({
        type : "post", 
        url : "ChartSixUp", 
        dataType : "json", 
    })
    .done(function(chartSixUp) {
        let labels = [];
        let rate = [];
        let backgroundColor = [];

        for(let i = 0; i < chartSixUp.length; i++){
            labels.push(chartSixUp[i].movie_genre);
            rate.push(chartSixUp[i].rate);
            backgroundColor.push(dynamicColor()); // 색상을 동적으로 생성하는 함수를 추가하세요.
        }

        let pieChartData = {
            labels: labels,
            datasets: [{
                data: rate,
                backgroundColor: backgroundColor
            }] 
        };

        pieChartDraw(pieChartData);
    })
    .fail(function() { // 요청 실패 시
        alert("요청 실패!");
    });
});

function pieChartDraw(pieChartData){
    let ctx = document.getElementById('pieChartCanvas').getContext('2d');
    
    window.pieChart = new Chart(ctx, {
        type: 'pie',
        data: pieChartData,
        options: {
            responsive: false
        }
    });
};

function dynamicColor() {
    const r = Math.floor(Math.random() * 256);
    const g = Math.floor(Math.random() * 256);
    const b = Math.floor(Math.random() * 256);
    return 'rgb(' + r + ', ' + g + ', ' + b + ')';
}

</script>
</head>
<body>
	<div class="chart-div" style="width: 700px;">
		<div class="row">
			<div class="col-6 text-center">
				<span class="mb-3"><b>60세 이상</b></span>
				<canvas id="pieChartCanvas" width="300px" height="300px"></canvas>
			</div>			
		</div>
	</div>
	
</body>
</html>