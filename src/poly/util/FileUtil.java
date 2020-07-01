package poly.util;

import java.io.File;

public class FileUtil {
	public static String mkdirForDate(String uploadDir) {
		String path = uploadDir + DateUtil.getDateTime("/yyyy/MM/DD");
		
		File Folder = new File(path);
		
		if(!Folder.exists()) {
			Folder.mkdirs();
		}
		
		return path;
	}
}
