package it.unisa.planterior.controller;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.bean.Product.Subcategory;
import it.unisa.planterior.model.dao.ProductDao;
import it.unisa.planterior.util.PathUtil;

@MultipartConfig
@WebServlet("/edit-catalog")
public class EditCatalogServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if (action == null)
			return;
		
		if (action.equalsIgnoreCase("add")) {
			Product productToAdd = fetchProduct(request);
			long generatedId = ProductDao.getInstance().saveAndReturnGeneratedId(productToAdd);
			if (generatedId == -1) return;
			saveImages(generatedId, request);
			
			response.sendRedirect("administrator.jsp");
		} else if (action.equalsIgnoreCase("delete") || action.equalsIgnoreCase("edit")){
			String productIdStr = request.getParameter("id");
			if (productIdStr == null)
				return;
			
			long productId = Long.parseLong(productIdStr);
			
			if (action.equalsIgnoreCase("delete")) {
				clearMainImage(productId);
				clearImages(productId);
				ProductDao.getInstance().delete(productId);
			} else {
				Product productToEdit = fetchProduct(request);
				productToEdit.setId(productId);
				ProductDao.getInstance().save(productToEdit);
				saveImages(productId, request);
			}
			
			response.sendRedirect("administrator.jsp");
		}
	}
	
	private void clearMainImage(long id) {
		File dir = new File(PathUtil.IMAGES_DIR_PATH);
		
		boolean result = true;
		for (File file : dir.listFiles((directory, fileName) -> fileName.startsWith(id + "_main"))) {
			file.delete();
		}
	}
	
	private void clearImages(long id) {
		File dir = new File(PathUtil.IMAGES_DIR_PATH);
		
		for (File file : dir.listFiles((directory, fileName) -> fileName.startsWith(Long.toString(id)))) {
			if (file.getName().startsWith(id + "_main")) continue;
			file.delete();
		}
	
	}
	
	private void saveImages(long id, HttpServletRequest request) throws IOException, ServletException {
		int i = 0;
		
		boolean cleaned = false;
		for (Part part : request.getParts()) {
			String partName = part.getName();
			if (!partName.equals("main-image") && !partName.equals("images"))
				continue;
			
			if (getFileName(part).isEmpty()) continue;
			
			if (partName.equals("images")) {
				if (!cleaned) {
					clearImages(id);
					cleaned = true;
				}
			} else {
				clearMainImage(id);
			}
			
			String fileFormat = getFileName(part).split("\\.")[1];
			String fileName = String.format("%d_%s", id, partName.equals("main-image") ? "main" : i++);
			
		    OutputStream out = new FileOutputStream(new File(PathUtil.IMAGES_DIR_PATH + File.separator + fileName + "." + fileFormat));
		    InputStream filecontent = part.getInputStream();
		    
		    int read = 0;
	        final byte[] bytes = new byte[1024];

	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        
	        out.close();
	        filecontent.close();
		}	 
		
	}
	
	private String getFileName(Part part) {
	    String partHeader = part.getHeader("content-disposition");
	    for (String content : partHeader.split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}
	
	
	private Product fetchProduct(HttpServletRequest request) {
		String name = request.getParameter("name");
		Subcategory category = Subcategory.valueOf(request.getParameter("category")); 
		String minimalDescription = request.getParameter("minimal-description");
		String description = request.getParameter("description");
		float height = Float.parseFloat(request.getParameter("height"));
		float flowerpotCircumference = Float.parseFloat(request.getParameter("circumference"));
		float basePrice = Float.parseFloat(request.getParameter("base-price"));
		float discount = Float.parseFloat(request.getParameter("discount"));
		short amount = Short.parseShort(request.getParameter("amount"));
		
		return new Product(name, category, minimalDescription, description, height, flowerpotCircumference, basePrice, discount, amount);
	}
}
