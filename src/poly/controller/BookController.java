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

import poly.dto.BookDTO;
import poly.dto.recDTO;
import poly.dto.LibraryDTO;
import poly.service.IBookService;
import poly.util.CmmUtil;

@Controller
public class BookController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "BookService")
	private IBookService bookService;

	@RequestMapping(value = "searchBook")
	public String mailForm(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		String keyword = CmmUtil.nvl(request.getParameter("keyword"));
		int pgNum = 1;

		List<BookDTO> bList = new ArrayList<>();

		bList = bookService.searchbook(keyword, 9, pgNum);
		int total = Integer.parseInt(bookService.totalbook(keyword, 9, pgNum));
		log.info("전체갯수 : " + total);

		model.addAttribute("bList", bList);
		model.addAttribute("pgNum", pgNum);
		model.addAttribute("total", total);
		model.addAttribute("keyword", keyword);

		return "/main/searchResult";
	}

	@RequestMapping(value = "movePage")
	public String movePage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		String keyword = CmmUtil.nvl(request.getParameter("keyword"));
		int pgNum = 1;
		if (request.getParameter("pgNum") != null) {
			pgNum = Integer.parseInt(request.getParameter("pgNum"));
		}
		int total = Integer.parseInt(bookService.totalbook(keyword, 9, pgNum));
		if (pgNum < 0) {
			pgNum = 1;
		}
		if (pgNum > (total - 1) / 9 + 1) {
			pgNum = (total - 1) / 9 + 1;
		}
		List<BookDTO> bList = new ArrayList<>();

		bList = bookService.searchbook(keyword, 9, pgNum);

		model.addAttribute("bList", bList);
		model.addAttribute("pgNum", pgNum);
		model.addAttribute("total", total);
		model.addAttribute("keyword", keyword);

		return "/main/searchResult";
	}

	@RequestMapping(value = "searchDetail")
	public String searchDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		String rec_key = CmmUtil.nvl(request.getParameter("rec_key"));
		String cover_url = CmmUtil.nvl(request.getParameter("cover_url"));
		List<BookDTO> bList = new ArrayList<>();
		List<LibraryDTO> lList = new ArrayList<>();

		bList = bookService.searchDetail(rec_key);
		if (bList == null) {
			bList = new ArrayList<BookDTO>();
		}
		lList = bookService.searchLibrary(rec_key);
		if (lList == null) {
			lList = new ArrayList<LibraryDTO>();
		} else {
			LibraryDTO lDTO = new LibraryDTO();

			for (int i = 0; i < lList.size(); i++) {
				lDTO = bookService.LibraryDetail(lList.get(i).getLib_code());
				lList.get(i).setAddress(lDTO.getAddress());
				lList.get(i).setZip_code(lDTO.getZip_code());
				lList.get(i).setTel(lDTO.getTel());
				lList.get(i).setFax(lDTO.getFax());
				lList.get(i).setEmail(lDTO.getEmail());
				lList.get(i).setHomepage(lDTO.getHomepage());
				String str = lList.get(i).getHomepage();
				str = str.replaceAll("http://", "");
				str = str.replaceAll("https://", "");
				lList.get(i).setHomepage(str);
				str = lList.get(i).getLocal();
				str = str.replaceAll("광역시", "");
				lList.get(i).setLocal(str);
			}
		}

		model.addAttribute("bList", bList);
		model.addAttribute("lList", lList);
		model.addAttribute("rec_key", rec_key);
		model.addAttribute("cover_url", cover_url);

		return "/main/searchDetail";
	}

	@RequestMapping(value = "PathFind", method = RequestMethod.POST)
	public String PathFind(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {
		String age = CmmUtil.nvl((String) session.getAttribute("userAge"));
		String gender = CmmUtil.nvl((String) session.getAttribute("userGen"));
		String user_id = CmmUtil.nvl((String) session.getAttribute("userId"));
		String Title = CmmUtil.nvl(request.getParameter("Title"));
		String Author = CmmUtil.nvl(request.getParameter("Author"));
		String Publisher = CmmUtil.nvl(request.getParameter("Publisher"));
		String cover_url = CmmUtil.nvl(request.getParameter("cover_url"));
		String Classfy = CmmUtil.nvl(request.getParameter("Classfy"));
		String rec_key = CmmUtil.nvl(request.getParameter("rec_key"));
		Title = Title.replaceAll("& #40;", "(");
		Title = Title.replaceAll("& #41;", ")");
		Title = Title.replaceAll("  ", " ");

		Author = Author.replaceAll("& #40;", "(");
		Author = Author.replaceAll("& #41;", ")");
		Author = Author.replaceAll("  ", " ");

		Publisher = Publisher.replaceAll("& #40;", "(");
		Publisher = Publisher.replaceAll("& #41;", ")");
		Publisher = Publisher.replaceAll("  ", " ");

		Classfy = Classfy.replaceAll("& gt;", ">");
		Classfy = Classfy.substring(10, 13);

		if (age.equals("")) {
			age = "비회원";
			gender = "비회원";
			user_id = "비회원";
		}

		log.info(Title);
		log.info(Author);
		log.info(Publisher);
		log.info(cover_url);
		log.info(Classfy);
		log.info(rec_key);
		log.info(age);
		log.info(gender);

		recDTO cDTO = new recDTO();
		cDTO.setAuthor(Author);
		cDTO.setClassfy(Classfy);
		cDTO.setCover_url(cover_url);
		cDTO.setPublisher(Publisher);
		cDTO.setRec_key(rec_key);
		cDTO.setTitle(Title);
		cDTO.setUser_age(age);
		cDTO.setUser_gen(gender);
		cDTO.setUser_id(user_id);

		int result = bookService.setRecommend(cDTO);

		String eLoc = CmmUtil.nvl(request.getParameter("eLoc"));
		String LocName = CmmUtil.nvl(request.getParameter("LocName"));
		log.info(LocName);

		model.addAttribute("LocName", LocName);
		model.addAttribute("eLoc", eLoc);

		return "/main/PathFind";
	}

	/*
	 * 도서 추천 검색
	 */
	@RequestMapping(value = "recSearch")
	public String recSearch(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		String val1 = CmmUtil.nvl(request.getParameter("val1"));
		String val2 = CmmUtil.nvl(request.getParameter("val2"));
		String val3 = CmmUtil.nvl(request.getParameter("val3"));
		String title = "";
		if (val1.equals("나이")) {
			title = val2 + " " + val3 + " 추천 도서";
		} else if (val1.equals("분류")) {
			if (val3.equals("전체")) {
				title = val2 + " " + val3 + " 추천 도서";
			} else {
				title = val3 + " 추천 도서";
			}
		} else {
			title = val1 + " 추천 도서";
		}
		if (userId != null) {

			List<BookDTO> bList = new ArrayList<>();
			recDTO rDTO = new recDTO();
			rDTO.setVal1(val1);
			rDTO.setVal2(val2);
			rDTO.setVal3(val3);

			if (val1.equals("전체")) {
				bList = bookService.recBook();
			} else {
				bList = bookService.userRecSearch(rDTO);
			}

			if (bList == null) {
				bList = new ArrayList<>();
			}
			model.addAttribute("title", title);
			model.addAttribute("bList", bList);
			return "/main/recommend";
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

	}
}
