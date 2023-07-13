package it.unisa.planterior.controller;

import java.io.IOException;
import java.util.*;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import it.unisa.planterior.model.bean.*;


import it.unisa.planterior.model.dao.*;



/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

   
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// informazioni di consegna
		String action = request.getParameter("action");
		if (action!=null) {
					
					if(action.equalsIgnoreCase("CONFERMA_PAGAMENTO")) {
					//String email = request.getParameter("email");
					String via = request.getParameter("via");
					short civico =( (short)Integer.parseInt(request.getParameter("civico")));
					String cap =  request.getParameter("cap");
					int interni = Integer.parseInt(request.getParameter("Interno"));
					
					//prendiamo l'user a chi assegnarlo
					Customer customer= (Customer)request.getSession().getAttribute("user");
					ShippingAddress shippingAddress= new ShippingAddress(via,civico,cap,customer);
					//aggiungiamole nel db
					long id_Shipping=ShippingAddressDao.getInstance().saveAndReturnGeneratedId(shippingAddress);
					shippingAddress.setId(id_Shipping);
					
					
					
					//informazioni carta
					PaymentMethod.CardCircuit circuito= PaymentMethod.CardCircuit.valueOf(request.getParameter("circruito"));
					System.out.println(circuito ); 
					String Intestatario= request.getParameter("nameCard");
					String numero_carta= request.getParameter("numeroCard");
					numero_carta=numero_carta.replace(" ", "");
					String cvv= request.getParameter("cvv");
					
					//creiamo l'oggetto payment
						PaymentMethod paymentMethod= new PaymentMethod(circuito,Intestatario,numero_carta,cvv,customer);
						System.out.println(paymentMethod.getCardCircuit()); 
					//salviamo nel db
					long id_pagamento=PaymentMethodDao.getInstance().saveAndReturnGeneratedId(paymentMethod);
					paymentMethod.setId(id_pagamento);
					
					
					
					
					
					// aggiungiamo l'ordine nel database
					
				
					
					float prezzoTotale= (float)request.getSession().getAttribute("prezzoTotale");
					Order order= new Order(customer,paymentMethod,shippingAddress,prezzoTotale);
					long id_order=OrderDao.getInstance().saveAndReturnGeneratedId(order);
					order.setId(id_order);
					 
					//aggiungiamo tutto nella composizione
					
					
					// prendiamo gli articoli dalla sessione
					Set<Carrello> lista_acquisto= null;
					 
					Object listaObj = request.getSession().getAttribute("carrello");
		        	if (listaObj instanceof HashSet<?>) {
		        		lista_acquisto = (HashSet<Carrello>) listaObj;
		            } else {
		            	lista_acquisto = new HashSet<>();
		            }
		        	 
		            //devo trovare l'id dell'ordine 
		        	if(!lista_acquisto.isEmpty()) {
		        		for (Carrello elemento : lista_acquisto) { 
		        			elemento.setOrdine((int)order.getId());
		        			long id_elemento=ComposizioneDao.getInstance().saveAndReturnGeneratedId(elemento);
		        		//	System.out.println(elemento);
		        			System.out.println("id elemento creato:"+id_elemento);
		        		}
		        		
		        	}
		        	request.getSession().setAttribute("ordine", order);
		        	request.getRequestDispatcher("Confermato.jsp").forward(request, response);
					}
					
			}

	}

}
