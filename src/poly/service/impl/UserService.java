package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.MailDTO;
import poly.dto.UserDTO;
import poly.persistance.mapper.UserMapper;
import poly.service.IMailService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Service("UserService")
public class UserService implements IUserService {

	@Resource(name = "UserMapper")
	private UserMapper userMapper;

	//메일 발송을 위한 MailService 자바 객체 가져오기
	@Resource(name="MailService")
	private IMailService mailService;
	
	@Override
	public int insertUserInfo(UserDTO pDTO) throws Exception {

		// 가입성공 : 1, 중복으로 인한 취소 : 2, 기타 에러 : 0
		int res = 0;

		// controller 에서 값이 안넘어오는 경우를 대비
		if (pDTO == null) {
			pDTO = new UserDTO();
		}

		// 중복 방지를 위해 데이터 조회
		UserDTO rDTO = userMapper.getUserExists(pDTO);

		// mapper에서 값이 못 넘어오는 경우를 대비
		if (rDTO == null) {
			rDTO = new UserDTO();
		}
		// 중복된 회원정보가 있는 경우, 결과값을 2로 변경하고 작업을 진행 안함
		if (CmmUtil.nvl(rDTO.getExists_yn()).equals("Y")) {
			res = 2;
		}
		// 중복된 정보가 없는경우 작업을 진행
		else {
			// 회원가입
			int success = userMapper.insertUserInfo(pDTO);

			// db에 등록됬는지 확인
			if (success > 0) {
				res = 1;
				
				//메일 발송로직 추가
				MailDTO mDTO = new MailDTO();
				//회원정보화면에서 입력받은 이메일 변수(암호화되어 넘어오기 떄문에 복호화 수행)
				mDTO.setToMail(EncryptUtil.decAES128CBC(CmmUtil.nvl(pDTO.getUser_mail())));
				mDTO.setTitle("회원가입을 축하드립니다.");
				
				//메일 내용에 가입자 이름을 넣어서 발송
				mDTO.setContents(CmmUtil.nvl(pDTO.getUser_name())+"님의 회원가입을 진심으로 축하드립니다.");
				
				//회원가입 이메일 발송
				mailService.doSendMail(mDTO);
			} else {
				res = 0;
			}
		}
		return res;
	}

	@Override
	public UserDTO getIdInfo(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getIdInfo(pDTO);
	}

	@Override
	public UserDTO getPwInfo(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getPwInfo(pDTO);
	}

	@Override
	public int updatePwInfo(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updatePwInfo(pDTO);
	}

	@Override
	public int ckeckId(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.ckeckId(pDTO);
	}
	
	@Override
	public int ckeckMail(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.ckeckMail(pDTO);
	}

	@Override
	public UserDTO getLogin(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getLogin(uDTO);
	}

	@Override
	public UserDTO getUserInfo(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserInfo(uDTO);
	}

	@Override
	public int updateUserInfo(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateUserInfo(pDTO);
	}

}
