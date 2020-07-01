package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.util.CmmUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class NoticeController {
	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 */
	@Resource(name = "NoticeService")
	private INoticeService noticeService;

	@RequestMapping(value = "NoticeReg")
	public String NoticeReg( ModelMap model,
			HttpSession session) {
		log.info(this.getClass());
		// 로그인 확인
		String userId = (String) session.getAttribute("userId");
		String userAuthor = (String) session.getAttribute("userAuthor");
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		if (!userAuthor.equals("1")) {
			model.addAttribute("msg", "관리자 권한이 필요합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		return "/notice/NoticeReg";
	}

	@RequestMapping(value = "NoticeList")
	public String NoticeList(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		int pgNum = 1;
		if (request.getParameter("pgNum") != null && !request.getParameter("pgNum").equals("")) {
			pgNum = Integer.parseInt(request.getParameter("pgNum"));
		}
		if (pgNum < 1) {
			pgNum = 1;
		}
		int total = Integer.parseInt(noticeService.getNoticeCnt());
		if (pgNum > (total - 1) / 8 + 1) {
			pgNum = (total - 1) / 8 + 1;
		}
		int startNum = (pgNum - 1) * 8 + 1;
		int endNum = (pgNum - 1) * 8 + 8;
		List<NoticeDTO> nList = new ArrayList<>();
		nList = noticeService.getNoticeList(startNum, endNum);
		if (nList == null) {
			nList = new ArrayList<NoticeDTO>();
		} else {
			for (int i = 0; i < nList.size(); i++) {
				nList.get(i).setChg_dt(nList.get(i).getChg_dt().substring(0, 19));
				filterContent(nList.get(i));
				log.info(nList.get(i).getTitle());
				log.info(nList.get(i).getContents());
			}
		}
		model.addAttribute("nList", nList);
		model.addAttribute("pgNum", pgNum);
		model.addAttribute("total", total);

		return "/notice/NoticeList";
	}

	@RequestMapping(value = "NoticeRegProc", method = RequestMethod.POST)
	public String NoticeRegProc(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session) throws Exception {
		// 로그인 확인
		String userId = (String) session.getAttribute("userId");
		String userAuthor = (String) session.getAttribute("userAuthor");
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		if (!userAuthor.equals("1")) {
			model.addAttribute("msg", "관리자 권한이 필요합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		log.info(contents);

		NoticeDTO nDTO = new NoticeDTO();
		nDTO.setContents(contents);
		nDTO.setTitle(title);
		nDTO.setReg_id(userId);
		int result = 0;
		try {
			result = noticeService.insertNoticeInfo(nDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result > 0) {
			model.addAttribute("msg", "공지사항이 등록되었습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
		} else {
			model.addAttribute("msg", "공지사항 등록에 실패했습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
		}

		return "/redirect";
	}

	// 사용자 공지사항 자세히보기
	@RequestMapping(value = "NoticeDetail")
	public String NoticeDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

		int Notice_seq = 0;
		if (request.getParameter("Notice_seq") != null && !request.getParameter("Notice_seq").equals("")) {
			Notice_seq = Integer.parseInt(request.getParameter("Notice_seq"));
		}

		int Rownum = -1;
		if (request.getParameter("Rownum") != null && !request.getParameter("Rownum").equals("")) {
			Rownum = Integer.parseInt(request.getParameter("Rownum"));
		}

		int pgNum = 0;
		if (request.getParameter("pgNum") != null && !request.getParameter("pgNum").equals("")) {
			pgNum = Integer.parseInt(request.getParameter("pgNum"));
		}

		int total = Integer.parseInt(noticeService.getNoticeCnt());
		Rownum = Rownum + (pgNum - 1) * 8;
		log.info(Rownum);
		NoticeDTO nDTO = new NoticeDTO();
		try {
			nDTO = noticeService.getNoticeDetail(Notice_seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (nDTO == null) {
			model.addAttribute("msg", "공지사항이 없습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			return "redirect";
		} else {
			int result = noticeService.updateReadCnt(Notice_seq);
			log.info(result);
			nDTO.setChg_dt(nDTO.getChg_dt().substring(0, 19));
			filterContent(nDTO);

			model.addAttribute("total", total);
			model.addAttribute("nDTO", nDTO);
			model.addAttribute("Rownum", Rownum);
			return "/notice/NoticeDetail";
		}
	}

	// 공지사항 수정
	@RequestMapping(value = "NoticeModify")
	public String NoticeModify(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		// 로그인 확인
		String userId = (String) session.getAttribute("userId");
		String userAuthor = (String) session.getAttribute("userAuthor");
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		if (!userAuthor.equals("1")) {
			model.addAttribute("msg", "관리자 권한이 필요합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		int Notice_seq = 0;
		if (request.getParameter("Notice_seq") != null && !request.getParameter("Notice_seq").equals("")) {
			Notice_seq = Integer.parseInt(request.getParameter("Notice_seq"));
		}

		NoticeDTO nDTO = new NoticeDTO();
		try {
			nDTO = noticeService.getNoticeDetail(Notice_seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (nDTO == null) {
			model.addAttribute("msg", "공지사항이 없습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			return "redirect";
		} else {
			filterContent(nDTO);
			model.addAttribute("nDTO", nDTO);
			return "/notice/NoticeModify";
		}
	}

	// 관리자 공지사항 수정 실행
	@RequestMapping(value = "/NoticeModifyProc", method = RequestMethod.POST)
	public String NoticeModifyProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		// 로그인 확인
		String userId = (String) session.getAttribute("userId");
		String userAuthor = (String) session.getAttribute("userAuthor");
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		if (!userAuthor.equals("1")) {
			model.addAttribute("msg", "관리자 권한이 필요합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String Notice_seq = request.getParameter("Notice_seq");

		NoticeDTO nDTO = new NoticeDTO();
		nDTO.setContents(contents);
		nDTO.setNotice_seq(Notice_seq);
		nDTO.setTitle(title);
		nDTO.setReg_id(userId);

		int result = 0;
		try {
			result = noticeService.updateNoticeInfo(nDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result > 0) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
		}

		return "/redirect";
	}

	// 관리자 공지사항 삭제
	@RequestMapping(value = "NoticeDelete")
	public String NoticeDelete(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		// 로그인 확인
		String userId = (String) session.getAttribute("userId");
		String userAuthor = (String) session.getAttribute("userAuthor");
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		if (!userAuthor.equals("1")) {
			model.addAttribute("msg", "관리자 권한이 필요합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		String Notice_seq = CmmUtil.nvl(request.getParameter("Notice_seq"));
		if (Notice_seq.equals("")) {
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			model.addAttribute("msg", "잘못된 접근 입니다.");
			return "/redirect";
		}

		int result = 0;

		try {
			result = noticeService.deleteNoticeInfo(Notice_seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			model.addAttribute("msg", "삭제되었습니다.");
		} else {
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			model.addAttribute("msg", "삭제에 실패했습니다.");

		}

		return "/redirect";
	}

	// 공지사항 이전,다음페이지
	@RequestMapping(value = "MoveNoticePage")
	public String MoveNoticePage(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		int Rownum = 0;
		if (request.getParameter("Rownum") != null && !request.getParameter("Rownum").equals("")) {
			Rownum = Integer.parseInt(request.getParameter("Rownum"));
		}
		int total = Integer.parseInt(noticeService.getNoticeCnt());
		if (Rownum < 1) {
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			model.addAttribute("msg", "잘못된 접근 입니다.");
			return "/redirect";
		}
		if (Rownum > total) {
			model.addAttribute("url", "/NoticeList.do?pgNum=1");
			model.addAttribute("msg", "잘못된 접근 입니다.");
			return "/redirect";
		}
		NoticeDTO nDTO = new NoticeDTO();
		nDTO = noticeService.getDetailByRownum(Rownum);
		if (nDTO == null) {
			log.info("값 없음");
		}
		int result = noticeService.updateReadCnt(Integer.parseInt(nDTO.getNotice_seq()));
		filterContent(nDTO);

		model.addAttribute("total", total);
		model.addAttribute("nDTO", nDTO);
		model.addAttribute("Rownum", Rownum);

		return "/notice/NoticeDetail";
	}

	public NoticeDTO filterContent(NoticeDTO nDTO) {
		if(nDTO.getTitle()!=null) {
			
		nDTO.setTitle(nDTO.getTitle().replaceAll("scr!pt", "script"));
		nDTO.setTitle(nDTO.getTitle().replaceAll("& #39;", "&#39"));
		nDTO.setTitle(nDTO.getTitle().replaceAll("& lt;", "&lt;"));
		nDTO.setTitle(nDTO.getTitle().replaceAll("& gt;", "&gt;"));
		nDTO.setTitle(nDTO.getTitle().replaceAll("& #40;", "("));
		nDTO.setTitle(nDTO.getTitle().replaceAll("& #41;", ")"));
		}
		if(nDTO.getContents()!=null) {
			
		nDTO.setContents(nDTO.getContents().replaceAll("scr!pt", "script"));
		nDTO.setContents(nDTO.getContents().replaceAll("& lt;script& gt;", "&lt;script&gt;"));
		nDTO.setContents(nDTO.getContents().replaceAll("& lt;/script& gt;", "&lt;/script&gt;"));
		nDTO.setContents(nDTO.getContents().replaceAll("& #39;", "&#39;"));
		nDTO.setContents(nDTO.getContents().replaceAll("& lt;", "<"));
		nDTO.setContents(nDTO.getContents().replaceAll("& gt;", ">"));
		nDTO.setContents(nDTO.getContents().replaceAll("& #40;", "("));
		nDTO.setContents(nDTO.getContents().replaceAll("& #41;", ")"));
		}
		return nDTO;
	}
}
