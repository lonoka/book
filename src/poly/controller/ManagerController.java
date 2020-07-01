package poly.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.UserDTO;
import poly.dto.recDTO;
import poly.service.IBookService;
import poly.service.IManagerService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Controller
public class ManagerController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserService")
	private IUserService userService;

	@Resource(name = "ManagerService")
	private IManagerService managerService;

	@Resource(name = "BookService")
	private IBookService bookService;

	// 관리자 회원관리 페이지
	@RequestMapping(value = "crm")
	public String managercrm(HttpServletRequest request, HttpSession session, Model model) throws Exception {
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

		int pgNum = 1;
		if (request.getParameter("pgNum") != null && !request.getParameter("pgNum").equals("")) {
			pgNum = Integer.parseInt(request.getParameter("pgNum"));
		}
		if (pgNum < 1) {
			pgNum = 1;
		}
		int total = managerService.getUserCnt();
		if (pgNum > (total - 1) / 10 + 1) {
			pgNum = 1;
		}
		List<UserDTO> uList = new ArrayList<>();
		int startNum = (pgNum - 1) * 10 + 1;
		int endNum = (pgNum - 1) * 10 + 10;

		uList = managerService.getUserList(startNum, endNum);
		if (uList == null) {
			uList = new ArrayList<UserDTO>();
		}

		int Delcnt = 0;
		if (!uList.isEmpty()) {
			for (int i = 0; i < uList.size(); i++) {
				uList.get(i).setUser_mail(EncryptUtil.decAES128CBC(uList.get(i).getUser_mail()));

				if (uList.get(i).getUser_stat().equals("2")) {
					long lNum = TimeCheck(uList.get(i).getUser_del());
					if (lNum >= 60) {
						int result = 0;
						try {
							result = managerService.deleteUserInfo(uList.get(i).getUser_id());
							result = bookService.deleteUserSearch(uList.get(i).getUser_id());
						} catch (Exception e) {
							e.printStackTrace();
						}
						Delcnt += 1;
					}
					if (Delcnt > 0) {
						model.addAttribute("msg", "탈퇴한지 60일이 지난 회원 " + Delcnt + "명이 삭제되었습니다.");
						model.addAttribute("url", "/crm.do?pgNum=1");
						return "/redirect";
					}
				}
				if (uList.get(i).getUser_del() != null) {
					uList.get(i).setUser_del(uList.get(i).getUser_del().substring(0, 10));
				}
			}
		}
		model.addAttribute("uList", uList);
		model.addAttribute("total", total);
		model.addAttribute("pgNum", pgNum);
		return "/crm/crm";

	}

	// 관리자 회원관리 검색 페이지
	@RequestMapping(value = "crmSearch")
	public String crmSearch(HttpServletRequest request, HttpSession session, Model model) throws Exception {
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

		int pgNum = 1;
		if (request.getParameter("pgNum") != null && !request.getParameter("pgNum").equals("")) {
			pgNum = Integer.parseInt(request.getParameter("pgNum"));
		}
		if (pgNum < 1) {
			pgNum = 1;
		}
		String searchCont = CmmUtil.nvl(request.getParameter("searchCont"));
		if (searchCont.equals("")) {
			model.addAttribute("msg", "검색어를 입력해주세요.");
			model.addAttribute("url", "/crm.do");
			return "/redirect";
		}
		log.info("searchCont : " + searchCont);
		String searchSelect = CmmUtil.nvl(request.getParameter("searchSelect"));
		if (searchSelect.equals("")) {
			model.addAttribute("msg", "검색조건을 선택해주세요.");
			model.addAttribute("url", "/crm.do");
			return "/redirect";
		}

		int total = 0;
		List<UserDTO> uList = new ArrayList<>();
		UserDTO uDTO = new UserDTO();
		if (searchSelect.equals("userId")) {

			total = managerService.getCntId(searchCont);
			if (pgNum > (total - 1) / 10 + 1) {
				pgNum = 1;
			}

			int startNum = (pgNum - 1) * 10 + 1;
			int endNum = (pgNum - 1) * 10 + 10;
			uDTO.setStartNum(startNum);
			uDTO.setEndNum(endNum);
			uDTO.setSearchCont(searchCont);

			uList = managerService.getSearchIdList(uDTO);

		} else if (searchSelect.equals("userName")) {

			total = managerService.getCntName(searchCont);
			if (pgNum > (total - 1) / 10 + 1) {
				pgNum = 1;
			}

			int startNum = (pgNum - 1) * 10 + 1;
			int endNum = (pgNum - 1) * 10 + 10;
			uDTO.setStartNum(startNum);
			uDTO.setEndNum(endNum);
			uDTO.setSearchCont(searchCont);

			uList = managerService.getSearchNameList(uDTO);

		} else if (searchSelect.equals("userStat")) {
			if (searchCont.equals("정상")) {
				searchCont = "0";
			} else if (searchCont.equals("정지")) {
				searchCont = "1";
			} else if (searchCont.equals("탈퇴")) {
				searchCont = "2";
			}
			total = managerService.getCntStat(searchCont);
			if (pgNum > (total - 1) / 10 + 1) {
				pgNum = 1;
			}

			int startNum = (pgNum - 1) * 10 + 1;
			int endNum = (pgNum - 1) * 10 + 10;
			uDTO.setStartNum(startNum);
			uDTO.setEndNum(endNum);

			uDTO.setSearchCont(searchCont);
			uList = managerService.getSearchStatList(uDTO);

			if (searchCont.equals("0")) {
				searchCont = "정상";
			} else if (searchCont.equals("1")) {
				searchCont = "정지";
			} else if (searchCont.equals("2")) {
				searchCont = "탈퇴";
			}
		} else {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", "/crm.do");
			return "/redirect";
		}
		if (uList == null) {
			uList = new ArrayList<UserDTO>();
		}

		if (!uList.isEmpty()) {
			for (int i = 0; i < uList.size(); i++) {
				uList.get(i).setUser_mail(EncryptUtil.decAES128CBC(uList.get(i).getUser_mail()));
				if (uList.get(i).getUser_del() != null) {
					uList.get(i).setUser_del(uList.get(i).getUser_del().substring(0, 10));
				}

			}
		}

		model.addAttribute("searchCont", searchCont);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("uList", uList);
		model.addAttribute("total", total);
		model.addAttribute("pgNum", pgNum);
		return "/crm/crmSearch";

	}

	// 관리자 회원관리 페이지 권한 변경
	@RequestMapping(value = "ModifyAuthorProc")
	public String ModifyAuthor(HttpServletRequest request, HttpSession session, Model model) {
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
		String userCheck = CmmUtil.nvl(request.getParameter("userCheck"));
		log.info("userCheck 확인" + userCheck);
		if (userCheck.equals(userId)) {
			model.addAttribute("msg", "본인의 권한은 변경하실 수 없습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("undefined")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}

		UserDTO uDTO = new UserDTO();
		try {
			uDTO = managerService.getUserInfo(userCheck);

		} catch (Exception e) {
			e.printStackTrace();
		}
		if (uDTO.getUser_author().equals("0")) {
			int result = 0;
			try {
				result = managerService.alterAuthor(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "관리자로 변경되었습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "관리자 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}

		} else {
			int result = 0;
			try {
				result = managerService.alterUser(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "사용자로 변경되었습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "사용자 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}
		}
		return "/redirect";

	}

	// 관리자 회원관리 페이지 상태 변경(정상<->정지)
	@RequestMapping(value = "ModifyStatProc")
	public String ModifyStat(HttpServletRequest request, HttpSession session, Model model) {
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
		String userCheck = CmmUtil.nvl(request.getParameter("userCheck"));
		log.info("userCheck 확인" + userCheck);
		if (userCheck.equals(userId)) {
			model.addAttribute("msg", "본인의 권한은 변경하실 수 없습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("undefined")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}

		UserDTO uDTO = new UserDTO();
		try {
			uDTO = managerService.getUserInfo(userCheck);

		} catch (Exception e) {
			e.printStackTrace();
		}
		if (uDTO.getUser_stat().equals("0")) {
			int result = 0;
			try {
				result = managerService.alterStop(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "유저상태를 활동정지로 변경하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "유저상태 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}

		} else if (uDTO.getUser_stat().equals("1")) {
			int result = 0;
			try {
				result = managerService.alterNomal(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "유저상태를 정상으로 변경하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "유저상태 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}
		} else {
			model.addAttribute("msg", "탈퇴 회원의 상태는 변경하실 수 없습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
		}

		return "/redirect";

	}

	// 관리자 회원관리 페이지 상태 변경 (정상<->탈퇴)
	@RequestMapping(value = "ModifyDelProc")
	public String ModifyDel(HttpServletRequest request, HttpSession session, Model model) {
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
		String userCheck = CmmUtil.nvl(request.getParameter("userCheck"));
		log.info("userCheck 확인" + userCheck);
		if (userCheck.equals(userId)) {
			model.addAttribute("msg", "본인의 권한은 변경하실 수 없습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("undefined")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}

		UserDTO uDTO = new UserDTO();
		try {
			uDTO = managerService.getUserInfo(userCheck);

		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!uDTO.getUser_stat().equals("2")) {
			int result = 0;
			try {
				result = managerService.alterDel(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "유저상태를 탈퇴로 변경하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "유저상태 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}

		} else {
			int result = 0;
			try {
				result = managerService.alterNomal(userCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result > 0) {
				model.addAttribute("msg", "유저상태를 정상으로 변경하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			} else {
				model.addAttribute("msg", "유저상태 변경에 실패하였습니다.");
				model.addAttribute("url", "/crm.do?pgNum=1");
			}
		}

		return "/redirect";

	}

	// 관리자 회원관리 페이지 상세보기 변경
	@RequestMapping(value = "checkUserDetail")
	public String checkUserDetail(HttpServletRequest request, HttpSession session, Model model) throws Exception {
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
		String userCheck = CmmUtil.nvl(request.getParameter("userCheck"));
		log.info("userCheck 확인" + userCheck);
		if (userCheck.equals(userId)) {
			model.addAttribute("msg", "본인의 상세보기는 mypage를 이용해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("undefined")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}
		if (userCheck.equals("")) {
			model.addAttribute("msg", "사용자를 체크해주세요.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}

		UserDTO uDTO = new UserDTO();
		int num0 = 0;
		int num1 = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		int num7 = 0;
		int num8 = 0;
		int num9 = 0;
		String str = "";
		String str2 = "";
		recDTO rDTO = new recDTO();
		uDTO.setUser_id(userCheck);
		List<recDTO> rList = bookService.getUserRecList(userCheck);
		if (rList == null) {
			rList = new ArrayList<recDTO>();
		}
		for (int i = 0; i < rList.size(); i++) {
			str = rList.get(i).getClassfy().substring(0, 1);
			if (str.equals("0")) {
				num0 += rList.get(i).getCount();
			} else if (str.equals("1")) {
				num1 += rList.get(i).getCount();
			} else if (str.equals("2")) {
				num2 += rList.get(i).getCount();
			} else if (str.equals("3")) {
				num3 += rList.get(i).getCount();
			} else if (str.equals("4")) {
				num4 += rList.get(i).getCount();
			} else if (str.equals("5")) {
				num5 += rList.get(i).getCount();
			} else if (str.equals("6")) {
				num6 += rList.get(i).getCount();
			} else if (str.equals("7")) {
				num7 += rList.get(i).getCount();
			} else if (str.equals("8")) {
				num8 += rList.get(i).getCount();
			} else if (str.equals("9")) {
				num9 += rList.get(i).getCount();
			}
		}
		rDTO.setNum0(num0);
		rDTO.setNum1(num1);
		rDTO.setNum2(num2);
		rDTO.setNum3(num3);
		rDTO.setNum4(num4);
		rDTO.setNum5(num5);
		rDTO.setNum6(num6);
		rDTO.setNum7(num7);
		rDTO.setNum8(num8);
		rDTO.setNum9(num9);

		for (int i = 0; i < rList.size(); i++) {
			str = rList.get(i).getClassfy().substring(0, 1);
			str2 = rList.get(i).getClassfy().substring(1, 2);
			if (str.equals("0")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("총류");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("도서학, 서지학");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("문헌정보학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("백과사전");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("강연집, 수필집, 연설문집");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("일반 연속간행물");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("일반 학회, 단체, 협회, 기관");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("신문, 저널리즘");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("일반전집, 총서");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("향토자료");
				}
			} else if (str.equals("1")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("철학");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("형이상학");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("인식론, 인과론, 인간학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("철학의 체계");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("경학");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("동양철학, 사상");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("서양철학");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("논리학");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("심리학");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("윤리학, 도덕철학");
				}
			} else if (str.equals("2")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("종교");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("비교종교");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("불교");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("기독교");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("도교");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("천도교");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("힌두교, 브라만교");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("이슬람교(회교)");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("기타 제종교");
				}
			} else if (str.equals("3")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("사회과학");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("통계자료");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("경제학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("사회학, 사회문제");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("정치학");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("행정학");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("법률, 법학");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("교육학");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("풍속, 예절, 민속학");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("국방, 군사학");
				}
			} else if (str.equals("4")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("자연과학");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("수학");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("물리학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("화학");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("천문학");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("지구과학");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("광물학");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("생명과학");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("식물학");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("동물학");
				}
			} else if (str.equals("5")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("기술과학");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("의학");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("농업, 농학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("공학, 공업 일반, 토목공학, 환경공학");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("건축공학");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("기계공학");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("전기공학, 전자공학");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("화학공학");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("제조업");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("생활과학");
				}
			} else if (str.equals("6")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("예술");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("조각 및 조형미술");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("공예, 장식미술");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("서예");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("회화, 도화");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("사진예술");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("음악");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("공연예술 및 매체예술");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("오락, 스포츠");
				}
			} else if (str.equals("7")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("언어");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("한국어");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("중국어");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("일본어 및 기타 아시아제어");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("영어");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("독일어");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("프랑스어");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("스페인어");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("이탈리아어");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("기타 제어");
				}
			} else if (str.equals("8")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("문학");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("한국문학");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("중국문학");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("일본문학 및 기타 아시아문학");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("영미문학");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("독일문학");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("프랑스문학");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("스페인문학 및 포르투갈문학");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("이탈리아문학");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("기타 제문학");
				}
			} else if (str.equals("9")) {
				if (str2.equals("0")) {
					rList.get(i).setClassfy("역사");
				} else if (str2.equals("1")) {
					rList.get(i).setClassfy("아시아");
				} else if (str2.equals("2")) {
					rList.get(i).setClassfy("유럽");
				} else if (str2.equals("3")) {
					rList.get(i).setClassfy("아프리카");
				} else if (str2.equals("4")) {
					rList.get(i).setClassfy("북아메리카");
				} else if (str2.equals("5")) {
					rList.get(i).setClassfy("남아메리카");
				} else if (str2.equals("6")) {
					rList.get(i).setClassfy("오세아니아, 양극지방");
				} else if (str2.equals("7")) {
					rList.get(i).setClassfy("미분류");
				} else if (str2.equals("8")) {
					rList.get(i).setClassfy("지리");
				} else if (str2.equals("9")) {
					rList.get(i).setClassfy("전기");
				}
			}
		}

		uDTO = userService.getUserInfo(uDTO);
		uDTO.setUser_mail(EncryptUtil.decAES128CBC(uDTO.getUser_mail()));
		uDTO.setUser_date(uDTO.getUser_date().substring(0, 10));
		uDTO.setReg_dt(uDTO.getReg_dt().substring(0, 19));
		uDTO.setReg_dt(uDTO.getReg_dt().substring(0, 19));
		uDTO.setChg_dt(uDTO.getChg_dt().substring(0, 19));
		if (uDTO.getUser_author().equals("0")) {
			uDTO.setUser_author("일반사용자");
		} else if (uDTO.getUser_author().equals("1")) {
			uDTO.setUser_author("관리자");
		}
		if (uDTO.getUser_stat().equals("0")) {
			uDTO.setUser_stat("정상");
		} else if (uDTO.getUser_stat().equals("1")) {
			uDTO.setUser_stat("정지");
		} else if (uDTO.getUser_stat().equals("2")) {
			uDTO.setUser_stat("탈퇴");
			uDTO.setUser_del(uDTO.getUser_del().substring(0,19));
		}

		if (uDTO.getUser_gen().equals("0")) {
			uDTO.setUser_gen("남자");
		} else if (uDTO.getUser_gen().equals("1")) {
			uDTO.setUser_gen("여자");
		}
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("rList", rList);
		return "/crm/crmDetail";

	}

	@RequestMapping(value = "crmUserModify")
	public String userModify(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
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
		String user_id = (String) request.getParameter("userId");
		UserDTO uDTO = new UserDTO();

		uDTO.setUser_id(user_id);

		uDTO = userService.getUserInfo(uDTO);
		uDTO.setUser_mail(EncryptUtil.decAES128CBC(uDTO.getUser_mail()));
		uDTO.setUser_date(uDTO.getUser_date().substring(0, 10));
		model.addAttribute("uDTO", uDTO);
		return "/crm/crmUserModify";

	}

	@RequestMapping(value = "updateCrmUserInfo", method = RequestMethod.POST)
	public String userModifyProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
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

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String user_name = CmmUtil.nvl(request.getParameter("user_name"));
		String password = CmmUtil.nvl(request.getParameter("password"));
		String user_date = CmmUtil.nvl(request.getParameter("user_date"));
		String user_gen = CmmUtil.nvl(request.getParameter("user_gen"));
		String chg_id = CmmUtil.nvl((String) session.getAttribute("userId"));

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);
		pDTO.setUser_name(user_name);

		// 비밀번호는 절대적으로 복호화되지 않도록 해시 알고리즘으로 암호화함
		pDTO.setPassword(EncryptUtil.encHashSHA256(password));

		pDTO.setUser_date(user_date);
		pDTO.setUser_gen(user_gen);
		pDTO.setChg_id(chg_id);

		int res = managerService.updateCrmUserInfo(pDTO);

		if (res == 1) {
			model.addAttribute("msg", "회원정보 수정에 성공하였습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		} else {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다.");
			model.addAttribute("url", "/crm.do?pgNum=1");
			return "/redirect";
		}

	}

	// 시간 계산 함수
	public static long TimeCheck(String str) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		try {
			Date sysdate = new Date();
			Date FirstDate = format.parse(str);

			long calDate = sysdate.getTime() - FirstDate.getTime();
			long calDateDays = calDate / (24 * 60 * 60 * 1000);

			calDateDays = Math.abs(calDateDays);
			return calDateDays;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}
}
