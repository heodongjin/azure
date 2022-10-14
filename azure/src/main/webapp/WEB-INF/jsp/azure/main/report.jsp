<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/jsp/azure/cmmn/header.jsp" %>

	<main id="main" class="main">
		<section class="section dashboard">
			<div>
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body" style="padding-top: 20px;">
							<!-- No Labels Form -->
							<form class="row g-3" id="ListForm" name="ListForm" method="post">
								<input type="hidden" id="customerName" name="customerName" value="${params.customerName }" />
								<input type="hidden" id="FilterTitleValue" name="FilterTitleValue" value="${params.FilterTitleValue }" />
								<input type="hidden" id="imgData" name="imgData" />
								
								<div class="col-md-3">
									<select id="inputState" class="form-select" onchange="javascript:reportTypeChg(this);">
										<option <c:if test="${params.FilterTitleValue eq 'Weekly'}">selected="selected"</c:if> value="Weekly">주간 보고서</option>
										<option <c:if test="${params.FilterTitleValue eq 'Month'}">selected="selected"</c:if> value="Month">월간 보고서</option>
										<option <c:if test="${params.FilterTitleValue eq '3 Month'}">selected="selected"</c:if> value="3 Month">분기 보고서</option>
										<option <c:if test="${params.FilterTitleValue eq '6 Month'}">selected="selected"</c:if> value="6 Month">반기 보고서</option>
									</select>
								</div><!-- 
								<div class="col-md-2">
									<button type="reset" class="btn btn-secondary" onclick="javascript:searchList();">Search</button>
								</div> -->
								<div class="col-md-9" style="text-align: right;">
									<img src="/assets/img/dashboard.png" style="width: 40px; height: 38px; cursor: pointer;" onclick="javascript:mainView();" alt="" data-bs-toggle="tooltip" data-bs-placement="top" title="메인화면">
									<img src="/assets/img/download.png" style="width: 40px; height: 38px; cursor: pointer;" id="btnDown" alt="" data-bs-toggle="tooltip" data-bs-placement="top" title="다운로드">
								</div>
								
							</form><!-- End No Labels Form -->
						</div>
					</div>
				</div>
			</div>
			<div id="printDiv">
			<!-- Graph1 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">All Event Status</h5>
						<div id="lineChart">
						
						<%
							List<Map<String, Object>> allEventList = (List<Map<String, Object>>) request.getAttribute("allEventList");
							List<Map<String, Object>> regionEventTopList = (List<Map<String, Object>>) request.getAttribute("regionEventTopList");
							List<Map<String, Object>> metriceList = (List<Map<String, Object>>) request.getAttribute("metriceList");
							List<Map<String, Object>> logsList = (List<Map<String, Object>>) request.getAttribute("logsList");
							List<Map<String, Object>> activityList = (List<Map<String, Object>>) request.getAttribute("activityList");
							List<Map<String, Object>> resourceList = (List<Map<String, Object>>) request.getAttribute("resourceList");
							List<Map<String, Object>> serviceList = (List<Map<String, Object>>) request.getAttribute("serviceList");
							List<Map<String, Object>> dayList = (List<Map<String, Object>>) request.getAttribute("dayList");
							
							boolean bool = false;
						%>
							<script>
								document.addEventListener("DOMContentLoaded", () => {
									new ApexCharts(document.querySelector("#lineChart"), {
										series: [{
										name: "All Event Count",
										data: [
							<%
											for(int i=0; i<dayList.size(); i++){
												for(int j=0; j<allEventList.size(); j++){
													if(dayList.get(i).get("days").toString().equals(allEventList.get(j).get("date").toString())){
														bool = true;
							%>
														<%=allEventList.get(j).get("cnt")%>,
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
										}],
										chart: {
									      height: 300,
									      type: 'area',
									      toolbar: {
									        show: false
									      }
									    },
									    markers: {
									      size: 4
									    },
									    colors: ['#4154f1'],
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
						</div>
					</div>
				</div>
			</div>
			<!-- Graph1 end -->
			
			<!-- Graph2 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">
							Status By Event Type
						</h5>
						<div id="reportsChart"></div>
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
								      },],
								chart: {
								height: 350,
								type: 'area',
								toolbar: {
									show: false
								},
								},
								markers: {
								size: 4
								},
								colors: ['#4154f1', '#2eca6a', '#ff771d', '#ff4560'],
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
								enabled: true
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
					</div>
				</div>
			</div>
			<!-- Graph2 end -->
			
			<!-- start #table1 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
					<h5 class="card-title">Top 5 Events</h5>
						<table id="myTable" class="table table-striped">
							<thead>
								<tr style="text-align: center;">
									<th scope="col" data-sortable="" style="width: 25%;">Event</th>
									<th scope="col" data-sortable="" style="width: 15%;">Resource Type</th>
									<th scope="col" data-sortable="" style="width: 20%;">Resource Group</th>
									<th scope="col" data-sortable="" style="width: 20%;">Resource Name</th>
									<th scope="col" data-sortable="" style="width: 8%;">Count</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${eventTopList }" var="result" varStatus="status">
									<tr>
										<td>${result.statusInfo }</td>
										<td>${result.resourceType }</td>
										<td>${result.resourceGroup }</td>
										<td>${result.resourceName }</td>
										<td style="text-align: center;">${result.cnt }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>						
					</div>
				</div>
			</div>
			<!-- End #table1 -->
			
			<!-- Graph3 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">
							Azure Service Health
						</h5>
						<div id="reportsChart2"></div>
						<script>
							document.addEventListener("DOMContentLoaded", () => {
							new ApexCharts(document.querySelector("#reportsChart2"), {
								series: [{
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
								    }],
								chart: {
								height: 350,
								type: 'area',
								toolbar: {
									show: false
								},
								},
								markers: {
								size: 4
								},
								colors: ['#775dd0'],
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
								enabled: true
								},
								stroke: {
								curve: 'smooth',
								width: 2
								},
								xaxis: {
								categories: [<%
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
					</div>
				</div>
			</div>
			<!-- Graph3 end -->
			
			<!-- start #table2 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
					<h5 class="card-title">Azure Service Health</h5>
						<table id="myTable" class="table table-striped">
							<thead>
								<tr style="text-align: center;">
									<th scope="col" data-sortable="" style="width: 50%;">Event</th>
									<th scope="col" data-sortable="" style="width: 22%;">Region</th>
									<th scope="col" data-sortable="" style="width: 8%;">count</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${serviceHealthEventTopList}" var="result" varStatus="status">
									<tr>
										<td>${result.statusInfo }</td>
										<td>${result.region }</td>
										<td style="text-align: center;">${result.cnt }</td>
									</tr>
								</c:forEach>
								<c:if test="${empty serviceHealthEventTopList }">
									<tr>
										<td colspan="3" style="text-align: center;">데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- End #table2 -->
			
			<!-- Graph4 -->
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Count or Percentage by Region</h5>
						<div id="pieChart" style="min-height: 400px;" class="echart">
						<%
							if(regionEventTopList.size() == 0){
						%>
						<span style="margin-left: 45%;">데이터가 없습니다.</span>
						<%
							}
						%>
						</div>
						
						<%
							if(regionEventTopList.size() > 0){
						%>
		
						<script>
						 document.addEventListener("DOMContentLoaded", () => {
			                    new ApexCharts(document.querySelector("#pieChart"), {
			                        series: [
			         <%
			                       		for(int i=0; i<regionEventTopList.size(); i++){
			                       			if(regionEventTopList.get(i).get("region") != null){
			         %>
			         							<%=regionEventTopList.get(i).get("cnt")%>,
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
			                        },
			                        labels: [
			         <%
			                       		for(int i=0; i<regionEventTopList.size(); i++){
			                       			if(regionEventTopList.get(i).get("region") != null){
			         %>
			         							'<%=regionEventTopList.get(i).get("region")%>',
			         <%
			                       			}
			                       		}
			         %>
			                        	]
			                      }).render();
			                    });
						</script>
					<%
							}
					%>
					</div>
				</div>
			</div>
			<!-- Graph4 end -->
			</div>
		</section>
	</main>
	<!-- End #main -->
	
	<script src="/assets/js/html2canvas.js"></script>

	<%@include file="/WEB-INF/jsp/azure/cmmn/footer.jsp"%>

<script>

function customerList(name){
	$("#customerName").val(name);
	$("#ListForm").attr("action", "/azure/reportList.htm");
	$("#ListForm").submit();
}

function reportTypeChg(obj){
	$("#FilterTitleValue").val(obj.value);
	
	$("#ListForm").attr("action", "/azure/reportList.htm");
	$("#ListForm").submit();
}

function mainView(){
	$("#ListForm").attr("action", "/azure/mainList.htm");
	$("#ListForm").submit();
}

$("#btnDown").click(function(){
	printDiv($("#printDiv"));
});

function printDiv(div){
	div = div[0];
	html2canvas(div, {scale:4}).then(function(canvas){
		var myImage = canvas.toDataURL();
		downloadURI(myImage, "report.png");
	});
}

function downloadURI(uri, name){
	var link = document.createElement("a");
	link.download = name;
	link.href = uri;
	document.body.appendChild(link);
	link.click();
}

</script>

</html>

