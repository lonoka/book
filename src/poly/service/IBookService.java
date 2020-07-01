package poly.service;

import java.util.List;

import poly.dto.BookDTO;
import poly.dto.recDTO;
import poly.dto.LibraryDTO;

public interface IBookService {
	List<BookDTO> searchbook(String keyword, int per_page, int page);
	
	String totalbook(String keyword, int per_page, int page);
	
	List<BookDTO> searchDetail(String rec_key);
	
	List<LibraryDTO> searchLibrary(String rec_key);

	LibraryDTO LibraryDetail(String lib_code);

	List<BookDTO> recBook() throws Exception;

	int setRecommend(recDTO cDTO) throws Exception;

	String getUserRec(String userId) throws Exception;

	List<BookDTO> userRec(String recCode) throws Exception;

	int deleteUserSearch(String user_id) throws Exception;

	List<BookDTO> userRecSearch(recDTO rDTO) throws Exception;

	List<recDTO> getUserRecList(String userId) throws Exception;



}
