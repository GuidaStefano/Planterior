package it.unisa.planterior.model.bean;

import java.util.Calendar;
import java.util.Date;
public class Test {
	public static void main(String[] args) {
        // Ottieni la data attuale
        Calendar calendar = Calendar.getInstance();
        Date currentDate = calendar.getTime();

        // Aggiungi 7 giorni
        calendar.add(Calendar.DAY_OF_MONTH, 7);

        // Ottieni la nuova data aggiunta di 7 giorni
        Date newDate = calendar.getTime();

        // Stampa le date
        System.out.println("Data attuale: " + currentDate);
        System.out.println("Data aggiunta di 7 giorni: " + newDate);
    }
}
