package egovframework.azure.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.azure.service.AzureService;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("azureService")
public class AzureServiceImpl extends EgovAbstractServiceImpl implements AzureService {
	
	@Resource(name = "azureDAO")
	private AzureDAO azureDAO;
	
	@Override
	public List<Map<String, Object>> azureMainResourceType(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResourceType(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainResourceGroup(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResourceGroup(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainResource(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResource(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainMetriceCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainMetriceCnt(params);
	}
	
	@Override
	public int azureMainMetriceRealTimeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainMetriceRealTimeCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainRealChartList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainRealChartList(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainLineChartList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainLineChartList(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainPieChartList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainPieChartList(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainLogsCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainLogsCnt(params);
	}
	
	@Override
	public int azureMainLogsRealTimeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainLogsRealTimeCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainActivityCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainActivityCnt(params);
	}
	
	@Override
	public int azureMainActivityRealTimeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainActivityRealTimeCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainResourceCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResourceCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainResourceTypeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResourceTypeCnt(params);
	}
	
	@Override
	public int azureMainResourceRealTimeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainResourceRealTimeCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureMainServiceCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainServiceCnt(params);
	}
	
	@Override
	public int azureMainServiceRealTimeCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureMainServiceRealTimeCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureAllEventListCnt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureAllEventListCnt(params);
	}
	
	@Override
	public List<Map<String, Object>> azureEventTopList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureEventTopList(params);
	}
	
	@Override
	public List<Map<String, Object>> azureServiceHealthEventTopList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureServiceHealthEventTopList(params);
	}
	
	@Override
	public List<Map<String, Object>> azureRegionEventTopList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return azureDAO.azureRegionEventTopList(params);
	}

}
