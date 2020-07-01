package poly.service;

import java.util.List;

import poly.dto.UserDTO;

public interface IManagerService {

	int getUserCnt() throws Exception;

	List<UserDTO> getUserList(int startNum, int endNum) throws Exception;

	int deleteUserInfo(String user_id) throws Exception;

	int getCntId(String searchCont) throws Exception;

	List<UserDTO> getSearchIdList(UserDTO uDTO) throws Exception;

	int getCntName(String searchCont) throws Exception;

	List<UserDTO> getSearchNameList(UserDTO uDTO) throws Exception;

	int getCntStat(String searchCont) throws Exception;

	List<UserDTO> getSearchStatList(UserDTO uDTO) throws Exception;

	UserDTO getUserInfo(String userCheck) throws Exception;

	int alterAuthor(String userCheck) throws Exception;

	int alterUser(String userCheck) throws Exception;

	int alterStop(String userCheck) throws Exception;

	int alterNomal(String userCheck) throws Exception;

	int alterDel(String userCheck) throws Exception;

	int updateCrmUserInfo(UserDTO pDTO) throws Exception;

}
