package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.BookDTO;
import poly.dto.recDTO;

@Mapper("BookMapper")
public interface BookMapper {

	List<BookDTO> recBook() throws Exception;

	int checkSearch(recDTO cDTO) throws Exception;

	int createSearch(recDTO cDTO) throws Exception;

	int countSearch(recDTO cDTO) throws Exception;

	int checkRecommend(recDTO cDTO) throws Exception;

	int createRecommendNM(recDTO cDTO) throws Exception;

	int countRecommendNM(recDTO cDTO) throws Exception;

	int createRecommend10M(recDTO cDTO) throws Exception;

	int createRecommend20M(recDTO cDTO) throws Exception;

	int createRecommend30M(recDTO cDTO) throws Exception;

	int createRecommend40M(recDTO cDTO) throws Exception;

	int createRecommend50M(recDTO cDTO) throws Exception;

	int countRecommend10M(recDTO cDTO) throws Exception;

	int countRecommend20M(recDTO cDTO) throws Exception;

	int countRecommend30M(recDTO cDTO) throws Exception;

	int countRecommend40M(recDTO cDTO) throws Exception;

	int countRecommend50M(recDTO cDTO) throws Exception;

	int createRecommend10W(recDTO cDTO) throws Exception;

	int createRecommend20W(recDTO cDTO) throws Exception;

	int createRecommend30W(recDTO cDTO) throws Exception;

	int createRecommend40W(recDTO cDTO) throws Exception;

	int createRecommend50W(recDTO cDTO) throws Exception;

	int countRecommend10W(recDTO cDTO) throws Exception;

	int countRecommend20W(recDTO cDTO) throws Exception;

	int countRecommend30W(recDTO cDTO) throws Exception;

	int countRecommend40W(recDTO cDTO) throws Exception;

	int countRecommend50W(recDTO cDTO) throws Exception;

	String getUserRec(String userId) throws Exception;

	List<BookDTO> userRec(String recCode) throws Exception;

	int deleteUserSearch(String user_id) throws Exception;

	List<BookDTO> userRecSearch(recDTO rDTO) throws Exception;

	List<recDTO> getUserRecList(String userId) throws Exception;

}
