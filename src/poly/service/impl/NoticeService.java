package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.NoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService{
	
	@Resource(name="NoticeMapper")
	private NoticeMapper noticeMapper;

	

	@Override
	public String getNoticeCnt() throws Exception{
		return noticeMapper.getNoticeCnt();
	}



	@Override
	public List<NoticeDTO> getNoticeList(int startNum, int endNum) throws Exception {
		return noticeMapper.getNoticeList(startNum,endNum);
	}



	@Override
	public int insertNoticeInfo(NoticeDTO nDTO)  throws Exception{
		return noticeMapper.insertNoticeInfo(nDTO);
	}



	@Override
	public NoticeDTO getNoticeDetail(int notice_seq) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.getNoticeDetail(notice_seq);
	}



	@Override
	public int updateNoticeInfo(NoticeDTO nDTO) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.updateNoticeInfo(nDTO);
	}



	@Override
	public int deleteNoticeInfo(String notice_seq) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.deleteNoticeInfo(notice_seq);
	}



	@Override
	public int updateReadCnt(int notice_seq) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.updateReadCnt(notice_seq);
	}



	@Override
	public NoticeDTO getDetailByRownum(int rownum) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.getDetailByRownum(rownum);
	}
	
	
}
