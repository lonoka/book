package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.MailDTO;
import poly.service.IMailService;
import poly.util.CmmUtil;

@Controller
public class MailController {

	// 로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "MailService")
	private IMailService mailService;

	@RequestMapping(value="mail/mailForm")
	public String mailForm() {
		log.info(this.getClass());
		
		return "/mail/mailForm";
	}
	
	@RequestMapping(value="contact")
	public String contact() {
		log.info(this.getClass());
		
		return "/main/Contact";
	}
	
	@RequestMapping(value = "mail/sendMail", method=RequestMethod.POST)
	public String sendMail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		// 로그 찍기
		log.info(this.getClass().getName() + "mail.sendMail start!");

		String toMail = CmmUtil.nvl(request.getParameter("toMail"));
		String title = CmmUtil.nvl(request.getParameter("title"));
		String contents = CmmUtil.nvl(request.getParameter("contents"));

		// 메일 발송할 정보를 넣을 DTO객체 생성
		MailDTO pDTO = new MailDTO();

		pDTO.setToMail(toMail);		// 받는 사람 정보 DTO에 저장
		pDTO.setTitle(title);		// 제목을 DTO에 저장
		pDTO.setContents(contents);	// 내용을 DTO에 저장

		// 메일 발송하기
		int res = mailService.doSendMail(pDTO);

		if (res == 1) {
			// 발송 성공 로그 찍기
			log.info(this.getClass().getName() + "mail.sendMail success!!!");
		} else {
			// 발송 실패 로그 찍기
			log.info(this.getClass().getName() + "mail.sendMail fail!!!");
		}
		// 메일 발송 결과를 JSP에 전달하기
		model.addAttribute("res", String.valueOf(res));
		pDTO=null;
		// 로그 찍기
		log.info(this.getClass().getName() + "mail.sendMail end!");
		return "/mail/sendMailResult";
	}
	@RequestMapping(value = "contactSend", method=RequestMethod.POST)
	public String contactSend(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		// 로그 찍기
		log.info(this.getClass().getName() + "mail.contactSend start!");

		String contactName = CmmUtil.nvl(request.getParameter("contactName"));
		String contactTel = CmmUtil.nvl(request.getParameter("contactTel"));
		String contactEmail = CmmUtil.nvl(request.getParameter("contactEmail"));
		String contactMessage = CmmUtil.nvl(request.getParameter("contactMessage"));

		// 메일 발송할 정보를 넣을 DTO객체 생성
		MailDTO pDTO = new MailDTO();

		pDTO.setContactName(contactName);
		pDTO.setContactTel(contactTel);
		pDTO.setContactEmail(contactEmail);
		pDTO.setContactMessage(contactMessage);

		// 메일 발송하기
		int res = mailService.doSendContact(pDTO);

		if (res == 1) {
			// 발송 성공 로그 찍기
			log.info(this.getClass().getName() + "mail.contactSend success!!!");
			model.addAttribute("msg", "문의메일이 발송됬습니다.");
			model.addAttribute("url", "/contact.do");
		} else {
			// 발송 실패 로그 찍기
			log.info(this.getClass().getName() + "mail.contactSend fail!!!");
			model.addAttribute("msg", "일시적 오류로 문의메일 발송에 실패했습니다. 나중에 다시 시도해주세요.");
			model.addAttribute("url", "/contact.do");
		}
		// 로그 찍기
		log.info(this.getClass().getName() + "mail.contactSend end!");
		
		return "/redirect";
	}
}
