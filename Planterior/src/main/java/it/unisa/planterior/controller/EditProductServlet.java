package it.unisa.planterior.controller;

import java.io.IOException;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.dao.ProductDao;
@MultipartConfig
@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {
	private long id=0;
	String Nome;
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String productIdString = request.getParameter("id");
		
		if (action == null || productIdString == null)
			return;
		
		long productId = Long.parseLong(productIdString);
		
		switch (action.toLowerCase()) {
			case "delete":
				ProductDao.getInstance().delete(productId);
				response.sendRedirect("administrator.jsp");
				break;
			case "edit":
				
				break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		
		if (action == null )
			return;
		
		
		
		switch (action.toLowerCase()) {
			case "insert":
				 Nome=request.getParameter("name");	
				System.out.println("Nome:"+Nome);
				String categoria=request.getParameter("category");	
				System.out.println("categoria:"+categoria);
				String breve=request.getParameter("minimal_description");	
				System.out.println("breve:"+breve);
				String Completa=request.getParameter("description");	
				System.out.println("Completa:"+Completa);
				float Circonferenza =  Float.parseFloat(request.getParameter("circumference"));
				System.out.println("Circonferenza:"+Circonferenza);
				float Altezza = Float.parseFloat(request.getParameter("height"));
				System.out.println("Altezza:"+Altezza);
				float Base = Float.parseFloat(request.getParameter("base"));
				System.out.println("Base:"+Base);
				float Sconto = Float.parseFloat(request.getParameter("sconto"));
				System.out.println("Sconto:"+Sconto);
				short Quantita = Short.parseShort(request.getParameter("quantita"));
				System.out.println("Quantita:"+Quantita);
				Product prodotto= new Product(Nome ,  categoria,  breve,  Completa,   Circonferenza, Altezza  ,  Base ,  Sconto ,  Quantita);
				ProductDao.getInstance().save(prodotto);
				
				List<Product> lista_prodotti=ProductDao.getInstance().getAllByName(Nome);
				id=lista_prodotti.get(lista_prodotti.size() - 1).getId();
				System.out.println(id);
				Part file= request.getPart("immagine");
				 Nome=request.getParameter("name");	
					System.out.println("Nome:"+Nome);
				 
				String newFileName = id+".jpg"; 
				String uploadath="C:/Users/totom/git/Planterior/Planterior/src/main/webapp/asset/images/"+newFileName;
				File fx = new File(uploadath);
				
				try {
					if (!fx.exists()) {
						InputStream fileContent = file.getInputStream();
						Files.copy(fileContent, Paths.get(uploadath), StandardCopyOption.REPLACE_EXISTING);
					}
				
				}catch(Exception e) {
					e.printStackTrace();
				}
				request.getRequestDispatcher("administrator.jsp").forward(request, response);
				break;
				
		
				
		}
	
	}
}
