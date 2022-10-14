package egovframework.azure.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("azureDAO")
public class AzureDAO extends EgovAbstractMapper{
	
	List<Map<String, Object>> azureMainResourceType(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainResourceType", params);
	}
	
	List<Map<String, Object>> azureMainResourceGroup(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainResourceGroup", params);
	}
	
	List<Map<String, Object>> azureMainResource(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainResource", params);
	}
	
	List<Map<String, Object>> azureMainMetriceCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainMetriceCnt", params);
	}
	
	int azureMainMetriceRealTimeCnt(Map<String, Object> params) throws Exception{
		return selectOne("azureDAO.azureMainMetriceRealTimeCnt", params);
	}
	
	List<Map<String, Object>> azureMainLineChartList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainLineChartList", params);
	}
	
	List<Map<String, Object>> azureMainPieChartList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainPieChartList", params);
	}
	
	List<Map<String, Object>> azureMainRealChartList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainRealChartList", params);
	}
	
	List<Map<String, Object>> azureMainLogsCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainLogsCnt", params);
	}
	
	int azureMainLogsRealTimeCnt(Map<String, Object> params) throws Exception{
		return selectOne("azureDAO.azureMainLogsRealTimeCnt", params);
	}
	
	List<Map<String, Object>> azureMainActivityCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainActivityCnt", params);
	}
		
	int azureMainActivityRealTimeCnt(Map<String, Object> params) throws Exception{
		return selectOne("azureDAO.azureMainActivityRealTimeCnt", params);
	}
	
	List<Map<String, Object>> azureMainResourceCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainResourceCnt", params);
	}
	
	List<Map<String, Object>> azureMainResourceTypeCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainResourceTypeCnt", params);
	}
	
	int azureMainResourceRealTimeCnt(Map<String, Object> params) throws Exception{
		return selectOne("azureDAO.azureMainResourceRealTimeCnt", params);
	}
	
	List<Map<String, Object>> azureMainServiceCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureMainServiceCnt", params);
	}
	
	int azureMainServiceRealTimeCnt(Map<String, Object> params) throws Exception{
		return selectOne("azureDAO.azureMainServiceRealTimeCnt", params);
	}
	
	List<Map<String, Object>> azureAllEventListCnt(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureAllEventListCnt", params);
	}
	
	List<Map<String, Object>> azureEventTopList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureEventTopList", params);
	}
	
	List<Map<String, Object>> azureServiceHealthEventTopList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureServiceHealthEventTopList", params);
	}
	
	List<Map<String, Object>> azureRegionEventTopList(Map<String, Object> params) throws Exception{
		return selectList("azureDAO.azureRegionEventTopList", params);
	}
	
}
