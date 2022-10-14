<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/jsp/azure/cmmn/header.jsp" %>

	<main id="main" class="main">
		<section class="section dashboard">
			<div class="row">
				<div>
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<!-- No Labels Form -->
								<form class="row g-3" id="ListForm" name="ListForm" method="post">
									<input type="hidden" id="customerName" name="customerName" value="${params.customerName }" />
									<input type="hidden" id="resourceTypeValue" name="resourceTypeValue" value="${params.resourceTypeValue }" />
									<input type="hidden" id="resourceGroupValue" name="resourceGroupValue" value="${params.resourceGroupValue }" />
									<input type="hidden" id="resourceValue" name="resourceValue" value="${params.resourceValue }" />
									<input type="hidden" id="FilterTitleValue" name="FilterTitleValue" value="${params.FilterTitleValue }" />
									
									<div class="col-md-3">
										<select id="inputState" class="form-select" onchange="javascript:resourceTypeChg(this);">
											<option <c:if test="${params.resourceTypeValue eq '' || params.resourceTypeValue eq null }">selected="selected"</c:if>>ResourceType Selected...</option>
											<c:forEach items="${resourceType }" varStatus="status" var="result">
												<option <c:if test="${result.resourceType eq params.resourceTypeValue}">selected="selected"</c:if>>${result.resourceType }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-md-3">
										<select id="inputResourceGroup" class="form-select" onchange="javascript:resourceGroupChg(this);">
											<option <c:if test="${params.resourceGroupValue eq '' || params.resourceGroupValue eq null }">selected="selected"</c:if>>ResourceGroup Selected...</option>
											<c:forEach items="${resource }" varStatus="status" var="result">
												<option <c:if test="${result.resourceGroup eq params.resourceGroupValue}">selected="selected"</c:if>>${result.resourceGroup }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-md-3">
										<select id="inputResource" class="form-select" onchange="javascript:resourceChg(this);">
											<option <c:if test="${params.resourceValue eq '' || params.resourceValue eq null }">selected="selected"</c:if>>Resource Selected...</option>
											<c:forEach items="${resource }" varStatus="status" var="result">
												<option <c:if test="${result.resourceName eq params.resourceValue}">selected="selected"</c:if>>${result.resourceName }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-md-2">
										<button type="reset" class="btn btn-secondary" onclick="javascript:searchList();">Search</button>
									</div>
									<div class="col-md-1">
										<img src="/assets/img/report.png" style="width: 40px; height: 38px; cursor: pointer;" onclick="javascript:reportView();" alt="" data-bs-toggle="tooltip" data-bs-placement="top" title="보고서">
									</div>
									
								</form><!-- End No Labels Form -->
							</div>
						</div>
					</div>
				</div>

				<!--Top -->
				
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body" id="canvas_container">
							<h5 class="card-title">실시간 Chart</h5>
							<!-- Bar Chart -->
							<canvas id="barChart" style="max-height: 300px; min-height: 100px;"></canvas>
							<!-- End Bar CHart -->
						</div>
					</div>
				</div>
				
				<div class="col-lg-12" style="height: 50px;">
					<div class="card" style="margin-bottom: 0px;">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown">
								<i class="bi bi-three-dots"></i>
							</a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Filter</h6>
								</li>
								<li><a class="dropdown-item" href="javascript:filterChg('Weekly');">Weekly</a></li>
								<li><a class="dropdown-item" href="javascript:filterChg('Month');">Month</a></li>
								<li><a class="dropdown-item" href="javascript:filterChg('3 Month');">3 Month</a></li>
								<li><a class="dropdown-item" href="javascript:filterChg('6 Month');">6 Month</a></li>
							</ul>
						</div>
						<div class="card-body">
							<h5 class="card-title" id="FilterTitle">${params.FilterTitleValue }</h5>
						</div>
					</div>
				</div>
				
				<!-- Sales Card1 -->
				<div class="col-xxl-auto col-md-auto sb">
					<div class="card info-card sales-card">
						<div class="card-body">
							<h5 class="card-title">
								 <span>Metrics</span>
							</h5>
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<img src="/assets/img/Metrics.svg" style="width: 32px; height: 32px;" alt="">
								</div>
								<div>
								<!-- <div class="ps-3"> -->
									<h6>${metriceCnt }</h6>
									<span class="text-success small pt-1 fw-bold">${metricePercent }%</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Sales Card1 -->

				<!-- Sales Card2 -->
				<div class="col-xxl-auto col-md-auto sb">
					<div class="card info-card sales-card">
						<div class="card-body">
							<h5 class="card-title">
								 <span>Logs</span>
							</h5>
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<img src="/assets/img/logs.svg" style="width: 32px; height: 32px;" alt="">
								</div>
								<div>
									<h6>${logsCnt }</h6>
									<span class="text-success small pt-1 fw-bold">${logsPercent }%</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Sales Card2 -->

				<!-- Sales Card3 -->
				<div class="col-xxl-auto col-md-auto sb">
					<div class="card info-card sales-card">

						<div class="card-body">
							<h5 class="card-title">
								<span>Activity log</span>
							</h5>

							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<img src="/assets/img/Activity-Log.svg" style="width: 32px; height: 32px;" alt="">
								</div>
								<div>
									<h6>${activityCnt }</h6>
									<span class="text-success small pt-1 fw-bold">${activityPercent }%</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Sales Card3 -->

				<!-- Sales Card4 -->
				<div class="col-xxl-auto col-md-auto sb">
					<div class="card info-card sales-card">
						<div class="card-body">
							<h5 class="card-title">
								<span>Resource health</span>
							</h5>
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<img src="/assets/img/resource-health.svg" style="width: 32px; height: 32px;" alt="">
								</div>
								<div>
									<h6>${resourceCnt }</h6>
									<span class="text-success small pt-1 fw-bold">${resourcePercent }%</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Sales Card4 -->

				<!-- Sales Card5 -->
				<div class="col-xxl-auto col-md-auto sb">
					<div class="card info-card sales-card">
						<div class="card-body">
							<h5 class="card-title">
								<span>Service health</span>
							</h5>
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<img src="/assets/img/service-health.svg" style="width: 32px; height: 32px;" alt="">
								</div>
								<div>
									<h6>${serviceCnt }</h6>
									<span class="text-success small pt-1 fw-bold">${servicePercent }%</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Sales Card5 -->

				<!-- Graph -->
				<div>
					<!-- Graph1 -->
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">
									이벤트 현황
								</h5>
								<!-- Line Chart -->
								<div id="reportsChart"></div>
								
								<%
									List<Map<String, Object>> metriceList = (List<Map<String, Object>>) request.getAttribute("metriceList");
									List<Map<String, Object>> logsList = (List<Map<String, Object>>) request.getAttribute("logsList");
									List<Map<String, Object>> activityList = (List<Map<String, Object>>) request.getAttribute("activityList");
									List<Map<String, Object>> resourceList = (List<Map<String, Object>>) request.getAttribute("resourceList");
									List<Map<String, Object>> serviceList = (List<Map<String, Object>>) request.getAttribute("serviceList");
									List<Map<String, Object>> dayList = (List<Map<String, Object>>) request.getAttribute("dayList");
									List<Map<String, Object>> resourceTypeList = (List<Map<String, Object>>) request.getAttribute("resourceTypeList");
									
									boolean bool = false;
								%>
								<script>
								document.addEventListener("DOMContentLoaded", () => {
									  new ApexCharts(document.querySelector("#reportsChart"), {
									    series: [{
									      name: 'Metrics',
									      data: [
								<%
												for(int i=0; i<dayList.size(); i++){
													for(int j=0; j<metriceList.size(); j++){
														if(dayList.get(i).get("days").toString().equals(metriceList.get(j).get("date").toString())){
															bool = true;
								%>
															<%=metriceList.get(j).get("cnt")%>,
								<%
															break;
														}
													}
													if(bool){
														bool = false;
													}else{
								%>
														0,
								<%
													}
												}
								%>									    	  
									    	  ]
									    }, {
									      name: 'Logs',
									      data: [
								<%
												for(int i=0; i<dayList.size(); i++){
													for(int j=0; j<logsList.size(); j++){
														if(dayList.get(i).get("days").toString().equals(logsList.get(j).get("date").toString())){
															bool = true;
								%>
															<%=logsList.get(j).get("cnt")%>,
								<%
															break;
														}
													}
													if(bool){
														bool = false;
													}else{
								%>
														0,
								<%
													}
												}
								%>	
									    	  ]
									    }, {
									      name: 'Activity log',
									      data: [
								<%
												for(int i=0; i<dayList.size(); i++){
													for(int j=0; j<activityList.size(); j++){
														if(dayList.get(i).get("days").toString().equals(activityList.get(j).get("date").toString())){
															bool = true;
								%>
															<%=activityList.get(j).get("cnt")%>,
								<%
															break;
														}
													}
													if(bool){
														bool = false;
													}else{
								%>
														0,
								<%
													}
												}
								%>
									    	  ]
									    }, {
									        name: 'Resource Health',
									        data: [
								<%
												for(int i=0; i<dayList.size(); i++){
													for(int j=0; j<resourceList.size(); j++){
														if(dayList.get(i).get("days").toString().equals(resourceList.get(j).get("date").toString())){
															bool = true;
								%>
															<%=resourceList.get(j).get("cnt")%>,
								<%
															break;
														}
													}
													if(bool){
														bool = false;
													}else{
								%>
														0,
								<%
													}
												}
								%>
									          ]
									      }, {
									        name: 'Service health',
									        data: [
								<%
												for(int i=0; i<dayList.size(); i++){
													for(int j=0; j<serviceList.size(); j++){
														if(dayList.get(i).get("days").toString().equals(serviceList.get(j).get("date").toString())){
															bool = true;
								%>
															<%=serviceList.get(j).get("cnt")%>,
								<%
															break;
														}
													}
													if(bool){
														bool = false;
													}else{
								%>
														0,
								<%
													}
												}
								%>
									           ]
									      },],
									    chart: {
									      height: 300,
									      type: 'area',
									      toolbar: {
									        show: false
									      },
									      events: {
									         click(event, chartContext, config) {
									            lineChartModal(config.seriesIndex, config.dataPointIndex);
									          }
									        }
									    },
									    markers: {
									      size: 4
									    },
									    colors: ['#4154f1', '#2eca6a', '#ff771d', '#ff4560', '#775dd0'],
									    fill: {
									      type: "gradient",
									      gradient: {
									        shadeIntensity: 1,
									        opacityFrom: 0.3,
									        opacityTo: 0.4,
									        stops: [0, 90, 100]
									      }
									    },
									    dataLabels: {
									      enabled: true,
									    },
									    stroke: {
									      curve: 'smooth',
									      width: 2
									    },
									    xaxis: {
									      categories: [
								<%
												for(int i=0; i<dayList.size(); i++){
								%>
													"<%=dayList.get(i).get("days").toString()%>",
								<%
												}
								%>
									    	],
									    	labels: {
										          show: false,
										      },
										      axisBorder: {
										          show: true,
										          color: '#78909C',
										          height: 1,
										          width: '100%',
										          offsetX: 0,
										          offsetY: 0
										      },
									    },
									    tooltip: {
									      x: {
									        format: 'yyyy-MM-dd'
								      		},
								    	}
								  }).render();
								});
								</script>								
								<!-- End Line Chart -->
							</div>
						</div>
					</div>
					<!-- Graph1 end -->

					<!-- Graph2 -->
					<div class="col-12">
						<div class="card">
							<div class="card-body" id="canvas_piecontainer">
								<h5 class="card-title">리소스 별 이벤트 현황</h5>
								<div id="pieChart"></div>
								<%-- <canvas id="pieChart" style="max-height: 300px; min-height: 100px;"></canvas> --%>
								<script>
			                    document.addEventListener("DOMContentLoaded", () => {
			                    new ApexCharts(document.querySelector("#pieChart"), {
			                        series: [
			         <%
			                       		for(int i=0; i<resourceTypeList.size(); i++){
			                       			if(resourceTypeList.get(i).get("resourceType") != null){
			         %>
			         							<%=resourceTypeList.get(i).get("cnt")%>,
			         <%
			                       			}
			                       		}
			         %>
			                        	],
			                        chart: {
			                          height: 350,
			                          type: 'pie',
			                          toolbar: {
			                            show: false
			                          },
			                          events: {
			                        	  dataPointSelection: function (event, chartContext, config) {
			                        		  pieChartModal(config.dataPointIndex)
			                        	  }
			                          }
			                        },
			                        labels: [
			         <%
			                       		for(int i=0; i<resourceTypeList.size(); i++){
			                       			if(resourceTypeList.get(i).get("resourceType") != null){
			         %>
			         							'<%=resourceTypeList.get(i).get("resourceType")%>',
			         <%
			                       			}
			                       		}
			         %>
			                        	]
			                      }).render();
			                    });
			                  </script>
							</div>
						</div>
					</div>
					<!-- Graph2 end -->
				</div>
				<!-- end Graph -->
			</div>
		</section>
	</main>
	<!-- End #main -->

	<%@include file="/WEB-INF/jsp/azure/cmmn/footer.jsp"%>

<script>
function customerList(name){
	$("#customerName").val(name);
	$("#resourceTypeValue").val("");
	$("#resourceValue").val("");
	$("#ListForm").attr("action", "/azure/mainList.htm");
	$("#ListForm").submit();
}

function searchList(){
	$("#ListForm").attr("action", "/azure/mainList.htm");
	$("#ListForm").submit();
}

function resourceTypeChg(obj){
	if(obj.value == "ResourceType Selected..."){
		$("#resourceTypeValue").val(null);
		$("#resourceGroupValue").val(null);
		$("#resourceValue").val(null);
	}else{
		$("#resourceTypeValue").val(obj.value);
		
		var formData = new FormData();
		
		formData.append("resourceTypeValue", obj.value);
		formData.append("customerName", $("#customerName").val());
		
		$.ajax('/azure/mainResourceGroup.htm',{
			method: 'POST',
			enctype: 'multipart/form-data',
	        data: formData,
	        processData: false,
	        contentType: false,
			error: function(xhr, status, error){
				alert("데이터 요청에 실패했습니다.");
			},
			success: function(json){
				if(json.result == "success"){
					$("#inputResourceGroup").empty();
					
					var html = "";
					html += '<option <c:if test="${params.resourceGroupValue eq '' || params.resourceGroupValue eq null }">selected="selected"</c:if>>ResourceGroup Selected...</option>';
					
					$.each(json.resourceGroup, function(index, item){
						html += '<option <c:if test="${' + item.resourceGroup + 'eq params.resourceGroupValue}">selected="selected"</c:if>>' + item.resourceGroup + '</option>';
					});
					
					$("#inputResourceGroup").append(html);
				}
			}
		});
	}
}

function resourceGroupChg(obj){
	if(obj.value == "ResourceGroup Selected..."){
		$("#resourceGroupValue").val(null);
		$("#resourceValue").val(null);
	}else{
		$("#resourceGroupValue").val(obj.value);
		
		var formData = new FormData();
		
		formData.append("resourceGroupValue", obj.value);
		formData.append("resourceTypeValue", $("#resourceTypeValue").val());
		formData.append("customerName", $("#customerName").val());
		
		$.ajax('/azure/mainResource.htm',{
			method: 'POST',
			enctype: 'multipart/form-data',
	        data: formData,
	        processData: false,
	        contentType: false,
			error: function(xhr, status, error){
				alert("데이터 요청에 실패했습니다.");
			},
			success: function(json){
				if(json.result == "success"){
					$("#inputResource").empty();
					
					var html = "";
					html += '<option <c:if test="${params.resourceValue eq '' || params.resourceValue eq null }">selected="selected"</c:if>>Resource Selected...</option>';
					
					$.each(json.resource, function(index, item){
						html += '<option <c:if test="${' + item.resourceName + 'eq params.resourceValue}">selected="selected"</c:if>>' + item.resourceName + '</option>';
					});
					
					$("#inputResource").append(html);
				}
			}
		});
	}
}

function resourceChg(obj){
	if(obj.value == "Resource Selected..."){
		$("#resourceValue").val(null);
	}else{
		$("#resourceValue").val(obj.value);
	}
}

function filterChg(name){
	$("#FilterTitleValue").val(name);
	$("#ListForm").attr("action", "/azure/mainList.htm");
	$("#ListForm").submit();
}

function reportView(){
	$("#ListForm").attr("action", "/azure/reportList.htm");
	$("#ListForm").submit();
}

// bar chart
var config = {
	type: 'bar', // [차트 타입 지정]
	data: {
		labels: ['Metrics', 'Logs', 'Activity log', 'Resource health', 'service health'], // [데이터 라벨 (제목)]
		datasets: [{
			label: '# 건 수', // [데이터 시트 제목]
			data: [${metriceRealTimeCnt}, ${logsRealTimeCnt}, ${activityRealTimeCnt}, ${resourceRealTimeCnt}, ${serviceRealTimeCnt}], // [데이터 : Red ~ Orange]
			backgroundColor: [ // [막대 배경 색상 ]
				'rgba(255, 99, 132, 0.2)',
				'rgba(255, 159, 64, 0.2)',
				'rgba(255, 205, 86, 0.2)',
				'rgba(75, 192, 192, 0.2)',
				'rgba(54, 162, 235, 0.2)'
			],
			borderColor: [ // [막대 테두리 색상 ]
				'rgb(255, 99, 132)',
				'rgb(255, 159, 64)',
				'rgb(255, 205, 86)',
				'rgb(75, 192, 192)',
				'rgb(54, 162, 235)'
			],
			borderWidth: 1 // [막대 테두리 굵기 설정]
		}]
	},
	options: {
		scales: {
			y: { // [y 축 관련 설정]
			},
			x: { // [x 축 관련 설정]
			}
		},
		onClick: function (e) {
           /* debugger;  */
           var activePoint = this.getElementsAtEvent(e)[0];
           
           if (activePoint !== undefined) {
               var title = this.data.labels[activePoint._index];
               
               realChartModal(title);
           }
       }
	}
}

/* [html 최초 로드 및 이벤트 상시 대기 실시] */
window.onload = function() {
	/* [캔버스 크기 지정 함수 호출] */
	canvasSizeCheck();

	/* [bar 세로 막대 : 그리기 실시] */
	drawBarHeight();
};

/* [html 화면 사이즈 변경 이벤트 감지] */
window.onresize = function() {
	/* [캔버스 크기 지정 함수 호출] */
	canvasSizeCheck();

	/* [bar 세로 막대 : 그리기 실시] */    		    		
	drawBarHeight();
};

/* [차트 그리기에 사용할 전역 변수 지정 실시] */
// bar chart 
var canvas;
var ctx;
var height = "";
var width = "";
var chart;

/* [캔버스 크기 지정 실시] */
function canvasSizeCheck(){
	// [캔버스를 포함하고 있는 상위 부모 컨테이너 id 지정 >> 부모 컨테이너 크기에 맞춰서 캔버스 리사이즈]
	var tagId = document.getElementById("canvas_container");

	height = window.getComputedStyle(tagId).height;
	width = window.getComputedStyle(tagId).width;

	// [화면 사이즈가 변경된 경우 기존 차트 삭제 실시]
	if(ctx != null){
		canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);
		ctx.beginPath();
		chart.destroy();
	}
};

/* [bar 세로 막대 : 그리기 함수] */
function drawBarHeight(){
	// [body 에 선언된 캔버스 id 지정 실시]
	canvas = document.getElementById('barChart');
	ctx = canvas.getContext('2d');

	// [캔버스 크기를 부모 컨테이너 크기에 맞춥니다 : 부모 크기 % 지정 (반응형)]
	canvas.height = height;
	canvas.width = width;

	// [차트 그리기 실시]
	chart = new Chart(ctx, config);
};

function init(){
	setInterval(() => {
		const datasets = config.data.datasets;
		const data = datasets[0].data;
		
		var formData = new FormData();
		
		formData.append("resourceTypeValue", $("#resourceTypeValue").val());
		formData.append("resourceGroupValue", $("#resourceGroupValue").val());
		formData.append("resourceValue", $("#resourceValue").val());
		formData.append("customerName", $("#customerName").val());
		
		$.ajax('/azure/mainRealTimeChart.htm',{
			method: 'POST',
			enctype: 'multipart/form-data',
			data: formData,
	        processData: false,
	        contentType: false,
			error: function(xhr, status, error){
				alert("데이터 요청에 실패했습니다.");
			},
			success: function(json){
				if(json.result == "success"){
					data[0] = json.metriceRealTimeCnt;
					data[1] = json.logsRealTimeCnt;
					data[2] = json.activityRealTimeCnt;
					data[3] = json.resourceRealTimeCnt;
					data[4] = json.serviceRealTimeCnt;
					
					chart.update();
				}
			}
		});
		
	}, 60000);
}

function realChartModal(title){
	
	var formData = new FormData();
	
	formData.append("resourceTypeValue", $("#resourceTypeValue").val());
	formData.append("resourceGroupValue", $("#resourceGroupValue").val());
	formData.append("resourceValue", $("#resourceValue").val());
	formData.append("customerName", $("#customerName").val());
	formData.append("eventType", title);
	
	$.ajax('/azure/mainRealChartModalList.htm',{
		method: 'POST',
		enctype: 'multipart/form-data',
		data: formData,
        processData: false,
        contentType: false,
		error: function(xhr, status, error){
			alert("데이터 요청에 실패했습니다.");
		},
		success: function(json){
			if(json.result == "success"){
				
				$("#chartModal").remove();
				var html = "";
				
				html += '<div class="modal fade" id="chartModal" tabindex="-1"><div class="modal-dialog modal-xl modal-dialog-scrollable">';
				html += '<div class="modal-content"><div class="modal-header"><h6 class="modal-title">' + title + '</h6>';
				html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>';
				html += '<div class="modal-body" style="height: 400px; padding-top: 0px;"><table class="table" id="tableModal" style="font-size: 13px;"><thead><tr style="text-align: center;"><th scope="col">no</th>';
				html += '<th scope="col">resource_type</th><th scope="col">resource_group</th><th scope="col">resource_name</th><th scope="col">status_info</th><th scope="col" style="width: 130px;">date</th>';
				html += '</tr></thead><tbody>';
				
				$.each(json.realChartList, function(index, item){
					html += '<tr><td>' + (index+1) + '</td><td>' + item.resourceType + '</td><td>' + item.resourceGroup + '</td><td>' + item.resourceName + '</td><td>' + item.statusInfo + '</td><td>' + item.date + '</td></tr>';
				});
				
				html += '</tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>';
				html += '<button type="button" class="btn btn-primary">Save changes</button></div></div></div></div>';
				
				$("#body").append(html);
				
				$("#chartModal").modal("show");
			}
		}
	});
};

function lineChartModal(id, no){
	if(id != -1){
		var formData = new FormData();
		
		formData.append("resourceTypeValue", $("#resourceTypeValue").val());
		formData.append("resourceGroupValue", $("#resourceGroupValue").val());
		formData.append("resourceValue", $("#resourceValue").val());
		formData.append("customerName", $("#customerName").val());
		formData.append("FilterTitleValue", $("#FilterTitleValue").val());
		formData.append("id", id);
		formData.append("no", no);
		
		$.ajax('/azure/mainLineChartModalList.htm',{
			method: 'POST',
			enctype: 'multipart/form-data',
			data: formData,
	        processData: false,
	        contentType: false,
			error: function(xhr, status, error){
				alert("데이터 요청에 실패했습니다.");
			},
			success: function(json){
				if(json.result == "success"){
					$("#chartModal").remove();
					var html = "";
					
					html += '<div class="modal fade" id="chartModal" tabindex="-1"><div class="modal-dialog modal-xl modal-dialog-scrollable">';
					html += '<div class="modal-content"><div class="modal-header"><h6 class="modal-title">' + json.title + '</h6>';
					html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>';
					html += '<div class="modal-body" style="height: 400px; padding-top: 0px;"><table class="table" id="tableModal" style="font-size: 13px;"><thead><tr style="text-align: center;"><th scope="col">no</th>';
					html += '<th scope="col">resource_type</th><th scope="col">resource_group</th><th scope="col">resource_name</th><th scope="col">status_info</th><th scope="col" style="width: 130px;">date</th>';
					html += '</tr></thead><tbody>';
					
					$.each(json.mainLineChartList, function(index, item){
						html += '<tr><td>' + (index+1) + '</td><td>' + item.resourceType + '</td><td>' + item.resourceGroup + '</td><td>' + item.resourceName + '</td><td>' + item.statusInfo + '</td><td>' + item.date + '</td></tr>';
					});
					
					html += '</tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>';
					html += '<button type="button" class="btn btn-primary">Save changes</button></div></div></div></div>';
					
					$("#body").append(html);
					
					$("#chartModal").modal("show");
				}
			}
		});
	}
}

function pieChartModal(no){
	
	var formData = new FormData();
	
	formData.append("resourceTypeValue", $("#resourceTypeValue").val());
	formData.append("resourceGroupValue", $("#resourceGroupValue").val());
	formData.append("resourceValue", $("#resourceValue").val());
	formData.append("customerName", $("#customerName").val());
	formData.append("FilterTitleValue", $("#FilterTitleValue").val());
	formData.append("no", no);
	
	$.ajax('/azure/mainPieChartModalList.htm',{
		method: 'POST',
		enctype: 'multipart/form-data',
		data: formData,
        processData: false,
        contentType: false,
		error: function(xhr, status, error){
			alert("데이터 요청에 실패했습니다.");
		},
		success: function(json){
			if(json.result == "success"){
				
				$("#chartModal").remove();
				var html = "";
				
				html += '<div class="modal fade" id="chartModal" tabindex="-1"><div class="modal-dialog modal-xl modal-dialog-scrollable">';
				html += '<div class="modal-content"><div class="modal-header"><h6 class="modal-title">' + json.title + '</h6>';
				html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>';
				html += '<div class="modal-body" style="height: 400px; padding-top: 0px;"><table class="table" id="tableModal" style="font-size: 13px;"><thead><tr style="text-align: center;"><th scope="col">no</th>';
				html += '<th scope="col">resource_type</th><th scope="col">resource_group</th><th scope="col">resource_name</th><th scope="col">status_info</th><th scope="col" style="width: 130px;">date</th>';
				html += '</tr></thead><tbody>';
				
				$.each(json.mainPieChartList, function(index, item){
					html += '<tr><td>' + (index+1) + '</td><td>' + item.resourceType + '</td><td>' + item.resourceGroup + '</td><td>' + item.resourceName + '</td><td>' + item.statusInfo + '</td><td>' + item.date + '</td></tr>';
				});
				
				html += '</tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>';
				html += '<button type="button" class="btn btn-primary">Save changes</button></div></div></div></div>';
				
				$("#body").append(html);
				
				$("#chartModal").modal("show");
			}
		}
	});
}

init();

</script>

</html>

