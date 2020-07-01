package poly.service.impl;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import poly.dto.BookDTO;
import poly.dto.recDTO;
import poly.dto.LibraryDTO;
import poly.persistance.mapper.BookMapper;
import poly.service.IBookService;

@Service("BookService")
public class BookService implements IBookService {

	@Resource(name = "BookMapper")
	private BookMapper bookMapper;

	@Override
	public List<BookDTO> searchbook(String keyword, int per_page, int page) {
		List<BookDTO> blist = null;
		try {
			URL url;
			url = new URL("http://nl.go.kr/kolisnet/openApi/open.php" + "?page=" + page + "&search_field1=total_field"
					+ "&value1=" + URLEncoder.encode(keyword, "UTF-8") + "&per_page=" + per_page
					+ "&sort_ksj=SORT_TITLE%20DESC");

			URLConnection urlConn = url.openConnection();

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			BookDTO bDTO = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					blist = new ArrayList<BookDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("RECORD")) {
						blist.add(bDTO);
						bDTO = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "RECORD":
						bDTO = new BookDTO();
						break;
					case "NUMBER":
						if (bDTO != null)
							bDTO.setNumber(parser.nextText());
						break;
					case "TITLE":
						if (bDTO != null)
							bDTO.setTitle(parser.nextText());
						break;
					case "AUTHOR":
						if (bDTO != null)
							bDTO.setAuthor(parser.nextText());
						break;
					case "PUBLISHER":
						if (bDTO != null)
							bDTO.setPublisher(parser.nextText());
						break;
					case "PUBYEAR":
						if (bDTO != null)
							bDTO.setPubyear(parser.nextText());
						break;
					case "TYPE":
						if (bDTO != null)
							bDTO.setType(parser.nextText());
						break;
					case "CONTENTS":
						if (bDTO != null)
							bDTO.setContents(parser.nextText());
						break;
					case "COVER_URL":
						if (bDTO != null)
							bDTO.setCover_url(parser.nextText());
						break;
					case "LIB_NAME":
						if (bDTO != null)
							bDTO.setLib_name(parser.nextText());
						break;
					case "LIB_CODE":
						if (bDTO != null)
							bDTO.setLib_code(parser.nextText());
						break;
					case "REC_KEY":
						if (bDTO != null)
							bDTO.setRec_key(parser.nextText());
						break;
					}

				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		}
		return blist;
	}

	@Override
	public String totalbook(String keyword, int per_page, int page) {
		String total = "";
		try {
			URL url;
			url = new URL("http://nl.go.kr/kolisnet/openApi/open.php" + "?page=" + page + "&search_field1=total_field"
					+ "&value1=" + URLEncoder.encode(keyword, "UTF-8") + "&per_page=" + per_page
					+ "&sort_ksj=SORT_TITLE%20DESC");

			URLConnection urlConn = url.openConnection();

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			BookDTO bDTO = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "TOTAL":
						total = parser.nextText();
						break;
					}
				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		}
		return total;
	}

	@Override
	public List<BookDTO> searchDetail(String rec_key) {
		List<BookDTO> blist = null;
		try {
			URL url;
			url = new URL("http://nl.go.kr/kolisnet/openApi/open.php" + "?rec_key=" + rec_key);

			URLConnection urlConn = url.openConnection();

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			BookDTO bDTO = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					blist = new ArrayList<BookDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("BIBINFO")) {
						blist.add(bDTO);
						bDTO = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "BIBINFO":
						bDTO = new BookDTO();
						break;
					case "TITLE_INFO":
						if (bDTO != null)
							bDTO.setTitle_info(parser.nextText());
						break;
					case "PUBLISH_INFO":
						if (bDTO != null)
							bDTO.setPublish_info(parser.nextText());
						break;
					case "FORM_INFO":
						if (bDTO != null)
							bDTO.setForm_info(parser.nextText());
						break;
					case "SERIES_INFO":
						if (bDTO != null)
							bDTO.setSeries_info(parser.nextText());
						break;
					case "NOTE_INFO":
						if (bDTO != null)
							bDTO.setNote_info(parser.nextText());
						break;
					case "STANDARD_INFO":
						if (bDTO != null)
							bDTO.setStandard_info(parser.nextText());
						break;
					case "CLASSFY_INFO":
						if (bDTO != null)
							bDTO.setClassfy_info(parser.nextText());
						break;
					case "PRICE_INFO":
						if (bDTO != null)
							bDTO.setPrice_info(parser.nextText());
						break;
					}

				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		}
		return blist;
	}

	@Override
	public List<LibraryDTO> searchLibrary(String rec_key) {
		List<LibraryDTO> blist = null;
		try {
			URL url;
			url = new URL("http://nl.go.kr/kolisnet/openApi/open.php" + "?rec_key=" + rec_key);

			URLConnection urlConn = url.openConnection();

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			LibraryDTO bDTO = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					blist = new ArrayList<LibraryDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("HOLDINFO")) {
						blist.add(bDTO);
						bDTO = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "HOLDINFO":
						bDTO = new LibraryDTO();
						break;
					case "LOCAL":
						if (bDTO != null)
							bDTO.setLocal(parser.nextText());
						break;
					case "LIB_CODE":
						if (bDTO != null)
							bDTO.setLib_code(parser.nextText());
						break;
					case "LIB_NAME":
						if (bDTO != null)
							bDTO.setLib_name(parser.nextText());
						break;
					case "CALL_NO":
						if (bDTO != null)
							bDTO.setCall_no(parser.nextText());
						break;
					}

				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		}
		return blist;
	}

	@Override
	public LibraryDTO LibraryDetail(String lib_code) {
		LibraryDTO lDTO = new LibraryDTO();
		try {
			URL url;
			url = new URL("http://nl.go.kr/kolisnet/openApi/open.php" + "?lib_code=" + lib_code);

			URLConnection urlConn = url.openConnection();

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "LIBINFO":
						break;
					case "ZIP_CODE":
						if (lDTO != null)
							lDTO.setZip_code(parser.nextText());
						break;
					case "TEL":
						if (lDTO != null)
							lDTO.setTel(parser.nextText());
						break;
					case "FAX":
						if (lDTO != null)
							lDTO.setFax(parser.nextText());
						break;
					case "ADDRESS":
						if (lDTO != null)
							lDTO.setAddress(parser.nextText());
						break;
					case "E_MAIL":
						if (lDTO != null)
							lDTO.setEmail(parser.nextText());
						break;
					case "HOMEPAGE":
						if (lDTO != null)
							lDTO.setHomepage(parser.nextText());
						break;
					}

				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		}
		return lDTO;
	}

	@Override
	public List<BookDTO> recBook() throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.recBook();
	}

	@Override
	public int setRecommend(recDTO cDTO) throws Exception {

		int result = 0;
		
		recDTO pDTO = new recDTO();
		pDTO = cDTO;
		String classfy = pDTO.getClassfy().substring(0,2);
		classfy = classfy+"0";
		pDTO.setClassfy(classfy);
		if (!cDTO.getUser_id().equals("비회원")) {
			result = bookMapper.checkSearch(pDTO);
			if (result == 0) {
				result = bookMapper.createSearch(pDTO);
			} else {
				result = bookMapper.countSearch(pDTO);
			}
		}

		if (cDTO.getUser_id().equals("비회원")) {
			result = bookMapper.checkRecommend(cDTO);
			if (result == 0) {
				result = bookMapper.createRecommendNM(cDTO);
			} else {
				result = bookMapper.countRecommendNM(cDTO);
			}
		} else {
			if (cDTO.getUser_gen().equals("0")) {
				result = bookMapper.checkRecommend(cDTO);
				if (result == 0) {
					if (cDTO.getUser_age().equals("10대")) {
						result = bookMapper.createRecommend10M(cDTO);
					} else if (cDTO.getUser_age().equals("20대")) {
						result = bookMapper.createRecommend20M(cDTO);
					} else if (cDTO.getUser_age().equals("30대")) {
						result = bookMapper.createRecommend30M(cDTO);
					} else if (cDTO.getUser_age().equals("40대")) {
						result = bookMapper.createRecommend40M(cDTO);
					} else if (cDTO.getUser_age().equals("50대")) {
						result = bookMapper.createRecommend50M(cDTO);
					}
				} else {
					if (cDTO.getUser_age().equals("10대")) {
						result = bookMapper.countRecommend10M(cDTO);
					} else if (cDTO.getUser_age().equals("20대")) {
						result = bookMapper.countRecommend20M(cDTO);
					} else if (cDTO.getUser_age().equals("30대")) {
						result = bookMapper.countRecommend30M(cDTO);
					} else if (cDTO.getUser_age().equals("40대")) {
						result = bookMapper.countRecommend40M(cDTO);
					} else if (cDTO.getUser_age().equals("50대")) {
						result = bookMapper.countRecommend50M(cDTO);
					}
				}
			} else {
				result = bookMapper.checkRecommend(cDTO);
				if (result == 0) {
					if (cDTO.getUser_age().equals("10대")) {
						result = bookMapper.createRecommend10W(cDTO);
					} else if (cDTO.getUser_age().equals("20대")) {
						result = bookMapper.createRecommend20W(cDTO);
					} else if (cDTO.getUser_age().equals("30대")) {
						result = bookMapper.createRecommend30W(cDTO);
					} else if (cDTO.getUser_age().equals("40대")) {
						result = bookMapper.createRecommend40W(cDTO);
					} else if (cDTO.getUser_age().equals("50대")) {
						result = bookMapper.createRecommend50W(cDTO);
					}
				} else {
					if (cDTO.getUser_age().equals("10대")) {
						result = bookMapper.countRecommend10W(cDTO);
					} else if (cDTO.getUser_age().equals("20대")) {
						result = bookMapper.countRecommend20W(cDTO);
					} else if (cDTO.getUser_age().equals("30대")) {
						result = bookMapper.countRecommend30W(cDTO);
					} else if (cDTO.getUser_age().equals("40대")) {
						result = bookMapper.countRecommend40W(cDTO);
					} else if (cDTO.getUser_age().equals("50대")) {
						result = bookMapper.countRecommend50W(cDTO);
					}
				}
			}
		}
		return 0;
	}

	@Override
	public String getUserRec(String userId) throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.getUserRec(userId);
	}

	@Override
	public List<BookDTO> userRec(String recCode) throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.userRec(recCode);
	}

	@Override
	public int deleteUserSearch(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.deleteUserSearch(user_id);
	}

	@Override
	public List<BookDTO> userRecSearch(recDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.userRecSearch(rDTO);
	}

	@Override
	public List<recDTO> getUserRecList(String userId) throws Exception {
		// TODO Auto-generated method stub
		return bookMapper.getUserRecList(userId);
	}

	
	
}
