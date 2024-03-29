package it.unisa.planterior.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class PathUtil {
	
	public static final String IMAGES_DIR_PATH = "C:\\Users\\Stefano\\git\\Planterior\\Planterior\\src\\main\\webapp\\asset\\images";

	private PathUtil() {
		
	}
	
	public static String getMainImagePath(long id) {
		File dir = new File(IMAGES_DIR_PATH);
		
		for (String fileName : dir.list()) {
			if (fileName.startsWith(id + "_main")) {
				return "asset/images/" + fileName;
			}
		}
		
		return null;
	}

	public static List<String> getImagesPaths(long id) {
		File dir = new File(IMAGES_DIR_PATH);
		
		List<String> paths = new ArrayList<>();
		for (String fileName : dir.list()) {
			if (fileName.startsWith(Long.toString(id)) && !fileName.startsWith(id + "_main")) {
				paths.add("asset/images/" + fileName);
			}
		}
		
		return paths;
	}
	
}
