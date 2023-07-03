package it.unisa.planterior.controller;
import java.util.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import it.unisa.planterior.model.bean.Carrello;
import it.unisa.planterior.model.bean.Customer;
/**
 * Servlet implementation class CarrelloServlet
 */
@WebServlet("/Carrello")
public class CarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Set<Carrello> carrello=null;
	int prodotto=0;
	int quantity=0;
	int cliente=0;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CarrelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		if (action!=null) {
			
			if(action.equalsIgnoreCase("delete")) {
				
						if(session.getAttribute("carrello") != null) {
								 //prendo gli attributi
							 prodotto=Integer.parseInt(request.getParameter("id"));
							 quantity=Integer.parseInt(request.getParameter("quantity"));
							 //creo l'oggetto da cercare
							 Carrello a= new Carrello(prodotto, quantity);
				
							 //prendo la lista dalla sessione
							Object listaObj = session.getAttribute("carrello");
				        	if (listaObj instanceof HashSet<?>) {
				        		carrello = (Set<Carrello>) listaObj;
				            }
				        	//rimuovo l'oggetto
				        	carrello.remove(a);
				        	//reinserisco l'oggetto nella sessione
				        	session.setAttribute("carrello", carrello);
				}
				
			}
			if(action.equalsIgnoreCase("acquisto")) {
				float prezzoTotale= Float.parseFloat(request.getParameter("totale"));
				session.setAttribute("prezzoTotale", prezzoTotale);
				request.getRequestDispatcher("Checkout.jsp").forward(request, response);
				
			}
		}else {
			// prendo l'id dell'oggetto da aggiungere
				String valoreParametro = request.getParameter("id");
				 
				try {
				    prodotto = Integer.parseInt(valoreParametro);
				} catch (NumberFormatException e) {
				    // Gestione dell'eccezione nel caso in cui il parametro non sia un intero valido
				}
				//prendo la quantità da tenere
				 quantity = Integer.parseInt(request.getParameter("quantity"));
				 
				 //controllo se l'utente e loggato e se gia ha la lista carrello
				if ( session.getAttribute("carrello") == null) {
						//gli creo la lista carrello
						carrello=new HashSet<Carrello>();
						//aggiungo l'elemento nella lista
						carrello.add(new Carrello(prodotto,quantity));
						//aggiungo la lista nella sessione
						session.setAttribute("carrello", carrello);
						
				}else //piu di un prodotto nel carrello
					if(session.getAttribute("carrello") != null) {
						// prendo la lista dalla sessione
						Object listaObj = session.getAttribute("carrello");
			        	if (listaObj instanceof HashSet<?>) {
			        		carrello = (HashSet<Carrello>) listaObj;
			            } 
			        	//aggiungo un nuovo elemento
			        	carrello.add(new Carrello(prodotto,quantity));
			        	//reinserisco nella sessione il carrello
			        	session.setAttribute("carrello", carrello);
				}
					
		} 
		request.getRequestDispatcher("Carrello.jsp").forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */


}
