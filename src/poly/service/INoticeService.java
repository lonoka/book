package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;

public interface INoticeService {

	List<NoticeDTO> getNoticeList(int startNum, int endNum) throws Exception;

	String getNoticeCnt() throws Exception;

	int insertNoticeInfo(NoticeDTO nDTO) throws Exception;

	NoticeDTO getNoticeDetail(int notice_seq) throws Exception;

	int updateNoticeInfo(NoticeDTO nDTO) throws Exception;

	int deleteNoticeInfo(String notice_seq) throws Exception;

	int updateReadCnt(int notice_seq) throws Exception;

	NoticeDTO getDetailByRownum(int rownum) throws Exception;

	
	
}
