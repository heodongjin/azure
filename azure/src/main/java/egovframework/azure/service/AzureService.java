package egovframework.azure.service;

import java.util.List;
import java.util.Map;

public interface AzureService {
	
	List<Map<String, Object>> azureMainResourceType(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainResourceGroup(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainResource(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainMetriceCnt(Map<String, Object> params) throws Exception;
	
	int azureMainMetriceRealTimeCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainRealChartList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainLineChartList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainPieChartList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainLogsCnt(Map<String, Object> params) throws Exception;
	
	int azureMainLogsRealTimeCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainActivityCnt(Map<String, Object> params) throws Exception;
	
	int azureMainActivityRealTimeCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainResourceCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainResourceTypeCnt(Map<String, Object> params) throws Exception;
	
	int azureMainResourceRealTimeCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureMainServiceCnt(Map<String, Object> params) throws Exception;
	
	int azureMainServiceRealTimeCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureAllEventListCnt(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureEventTopList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureServiceHealthEventTopList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> azureRegionEventTopList(Map<String, Object> params) throws Exception;

}
