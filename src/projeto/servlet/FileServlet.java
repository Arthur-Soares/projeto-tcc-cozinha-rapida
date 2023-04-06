package projeto.servlet;

import java.awt.List;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.SystemOutLogger;
import org.json.JSONObject;

import com.oreilly.servlet.multipart.Part;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadException;
import javazoom.upload.UploadFile;
import projeto.model.Cr_receita;
import projeto.model.Cr_usuario;
import projeto.util.AppSecrets;
import projeto.util.Cast;

public class FileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ServletResponse response;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("application/json");
    	response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MultipartFormDataRequest mrequest;
		UploadBean upBean = new UploadBean();
		String filepath = AppSecrets.PATH_IMG;
    	JSONObject jsonObj = new JSONObject();
       	jsonObj.put("imagem_usuario", "");
       	jsonObj.put("imagem_usuario_old", "");
       	jsonObj.put("arq_nome", "");
       	jsonObj.put("arq_nome_old", "");
    	PrintWriter out = response.getWriter();
    	Cr_usuario cru = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;
		if (MultipartFormDataRequest.isMultipartFormData(request)) {
			try {
				mrequest = new MultipartFormDataRequest(request);
				
            	
				Hashtable files = mrequest.getFiles();
				Enumeration e = files.elements();
				
				while(e.hasMoreElements()){
					UploadFile file = (UploadFile) files.get("img_upload");
					String opc = null!=mrequest.getParameter("opc")?mrequest.getParameter("opc"):"";
					
					System.out.println("entro opc===? "+opc);
					
					if("salva_img_receita".equals(opc)){
						upBean.setFolderstore(filepath);
											
						int cr_id_receita = Cast.toInt(mrequest.getParameter("cr_id_receita"));																						
						
						Cr_receita crr = new Cr_receita();						
						System.out.println("ID DA RECEITA :: "+cr_id_receita);
						
						String fileName = file.getFileName().trim();
						System.out.println("nome antigo == "+fileName);
						
						fileName = new String(fileName.getBytes("ISO-8859-1"), "UTF-8");
						System.out.println("nome com encoder == "+fileName);
						String newName = "";
						String extension = "";
						int nameIndex = fileName.lastIndexOf('.');						
						if(nameIndex>0) {
							extension = fileName.substring(nameIndex+1).trim();
							newName = "img_receita_"+cr_id_receita+"."+extension;	
							
							System.out.println("Novo nome do arquivo: "+ newName.trim());
						}
						
						file.setFileName(newName.trim());
		                // Uses the bean now to store specified by jsp:setProperty at the top.
		               	upBean.store(mrequest, "img_upload");		               			              		               
		               			               		               
		               	crr.salva_arquivo(newName, cr_id_receita);		               			               			             
					}
					
					file = (UploadFile) e.nextElement();
					System.out.println("Fim do laço");
				}
		     } catch (IOException | UploadException e) {
				e.printStackTrace();
		     }
		} else {
	 		mrequest = null;
	 		System.out.println("Erro ao salvar arquivo!");
	 	}
		//Retorno do FileServlet (JSON)
		out.print(jsonObj);			
    }
    
}
