package it.unisa.planterior.util;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class DateUtil {
	
	private static final ZoneId ZONE_ID = ZoneId.of("Europe/Berlin");

	private static final String SYSTEM_DATE_FORMAT = "yyyy-MM-dd";
	private static final String VISUAL_DATE_FORMAT = "dd/MM/yyyy";
	
	public static ZonedDateTime now() {
		return ZonedDateTime.now(ZONE_ID);
	}
	
	public static Date toSQLDate(ZonedDateTime date) {
		return Date.valueOf(date.toLocalDate().plusDays(1)); 
	}
	
	public static ZonedDateTime fromSQLDate(Date sqlDate) {
		return ZonedDateTime.of(sqlDate.toLocalDate().atStartOfDay(), ZONE_ID);
	}
	
	public static String format(ZonedDateTime date, String pattern) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
		return date.format(formatter);
	}
	
	public static String formatVisual(ZonedDateTime date) {
		return format(date, VISUAL_DATE_FORMAT);
	}
	
	public static String formatSystem(ZonedDateTime date) {
		return format(date, SYSTEM_DATE_FORMAT);
	}
	
	// string nel format yyyy-MM-dd
	public static ZonedDateTime parse(String string) {
		String dummy = "T00:00:00Z"; // ignoriamo l'orario
		return ZonedDateTime.parse(string + dummy);
	}
	
}
