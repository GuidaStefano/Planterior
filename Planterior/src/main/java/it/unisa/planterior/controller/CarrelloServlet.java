package it.unisa.planterior.controller;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;

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
    public void modificaQuantitaPerProdotto(Set<Carrello> listaCarrello, int prodottoDaCercare, int nuovaQuantita) {
        for (Carrello carrello : listaCarrello) {
            if (carrello.getProdotto() == prodottoDaCercare) {
                carrello.setQuantita(nuovaQuantita);
                break;
            }
        }
    }
    public void stampa(Set<Carrello> a) {
    	for (Carrello carrello : a) {
            System.out.println("prodotto:"+carrello.getProdotto()+"quantità:"+carrello.getQuantita());
        }
    }
    public Set<Carrello> eliminaProdotto(Set<Carrello> listaCarrello, int prodottoDaCercare) {
        Carrello prodottoDaEliminare = null;
        for (Carrello carrello : listaCarrello) {
            if (carrello.getProdotto() == prodottoDaCercare) {
                prodottoDaEliminare = carrello;
                System.out.println("abbiamo trovato il prodotto da eliminare, la sua quantità è :"+carrello.getQuantita());
                break;
            }
        }
        if (prodottoDaEliminare != null) {
        	System.out.println("fatto");
            listaCarrello.remove(prodottoDaEliminare);
        }
        
        return listaCarrello;
    }
public boolean controlloCarrello(Set<Carrello> lista_carrello,int id_prodotto) {
	for(Carrello carrello : lista_carrello) {
		if(carrello.getProdotto()==id_prodotto)
				return false;
	}
	return true;
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
							 System.out.println("vogliamo eliminare prodotto con id:"+prodotto);
							 //prendo la lista dalla sessione
							Object listaObj = session.getAttribute("carrello");
				        	if (listaObj instanceof HashSet<?>) {
				        		carrello = (Set<Carrello>) listaObj;
				            }
				        	if(carrello.size()==1)
				        			session.removeAttribute("carrello");
				        	else {
				        	carrello=eliminaProdotto( carrello, prodotto);
				        	stampa(carrello);
				        	//reinserisco l'oggetto nella sessione
				        	session.setAttribute("carrello", carrello);
				        	}
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
			        	if(controlloCarrello(carrello,prodotto)){
			        	carrello.add(new Carrello(prodotto,quantity));
			        	//reinserisco nella sessione il carrello
			        	session.setAttribute("carrello", carrello);
			        	}else {
			        		System.out.println("gia è presente nel carrello");
			        	}
				}
					
		} 
		request.getRequestDispatcher("cart.jsp").forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//con ausilio chiamata ajax permette la modifica quantità nel carrello
		PrintWriter out = response.getWriter();
		    int prodotto = Integer.parseInt(request.getParameter("id_prodtto"));
		    int quantity = Integer.parseInt(request.getParameter("quantity"));
		    HttpSession sessione = request.getSession();
		    Set<Carrello> carrello= null;
		    	Object listaObj = sessione.getAttribute("carrello");
		    	if (listaObj instanceof HashSet<?>) {
		    		carrello = (HashSet<Carrello>) listaObj;
		        } else {
		        	carrello = new HashSet<>();
		        }
		        
		    	if(!carrello.isEmpty()) {
		    		modificaQuantitaPerProdotto(carrello,prodotto,quantity);
		             
		               }		 
		    
		    System.out.println("prodotto:"+prodotto+"quantity:"+quantity);
		    out.println(true);
		
	}

}
