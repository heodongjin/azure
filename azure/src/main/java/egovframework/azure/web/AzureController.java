package egovframework.azure.web;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.azure.service.AzureService;
import org.egovframe.rte.fdl.property.EgovPropertyService;

@Controller
public class AzureController {

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "azureService")
	private AzureService azureService;
	
	private static Logger logger = Logger.getLogger(AzureController.class.getName());
	
	@RequestMapping(value = "/azure/mainList.htm")
	public String azureMainList(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		logger.info(" ============================= /azure/mainList.htm 진입 params : " + params);
		
		if(params.get("customerName") == null) {
			params.put("customerName", "sldt");
		}
		
		if(params.get("FilterTitleValue") == null) {
			params.put("FilterTitleValue", "Weekly");
		}
		
		double totalCnt = 0;
		int metriceCnt = 0;
		int logsCnt = 0;
		int activityCnt = 0;
		int resourceCnt = 0;
		int serviceCnt = 0;
		
		List<Map<String, Object>> resourceType = azureService.azureMainResourceType(params);
		
		if(params.get("resourceTypeValue") != null) {
			List<Map<String, Object>> resource = azureService.azureMainResource(params);
			model.addAttribute("resource", resource);
		}
		
		List<Map<String, Object>> metriceList = azureService.azureMainMetriceCnt(params);
		List<Map<String, Object>> logsList = azureService.azureMainLogsCnt(params);
		List<Map<String, Object>> activityList = azureService.azureMainActivityCnt(params);
		List<Map<String, Object>> resourceList = azureService.azureMainResourceCnt(params);
		List<Map<String, Object>> serviceList = azureService.azureMainServiceCnt(params);
		List<Map<String, Object>> resourceTypeList = azureService.azureMainResourceTypeCnt(params);
		
		int metriceRealTimeCnt = azureService.azureMainMetriceRealTimeCnt(params);
		int logsRealTimeCnt = azureService.azureMainLogsRealTimeCnt(params);
		int activityRealTimeCnt = azureService.azureMainActivityRealTimeCnt(params);
		int resourceRealTimeCnt = azureService.azureMainResourceRealTimeCnt(params);
		int serviceRealTimeCnt = azureService.azureMainServiceRealTimeCnt(params);
		
		for(int i=0; i<metriceList.size(); i++) {
			totalCnt += Integer.parseInt(metriceList.get(i).get("cnt").toString());
			metriceCnt += Integer.parseInt(metriceList.get(i).get("cnt").toString());
		}
		
		for(int i=0; i<logsList.size(); i++) {
			totalCnt += Integer.parseInt(logsList.get(i).get("cnt").toString());
			logsCnt += Integer.parseInt(logsList.get(i).get("cnt").toString());
		}
		
		for(int i=0; i<activityList.size(); i++) {
			totalCnt += Integer.parseInt(activityList.get(i).get("cnt").toString());
			activityCnt += Integer.parseInt(activityList.get(i).get("cnt").toString());
		}
		
		for(int i=0; i<resourceList.size(); i++) {
			totalCnt += Integer.parseInt(resourceList.get(i).get("cnt").toString());
			resourceCnt += Integer.parseInt(resourceList.get(i).get("cnt").toString());
		}
		
		for(int i=0; i<serviceList.size(); i++) {
			totalCnt += Integer.parseInt(serviceList.get(i).get("cnt").toString());
			serviceCnt += Integer.parseInt(serviceList.get(i).get("cnt").toString());
		}
		
		DecimalFormat frmt = new DecimalFormat("#.##");
		
		String metricePercent = frmt.format(metriceCnt / totalCnt * 100);
		String logsPercent = frmt.format(logsCnt / totalCnt * 100);
		String activityPercent = frmt.format(activityCnt / totalCnt * 100);
		String resourcePercent = frmt.format(resourceCnt / totalCnt * 100);
		String servicePercent = frmt.format(serviceCnt / totalCnt * 100);
		
		LocalDate now = LocalDate.now();
		List<Map<String, Object>> dayList = new ArrayList<Map<String,Object>>();
		
		LocalDate endDate = LocalDate.parse(now.minusDays(1).toString());
		LocalDate startDate;
		
		if(params.get("FilterTitleValue").equals("Weekly")) { 
			startDate = LocalDate.parse(now.minusWeeks(1).toString());
		}else if(params.get("FilterTitleValue").equals("Month")) {
			startDate = LocalDate.parse(now.minusMonths(1).toString());
		}else if(params.get("FilterTitleValue").equals("3 Month")) {
			startDate = LocalDate.parse(now.minusMonths(3).toString());
		}else {
			startDate = LocalDate.parse(now.minusMonths(6).toString());
		}
		
		int cnt = (int) startDate.until(endDate, ChronoUnit.DAYS);
		
		for(int i=0; i<=cnt; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("days", startDate.plusDays(i));
			dayList.add(map);
		}
		
		model.addAttribute("params", params);
		model.addAttribute("resourceType", resourceType);
		model.addAttribute("metriceCnt", metriceCnt);
		model.addAttribute("metricePercent", metricePercent);
		model.addAttribute("metriceList", metriceList);
		model.addAttribute("logsCnt", logsCnt);
		model.addAttribute("logsPercent", logsPercent);
		model.addAttribute("logsList", logsList);
		model.addAttribute("activityCnt", activityCnt);
		model.addAttribute("activityPercent", activityPercent);
		model.addAttribute("activityList", activityList);
		model.addAttribute("resourceCnt", resourceCnt);
		model.addAttribute("resourcePercent", resourcePercent);
		model.addAttribute("resourceList", resourceList);
		model.addAttribute("serviceCnt", serviceCnt);
		model.addAttribute("servicePercent", servicePercent);
		model.addAttribute("serviceList", serviceList);
		model.addAttribute("dayList", dayList);
		model.addAttribute("resourceTypeList", resourceTypeList);
		
		model.addAttribute("metriceRealTimeCnt", metriceRealTimeCnt);
		model.addAttribute("logsRealTimeCnt", logsRealTimeCnt);
		model.addAttribute("activityRealTimeCnt", activityRealTimeCnt);
		model.addAttribute("resourceRealTimeCnt", resourceRealTimeCnt);
		model.addAttribute("serviceRealTimeCnt", serviceRealTimeCnt);
		
		return "main/main";
		
	}
	
	@RequestMapping(value = "/azure/reportList.htm")
	public String azureReportList(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		logger.info(" ============================= /azure/reportList.htm 진입 params : " + params);
		
		if(params.get("customerName") == null) {
			params.put("customerName", "sldt");
		}
		
		if(params.get("FilterTitleValue") == null) {
			params.put("FilterTitleValue", "Weekly");
		}
		
		LocalDate now = LocalDate.now();
		List<Map<String, Object>> dayList = new ArrayList<Map<String,Object>>();
		
		LocalDate endDate = LocalDate.parse(now.minusDays(1).toString());
		LocalDate startDate;
		
		if(params.get("FilterTitleValue").equals("Weekly")) { 
			startDate = LocalDate.parse(now.minusWeeks(1).toString());
		}else if(params.get("FilterTitleValue").equals("Month")) {
			startDate = LocalDate.parse(now.minusMonths(1).toString());
		}else if(params.get("FilterTitleValue").equals("3 Month")) {
			startDate = LocalDate.parse(now.minusMonths(3).toString());
		}else {
			startDate = LocalDate.parse(now.minusMonths(6).toString());
		}
		
		int cnt = (int) startDate.until(endDate, ChronoUnit.DAYS);
		
		for(int i=0; i<=cnt; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("days", startDate.plusDays(i));
			dayList.add(map);
		}
		
		List<Map<String, Object>> allEventList = azureService.azureAllEventListCnt(params);
		List<Map<String, Object>> eventTopList = azureService.azureEventTopList(params);
		List<Map<String, Object>> serviceHealthEventTopList = azureService.azureServiceHealthEventTopList(params);
		List<Map<String, Object>> regionEventTopList = azureService.azureRegionEventTopList(params);
		
		List<Map<String, Object>> metriceList = azureService.azureMainMetriceCnt(params);
		List<Map<String, Object>> logsList = azureService.azureMainLogsCnt(params);
		List<Map<String, Object>> activityList = azureService.azureMainActivityCnt(params);
		List<Map<String, Object>> resourceList = azureService.azureMainResourceCnt(params);
		List<Map<String, Object>> serviceList = azureService.azureMainServiceCnt(params);
		
		model.addAttribute("allEventList", allEventList);
		model.addAttribute("eventTopList", eventTopList);
		model.addAttribute("serviceHealthEventTopList", serviceHealthEventTopList);
		model.addAttribute("regionEventTopList", regionEventTopList);
		model.addAttribute("metriceList", metriceList);
		model.addAttribute("logsList", logsList);
		model.addAttribute("activityList", activityList);
		model.addAttribute("resourceList", resourceList);
		model.addAttribute("serviceList", serviceList);
		model.addAttribute("dayList", dayList);
		model.addAttribute("params", params);
		
		return "main/report";
		
	}
	
	
	@RequestMapping(value = "/azure/mainResourceGroup.htm")
	public String azureMainResourceGroup(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainResourceGroup.htm 진입 params : " + params);
		
		List<Map<String, Object>> resourceGroup = azureService.azureMainResourceGroup(params);
		
		model.addAttribute("result", "success");
		model.addAttribute("resourceGroup", resourceGroup);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/azure/mainResource.htm")
	public String azureMainResource(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainResource.htm 진입 params : " + params);
		
		List<Map<String, Object>> resource = azureService.azureMainResource(params);
		
		model.addAttribute("result", "success");
		model.addAttribute("resource", resource);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/azure/mainRealTimeChart.htm")
	public String azureMainRealTimeChart(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainRealTimeChart.htm 진입 params : " + params);
		
		int metriceRealTimeCnt = azureService.azureMainMetriceRealTimeCnt(params);
		int logsRealTimeCnt = azureService.azureMainLogsRealTimeCnt(params);
		int activityRealTimeCnt = azureService.azureMainActivityRealTimeCnt(params);
		int resourceRealTimeCnt = azureService.azureMainResourceRealTimeCnt(params);
		int serviceRealTimeCnt = azureService.azureMainServiceRealTimeCnt(params);
		
		model.addAttribute("result", "success");
		
		model.addAttribute("metriceRealTimeCnt", metriceRealTimeCnt);
		model.addAttribute("logsRealTimeCnt", logsRealTimeCnt);
		model.addAttribute("activityRealTimeCnt", activityRealTimeCnt);
		model.addAttribute("resourceRealTimeCnt", resourceRealTimeCnt);
		model.addAttribute("serviceRealTimeCnt", serviceRealTimeCnt);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/azure/mainRealChartModalList.htm")
	public String azureMainRealChartModalList(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainRealChartModalList.htm 진입 params : " + params);
		
		List<Map<String, Object>> realChartList = azureService.azureMainRealChartList(params);
		
		model.addAttribute("realChartList", realChartList);
		model.addAttribute("result", "success");
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/azure/mainLineChartModalList.htm")
	public String azureMainLineChartModalList(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainLineChartModalList.htm 진입 params : " + params);
		
		LocalDate now = LocalDate.now();
		LocalDate startDate;
		
		if(params.get("FilterTitleValue").equals("Weekly")) { 
			startDate = LocalDate.parse(now.minusWeeks(1).toString());
		}else if(params.get("FilterTitleValue").equals("Month")) {
			startDate = LocalDate.parse(now.minusMonths(1).toString());
		}else {
			startDate = LocalDate.parse(now.minusMonths(3).toString());
		}
		
		params.put("day", startDate.plusDays(Integer.parseInt(params.get("no").toString())));
		
		if(params.get("id").equals("0")) { 
			params.put("eventType", "Metrics");
		}else if(params.get("id").equals("1")) {
			params.put("eventType", "Logs");
		}else if(params.get("id").equals("2")) {
			params.put("eventType", "Activity log");
		}else if(params.get("id").equals("3")) {
			params.put("eventType", "Resource health");
		}else {
			params.put("eventType", "service health");
		}
		
		List<Map<String, Object>> mainLineChartList = azureService.azureMainLineChartList(params);
		
		model.addAttribute("mainLineChartList", mainLineChartList);
		model.addAttribute("title", params.get("eventType"));
		model.addAttribute("result", "success");
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/azure/mainPieChartModalList.htm")
	public String azureMainPieChartModalList(@RequestParam Map<String, Object> params, ModelMap model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info(" ============================= /azure/mainPieChartModalList.htm 진입 params : " + params);
		
		List<Map<String, Object>> resourceTypeList = azureService.azureMainResourceTypeCnt(params);
		
		for(int i=0; i<resourceTypeList.size(); i++) {
			if(i == Integer.parseInt(params.get("no").toString())) {
				params.put("resourceType", resourceTypeList.get(i).get("resourceType"));
				break;
			}
		}
		
		List<Map<String, Object>> mainPieChartList = azureService.azureMainPieChartList(params);
		
		model.addAttribute("title", params.get("resourceType"));
		model.addAttribute("mainPieChartList", mainPieChartList);
		model.addAttribute("result", "success");
		
		return "jsonView";
	}
}
