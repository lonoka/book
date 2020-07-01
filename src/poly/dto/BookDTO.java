package poly.dto;

public class BookDTO {
	private String number;
	private String title;
	private String author;
	private String publisher;
	private String pubyear;
	private String type;
	private String contents;
	private String cover_url;
	private String lib_name;
	private String lib_code;
	private String rec_key;
	private String title_info;
	private String publish_info;
	private String form_info;
	private String series_info;
	private String note_info;
	private String standard_info;
	private String classfy_info;
	private String price_info;

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle_info() {
		return title_info;
	}

	public void setTitle_info(String title_info) {
		this.title_info = title_info;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPubyear() {
		return pubyear;
	}

	public void setPubyear(String pubyear) {
		this.pubyear = pubyear;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCover_url() {
		return cover_url;
	}

	public void setCover_url(String cover_url) {
		this.cover_url = cover_url;
	}

	public String getLib_name() {
		return lib_name;
	}

	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}

	public String getLib_code() {
		return lib_code;
	}

	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}

	public String getRec_key() {
		return rec_key;
	}

	public void setRec_key(String rec_key) {
		this.rec_key = rec_key;
	}
	
	
	public String getPublish_info() {
		return publish_info;
	}

	public void setPublish_info(String publish_info) {
		this.publish_info = publish_info;
	}

	public String getForm_info() {
		return form_info;
	}

	public void setForm_info(String form_info) {
		this.form_info = form_info;
	}

	public String getSeries_info() {
		return series_info;
	}

	public void setSeries_info(String series_info) {
		this.series_info = series_info;
	}

	public String getNote_info() {
		return note_info;
	}

	public void setNote_info(String note_info) {
		this.note_info = note_info;
	}

	public String getStandard_info() {
		return standard_info;
	}

	public void setStandard_info(String standard_info) {
		this.standard_info = standard_info;
	}

	public String getClassfy_info() {
		return classfy_info;
	}

	public void setClassfy_info(String classfy_info) {
		this.classfy_info = classfy_info;
	}

	public String getPrice_info() {
		return price_info;
	}

	public void setPrice_info(String price_info) {
		this.price_info = price_info;
	}


	@Override
	public String toString() {
		return "Book [number=" + number + ", title=" + title + ", author=" + author + ", publisher=" + publisher
				+ ", pubyear=" + pubyear + ", type=" + type + ", contents=" + contents + ", cover_url=" + cover_url
				+ ", lib_name=" + lib_name + ", lib_code=" + lib_code + ", rec_key=" + rec_key + "]";
	}

}
