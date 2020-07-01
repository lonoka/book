package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface UserMapper {
	
	//회원가입
	int insertUserInfo(UserDTO pDTO) throws Exception;
	
	//중복체크
	UserDTO getUserExists(UserDTO pDTO) throws Exception;

	//ID정보 찾기
	UserDTO getIdInfo(UserDTO pDTO)throws Exception;

	UserDTO getPwInfo(UserDTO pDTO)throws Exception;

	int updatePwInfo(UserDTO pDTO)throws Exception;

	int ckeckId(UserDTO pDTO)throws Exception;

	int ckeckMail(UserDTO pDTO)throws Exception;

	UserDTO getLogin(UserDTO uDTO)throws Exception;

	UserDTO getUserInfo(UserDTO uDTO)throws Exception;

	int updateUserInfo(UserDTO pDTO)throws Exception;
}
