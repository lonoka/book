package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.ManagerMapper;
import poly.service.IManagerService;

@Service("ManagerService")
public class ManagerService implements IManagerService {

	@Resource(name="ManagerMapper")
	private ManagerMapper managerMapper;
	
	@Override
	public int getUserCnt() throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getUserCnt();
	}

	@Override
	public List<UserDTO> getUserList(int startNum, int endNum) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getUserList(startNum,endNum);
	}

	@Override
	public int deleteUserInfo(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.deleteUserInfo(user_id);
	}

	@Override
	public int getCntId(String searchCont) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getCntId(searchCont);
	}

	@Override
	public List<UserDTO> getSearchIdList(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getSearchIdList(uDTO);
	}

	@Override
	public int getCntName(String searchCont) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getCntName(searchCont);
	}

	@Override
	public List<UserDTO> getSearchNameList(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getSearchNameList(uDTO);
	}

	@Override
	public int getCntStat(String searchCont) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getCntStat(searchCont);
	}

	@Override
	public List<UserDTO> getSearchStatList(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getSearchStatList(uDTO);
	}

	@Override
	public UserDTO getUserInfo(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.getUserInfo(userCheck);
	}

	@Override
	public int alterAuthor(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.alterAuthor(userCheck);
	}

	@Override
	public int alterUser(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.alterUser(userCheck);
	}

	@Override
	public int alterStop(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.alterStop(userCheck);
	}

	@Override
	public int alterNomal(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.alterNomal(userCheck);
	}

	@Override
	public int alterDel(String userCheck) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.alterDel(userCheck);
	}

	@Override
	public int updateCrmUserInfo(UserDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return managerMapper.updateCrmUserInfo(pDTO);
	}

}
