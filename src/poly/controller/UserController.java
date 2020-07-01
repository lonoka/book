package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.BookDTO;
import poly.dto.MailDTO;
import poly.dto.UserDTO;
import poly.dto.recDTO;
import poly.service.IBookService;
import poly.service.IMailService;
import poly.service.IManagerService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class UserController {
	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스)를 메모리에 적재(싱글톤패턴 적용)
	 */
	@Resource(name = "UserService")
	private IUserService userService;

	@Resource(name = "MailService")
	private IMailService mailService;

	@Resource(name = "BookService")
	private IBookService bookService;
	
	@Resource(name = "ManagerService")
	private IManagerService managerService;

	/*
	 * 메인 화면으로 이동
	 */
	@RequestMapping(value = "index")
	public String Index(ModelMap model) throws Exception {
		List<BookDTO> bList = new ArrayList<>();

		bList = bookService.recBook();
		if (bList == null) {
			bList = new ArrayList();
		}
		model.addAttribute("bList", bList);
		return "/main/index";
	}

	@RequestMapping(value = "maptest")
	public String maptest() {
		log.info(this.getClass());

		return "/index";
	}

	@RequestMapping(value = "privatePolicy")
	public String privatePolicy() {
		log.info(this.getClass());

		return "/main/privatePolicy";
	}

	@RequestMapping(value = "userTerms")
	public String userTerms() {
		log.info(this.getClass());

		return "/main/userTerms";
	}

	/*
	 * 로그인 화면으로 이동
	 */
	@RequestMapping(value = "userLogin")
	public String userLogin() {
		log.info(this.getClass());

		return "/user/userLogin";
	}

	/*
	 * 회원가입 화면으로 이동
	 */
	@RequestMapping(value = "userRegForm")
	public String userRegForm() {
		log.info(this.getClass().getName() + ".user/userRegForm");

		return "/user/userRegForm";
	}

	/*
	 * 아이디/비밀번호찾기 화면으로 이동
	 */
	@RequestMapping(value = "userFind")
	public String userFind() {
		log.info(this.getClass().getName() + ".user/userFind");

		return "/user/userFind";
	}

	/*
	 * 회원가입 로직 처리
	 */
	@RequestMapping(value = "user/insertUserInfo", method=RequestMethod.POST)
	public String insertUserInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + "insertUserInfo Start");

		// 회원가입 결과 메시지 전달 변수
		String msg = "";

		// 웹에서 받는 정보를 저장할 변수
		UserDTO pDTO = null;

		try {
			/*
			 * 웹 에서 받는 정보를 String 변수에 저장 시작 무조건 웹으로 받는 정보는 DTO에 저장하기 위해 임시로 String에 저장
			 */
			String user_id = CmmUtil.nvl(request.getParameter("user_id"));
			String user_name = CmmUtil.nvl(request.getParameter("user_name"));
			String password = CmmUtil.nvl(request.getParameter("password"));
			String user_mail = CmmUtil.nvl(request.getParameter("user_mail"));
			String user_date = CmmUtil.nvl(request.getParameter("user_date"));
			String user_gen = CmmUtil.nvl(request.getParameter("user_gen"));
			/*
			 * 웹 에서 받는 정보를 String 변수에 저장 끝 무조건 웹으로 받는 정보는 DTO에 저장하기 위해 임시로 String에 저장
			 */

			/*
			 * 값을 받는 경우 반드시 로그를 찍어서 값이 들어오는지 확인
			 */
			log.info("user_id : " + user_id);
			log.info("user_name : " + user_name);
			log.info("password : " + password);
			log.info("user_mail : " + user_mail);
			log.info("user_date : " + user_date);
			log.info("user_gen : " + user_gen);

			/*
			 * 웹에서 받는 정보를 DTO에 저장하기 시작 무조건 웹으로 받는 정보는 DTO에 저장
			 */
			// 받는 정보를 저장할 변수를 메모리에 올리기
			pDTO = new UserDTO();
			pDTO.setUser_id(user_id);
			pDTO.setUser_name(user_name);

			// 비밀번호는 절대적으로 복호화되지 않도록 해시 알고리즘으로 암호화함
			pDTO.setPassword(EncryptUtil.encHashSHA256(password));

			// 민감 정보인 이메일은 AES128-CBC로 암호화함
			pDTO.setUser_mail(EncryptUtil.encAES128CBC(user_mail));
			pDTO.setUser_date(user_date);
			pDTO.setUser_gen(user_gen);
			/*
			 * 웹에서 받는 정보를 DTO에 저장하기 끝 무조건 웹으로 받는 정보는 DTO에 저장
			 */

			// 회원가입
			int res = userService.insertUserInfo(pDTO);

			if (res == 1) {
				msg = "회원가입되었습니다.";
			} else if (res == 2) {
				msg = "이미 가입된 회원입니다.";
			} else {
				msg = "오류로 인해 회원가입이 실패하였습니다.";
			}
		} catch (Exception e) {
			// 실패시 사용자에게 보여줄 메시지
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + "insertUserInfo end");

			// 회원가입 여부 결과 메시지 전달
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/index.do");

			// 변수 초기화(메모리 효율화 시키기 위해 사용)
			pDTO = null;
		}
		return "/redirect";
	}

	// ID 체크
	@RequestMapping(value = "checkId")
	public @ResponseBody int checkId(HttpServletRequest request) throws Exception {

		String user_id = request.getParameter("user_id");

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);

		return userService.ckeckId(pDTO);
	}

	// Email 체크
	@RequestMapping(value = "checkMail")
	public @ResponseBody int checkMail(HttpServletRequest request) throws Exception {

		String user_mail = request.getParameter("user_mail");

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_mail(EncryptUtil.encAES128CBC(user_mail));

		return userService.ckeckMail(pDTO);
	}

	// 로그인 버튼
	@RequestMapping(value = "Loginbtn", method=RequestMethod.POST)
	public String Loginbtn(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");

		UserDTO uDTO = new UserDTO();
		uDTO.setUser_id(userId);
		uDTO.setPassword(EncryptUtil.encHashSHA256(userPassword));
		uDTO = userService.getLogin(uDTO);

		if (uDTO == null) {
			model.addAttribute("msg", "없는 아이디 또는 잘못된 비밀번호 입니다.");
			model.addAttribute("url", "/userLogin.do");
		} else if (uDTO.getUser_stat().equals("1")) {
			model.addAttribute("msg", "활동정지된 회원입니다. 전화 또는 Email로 문의해주세요.");
			model.addAttribute("url", "/userLogin.do");
		} else if (uDTO.getUser_stat().equals("2")) {
			model.addAttribute("msg", "탈퇴된 회원입니다. 탈퇴를 취소 하시려면 전화 또는 Email로 문의해주세요.");
			model.addAttribute("url", "/userLogin.do");
		} else if (uDTO.getUser_author().equals("1")) {
			model.addAttribute("msg", "관리자 로그인에 성공하셨습니다.");
			model.addAttribute("url", "/index.do");
			String age = ageCheck(uDTO.getUser_date().substring(0, 10));
			session.setAttribute("userGen", uDTO.getUser_gen());
			session.setAttribute("userAge", age);
			session.setAttribute("userAuthor", uDTO.getUser_author());
			session.setAttribute("userId", uDTO.getUser_id());
			session.setAttribute("userName", uDTO.getUser_name());
		} else {
			model.addAttribute("msg", "로그인에 성공하셨습니다.");
			model.addAttribute("url", "/index.do");
			String age = ageCheck(uDTO.getUser_date().substring(0, 10));
			session.setAttribute("userGen", uDTO.getUser_gen());
			session.setAttribute("userAge", age);
			session.setAttribute("userAuthor", uDTO.getUser_author());
			session.setAttribute("userId", uDTO.getUser_id());
			session.setAttribute("userName", uDTO.getUser_name());
		}

		return "/redirect";
	}

	// 로그아웃 버튼
	@RequestMapping(value = "Logoutbtn")
	public String Logoutbtn(HttpSession session, ModelMap model) throws Exception {
		session.invalidate();

		model.addAttribute("msg", "로그아웃 하셨습니다.");
		model.addAttribute("url", "/index.do");
		return "/redirect";
	}

	// ID찾기
	@RequestMapping(value = "findID", method=RequestMethod.POST)
	public String findId(HttpServletRequest request, ModelMap model) throws Exception {
		String user_name = request.getParameter("user_name");// userName 은 DTO와 같게 지정 parameter값은 jsp의 name값이랑 같게 지정
		String user_date = request.getParameter("user_date");
		String user_mail = request.getParameter("user_mail");

		UserDTO pDTO = new UserDTO(); // 보내는 통

		pDTO.setUser_name(user_name);
		pDTO.setUser_date(user_date);
		pDTO.setUser_mail(EncryptUtil.encAES128CBC(user_mail));

		pDTO = userService.getIdInfo(pDTO);

		if (pDTO == null) {
			model.addAttribute("msg", "가입된 아이디가 없습니다.");
			model.addAttribute("url", "/userLogin.do");
		} else {
			model.addAttribute("msg", "가입된 아이디는 " + pDTO.getUser_id() + " 입니다.");
			model.addAttribute("url", "/userLogin.do");
		}

		return "/redirect";
	}

	// PW찾기 버튼 기능/
	@RequestMapping(value = "findPW", method=RequestMethod.POST)
	public String findPW(HttpServletRequest request, ModelMap model) throws Exception {
		String user_name = request.getParameter("user_name");
		String user_date = request.getParameter("user_date");
		String user_id = request.getParameter("user_id");
		String user_mail = request.getParameter("user_mail");

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);
		pDTO.setUser_name(user_name);
		pDTO.setUser_date(user_date);
		pDTO.setUser_mail(EncryptUtil.encAES128CBC(user_mail));

		pDTO = userService.getPwInfo(pDTO);

		if (pDTO == null) {
			model.addAttribute("msg", "회원정보가 존재하지 않습니다.");
			model.addAttribute("url", "/userLogin.do");
			return "/redirect";
		} else {

			// 10글자 짜리 비밀번호가 NewPw에 들어감
			String NewPw = getNewPw();
			pDTO.setUser_id(user_id);
			pDTO.setPassword(EncryptUtil.encHashSHA256(NewPw));
			int result = 0;
			try {
				result = userService.updatePwInfo(pDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}

			String title = "새로운 비밀번호";
			String contents = "새로운 비밀번호는 " + NewPw + "입니다.";

			// 메일 발송할 정보를 넣을 DTO객체 생성
			MailDTO mDTO = new MailDTO();

			mDTO.setToMail(user_mail); // 받는 사람 정보 DTO에 저장
			mDTO.setTitle(title); // 제목을 DTO에 저장
			mDTO.setContents(contents); // 내용을 DTO에 저장

			// 메일 발송하기
			int res = mailService.doSendMail(mDTO);

			if (res == 1) {
				// 발송 성공 로그 찍기
				log.info(this.getClass().getName() + "mail.sendMail success!!!");
			} else {
				// 발송 실패 로그 찍기
				log.info(this.getClass().getName() + "mail.sendMail fail!!!");
			}

			model.addAttribute("msg", "새로운 비밀번호가 이메일로 발송되었습니다..");
			model.addAttribute("url", "/userLogin.do");
			return "/redirect";
		}

	}

	/*
	 * mypage
	 */
	@RequestMapping(value = "mypage")
	public String mypage(ModelMap model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		log.info(this.getClass());
		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
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
		uDTO.setUser_id(userId);
		List<recDTO> rList = bookService.getUserRecList(userId);
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
		}

		if (uDTO.getUser_gen().equals("0")) {
			uDTO.setUser_gen("남자");
		} else if (uDTO.getUser_gen().equals("1")) {
			uDTO.setUser_gen("여자");
		}
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("rList", rList);
		return "/user/mypage";
	}

	@RequestMapping(value = "userModifyCheck")
	public String userModifyCheck(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		return "/user/userModifyCheck";

	}

	@RequestMapping(value = "userModify", method = RequestMethod.POST)
	public String userModify(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		String password = request.getParameter("userPassword");

		if (userId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

		UserDTO uDTO = new UserDTO();

		uDTO.setUser_id(userId);
		uDTO.setPassword(EncryptUtil.encHashSHA256(password));
		uDTO = userService.getLogin(uDTO);

		if (uDTO == null) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		} else {
			uDTO = userService.getUserInfo(uDTO);
			uDTO.setUser_mail(EncryptUtil.decAES128CBC(uDTO.getUser_mail()));
			uDTO.setUser_date(uDTO.getUser_date().substring(0, 10));
			model.addAttribute("uDTO", uDTO);
			return "/user/userModify";
		}

	}

	@RequestMapping(value = "updateUserInfo", method=RequestMethod.POST)
	public String userModifyProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String user_name = CmmUtil.nvl(request.getParameter("user_name"));
		String password = CmmUtil.nvl(request.getParameter("password"));
		String user_date = CmmUtil.nvl(request.getParameter("user_date"));
		String user_gen = CmmUtil.nvl(request.getParameter("user_gen"));

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);
		pDTO.setUser_name(user_name);

		// 비밀번호는 절대적으로 복호화되지 않도록 해시 알고리즘으로 암호화함
		pDTO.setPassword(EncryptUtil.encHashSHA256(password));

		pDTO.setUser_date(user_date);
		pDTO.setUser_gen(user_gen);

		int res = userService.updateUserInfo(pDTO);

		if (res == 1) {
			model.addAttribute("msg", "회원정보 수정에 성공하였습니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		} else {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

	}

	/*
	 * 도서 추천 화면으로 이동
	 */
	@RequestMapping(value = "recommend")
	public String recommend(ModelMap model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		String title = "맞춤 추천 도서";
		if (userId != null) {

			String recCode = CmmUtil.nvl(bookService.getUserRec(userId));
			List<BookDTO> bList = new ArrayList<>();
			if (recCode.equals("")) {
				bList = bookService.recBook();

			} else {
				recCode = recCode.substring(0, 2);
				bList = bookService.userRec(recCode);
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

	@RequestMapping(value = "userDeleteProc")
	public String userDeleteProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		int result = managerService.alterDel(user_id);
		if(result>0) {
			session.invalidate();
			model.addAttribute("msg", "회원 탈퇴 되셨습니다. 60일 이내로 문의 주시면 탈퇴 취소 가능합니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}else {
			model.addAttribute("msg", "회원 탈퇴에 실패하셨습니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}

	}

	public String getNewPw() throws Exception {
		// 비밀번호 배열을 생성
		char[] charSet = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
				's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

		// 비밀번호를 받기 위한 문자열 버퍼 생성
		// 비밀번호를 담는 틀 생성
		StringBuffer newKey = new StringBuffer();

		// 10번 반복
		for (int i = 0; i < 10; i++) {
			// 비밀번호 배열 길이*랜덤으로 생성된 숫자
			// random() 난수가 복잡하지 않기 떄문에 숫자를 더 복잡하게 해줌
			int idx = (int) (charSet.length * Math.random());
			// 문자열에다가 한글자씩 담는것
			newKey.append(charSet[idx]);
		}

		// 스트링 버퍼를 스트링형태로 바꿔서 반환해줌
		return newKey.toString();
	}

	public static String ageCheck(String str) {
		int year = (int) TimeCheck(str) / 365;
		String age = "";
		if (year < 20) {
			age = "10대";
		} else if (year < 30) {
			age = "20대";
		} else if (year < 40) {
			age = "30대";
		} else if (year < 50) {
			age = "40대";
		} else {
			age = "50대";
		}

		return age;
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
