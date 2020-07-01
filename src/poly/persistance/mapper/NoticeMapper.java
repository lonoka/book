package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.NoticeDTO;

@Mapper("NoticeMapper")
public interface NoticeMapper {

	List<NoticeDTO> getNoticeList(@Param("startNum")int startNum, @Param("endNum")int endNum) throws Exception;

	String getNoticeCnt() throws Exception;

	int insertNoticeInfo(NoticeDTO nDTO) throws Exception;

	NoticeDTO getNoticeDetail(int notice_seq) throws Exception;

	int updateNoticeInfo(NoticeDTO nDTO) throws Exception;

	int deleteNoticeInfo(String notice_seq) throws Exception;

	int updateReadCnt(int notice_seq) throws Exception;

	NoticeDTO getDetailByRownum(int rownum) throws Exception;
	
}
