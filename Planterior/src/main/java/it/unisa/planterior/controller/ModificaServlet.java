package it.unisa.planterior.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.bean.Product.Subcategory;
import it.unisa.planterior.model.dao.ProductDao;

/**
 * Servlet implementation class ModificaServlet
 */
@WebServlet("/ModificaServlet")
public class ModificaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/*variabili utili*/
	
	 
      int id;
      Optional<Product> product;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
		// TODO Auto-generated method stub

		String action = (String) request.getParameter("action");
		if(action!=null) {
			if(action.equals("modifica")){
				int id = Integer.parseInt(request.getParameter("id"));
				this.id=id;
				  product = ProductDao.getInstance().getById(id);
				
				
				HttpSession session = request.getSession();
		 		session.setAttribute("product", product);
		 		
				RequestDispatcher dispatcher = request.getRequestDispatcher("ModificaProdotto.jsp");
				dispatcher.forward(request, response);
			}
		}
		else {
	 
		product = ProductDao.getInstance().getById(id);
		Product prodotto = product.get();

		//controlliamo se è presente il NOME
		String Nome=request.getParameter("nome");
		 	if(!Nome.equals("")) 
		 		 		prodotto.setName(Nome);
	 	System.out.println("Nome:"+prodotto.getName());
	 	
	 	//controlliamo se è presente la DESCRIZIONE BREVE
	 	 	String breve=request.getParameter("breve");	
		if(!breve.equals("")) 
			prodotto.setMinimalDescription(breve);
		System.out.println("breve:"+prodotto.getMinimalDescription());	
		
	 	//controlliamo se è presente la DESCRIZIONE COMPLETA
		String Completa=request.getParameter("Completa");
		if(!Completa.equals(""))
			prodotto.setDescription(Completa);
		System.out.println("descrizione:"+prodotto.getDescription());
		
	 	//controlliamo se è presente la CIRCONFERENZA
		float Circonferenza = 0;
		Circonferenza = (float)Integer.parseInt(request.getParameter("Circonferenza"));
		if(Circonferenza>0)
			prodotto.setFlowerpotCircumference(Circonferenza);
		System.out.println("cirocnferenza:"+prodotto.getFlowerpotCircumference());
		
		//controlliamo se è presente l' ALTEZZA
		float Altezza = 0;
		Altezza = (float)Integer.parseInt(request.getParameter("Altezza"));
		if(Altezza>0)
			prodotto.setHeight(Altezza);
		System.out.println("altezza:"+prodotto.getHeight());
		
		//controlliamo se è presente la BASE
		float Base = 0;
		Base = (float)Integer.parseInt(request.getParameter("Prezzo"));
	 	if(Base>0)
			prodotto.setBasePrice(Base);
		System.out.println("PrezzoBase:"+prodotto.getBasePrice());
		
		//controlliamo se è presente lo SCONTO
		float Sconto = 0;
		Sconto = (float)Integer.parseInt(request.getParameter("Sconto"));
		if(Sconto>0)
			prodotto.setDiscountRate(Sconto);
		System.out.println("Sconto:"+prodotto.getDiscountRate());
		
		//controlliamo se è presente la QUANTITA'
		short Quantita = 0;
		Quantita = Short.parseShort(request.getParameter("Quantita"));
		if((Quantita>-1)&&(Quantita!=prodotto.getAvailableAmount()))
			prodotto.setAvailableAmount(Quantita);
		System.out.println("Quantita:"+prodotto.getAvailableAmount());
		
		 ProductDao.getInstance().save(prodotto);
		 RequestDispatcher dispatcher = request.getRequestDispatcher("amministratore.jsp");
			dispatcher.forward(request, response);
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		 
	}

}
