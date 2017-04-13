package Servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import Dao.FishDao;
import entity.Fish;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	public final String DEFAULTPATH = "C:\\Users\\liu\\Pictures\\fisher\\no.jpg";
	private static final long serialVersionUID = 1L;
	private String Ext_Name = "jpg,png,bmp";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UploadServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		  String savePath = this.getServletContext().getRealPath("img");
		 // String savePath = "C:\\Users\\liu\\Pictures\\fisher";
		System.out.println(savePath);
		File saveFileDir = new File(savePath);
		if (!saveFileDir.exists()) {
			// ������ʱĿ¼
			
			saveFileDir.mkdirs();
		}
		String tmpPath = this.getServletContext().getRealPath("WEB-INF/tem");
		File tmpFile = new File(tmpPath);

		if (!tmpFile.exists()) {
			// ������ʱĿ¼
			
			tmpFile.mkdirs();
		}
        String list = "";
        String family = "";
        String category = "";
        String fishName = "";
        String localName ="";
        String englishName="";
        String introduction ="";
        String origin ="";
		String message = "";
		String saveFileName="";
		String fileName="";
		try {
			// ʹ��Apache�ļ��ϴ���������ļ��ϴ����裺
			// 1.����һ��DiskFileItemFactory����
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// ���ù����Ļ������Ĵ�С�����ϴ����ļ���С�����������Ĵ�Сʱ���ͻ�����һ����ʱ�ļ���ŵ�ָ������ʱĿ¼����
			factory.setSizeThreshold(1024 * 10);// ���û������Ĵ�СΪ100KB�������ָ������ôĬ�ϻ������Ĵ�С��10KB
			// �����ϴ�ʱ���ɵ���ʱ�ļ��ı���Ŀ¼
			// 2.����һ���ļ��ϴ�������
			ServletFileUpload upload = new ServletFileUpload(factory);
			// �����ļ��ϴ�����
			upload.setProgressListener(new ProgressListener() {

				@Override
				public void update(long readedBytes, long totalBytes, int currentItem) {
					// TODO Auto-generated method stub
					System.out.println("��ǰ�Ѵ���" + readedBytes + "-----------�ļ���СΪ��" + totalBytes + "--" + currentItem);
				}
			});
			// ����ϴ��ļ�����������������
			upload.setHeaderEncoding("UTF-8");
			// 3.�ж��ύ�����������Ƿ����ϴ���������
			if (!ServletFileUpload.isMultipartContent(request)) {
				// ���մ�ͳ��ʽ��ȡ����
				return;
			}
			// �����ϴ������ļ������ֵ
			upload.setFileSizeMax(1024 * 1024 * 5);// 1M
			// �����ϴ��ļ����������ֵ�����Ǳ����ϴ��������ļ����ܺ͵����ֵ
			upload.setSizeMax(1024 * 1024 * 10);// 10M

			List<FileItem> items = upload.parseRequest(request);
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				// ���fileitem�з�װ������ͨ������������
				if (item.isFormField()) {
					
					String name = item.getFieldName();
					// �����ͨ����������������������
					String value = item.getString("UTF-8");
					// value = new String(value.getBytes("iso8859-1"),"UTF-8");
					if(name.equals("name"))
						fishName = value;
					else if(name.equals("localName"))
						localName = value;
					else if(name.equals("EnglishName"))
						englishName = value;
					else if(name.equals("list"))
						list = value;
					else if(name.equals("family"))
						family = value;
					else if(name.equals("category"))
						category =value;
					else if(name.equals("introduction"))
						introduction = value;
					else if(name.equals("origin"))
						origin = value;
					System.out.println(name + "=" + value);
				} else// ���fileitem�з�װ�����ϴ��ļ�
				{
					// �õ��ϴ��ļ����ļ���
					 fileName = item.getName();
					System.out.println("�ļ�����" + fileName);
					if (fileName == null && fileName.trim().length() == 0) {
						continue;
					}
					// ע�⣺��ͬ��������ύ���ļ����ǲ�һ���ģ���Щ������ύ�������ļ����Ǵ���·����
					// ��: C:\Users\H__D\Desktop\1.txt ����Щ���� �� 1.txt
					// �����ȡ�����ϴ��ļ����ļ�����·�����֣�ֻ�����ļ�������
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

					// �õ��ϴ��ļ�����չ��
					String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					// �����չ��
					// �����Ҫ�����ϴ����ļ����ͣ���ô����ͨ���ļ�����չ�����ж��ϴ����ļ������Ƿ�Ϸ�
					System.out.println("�ϴ����ļ�����չ���ǣ�" + fileExt);
					if (!Ext_Name.contains(fileExt)) {
						System.out.println("�ϴ��ļ���չ���ǲ��������չ����" + fileExt);
						message = message + "�ļ���" + fileName + "���ϴ��ļ���չ���ǲ��������չ����" + fileExt + "<br/>";
						break;
					}

					// ����ļ���С
					if (item.getSize() == 0)
						continue;
					if (item.getSize() > 1024 * 1024 * 5) {
						System.out.println("�ϴ��ļ���С��" + item.getSize());
						message = message + "�ļ���" + fileName + "���ϴ��ļ���С�������ƴ�С��" + upload.getFileSizeMax() + "<br/>";
						break;
					}

					// �õ����ļ����ļ���
					 saveFileName = makeFileName(fileName);
                    
					// �����ļ�����һ// ��ȡitem�е��ϴ��ļ���������
					InputStream is = item.getInputStream();
					// ����һ���ļ������
					FileOutputStream out = new FileOutputStream(savePath + "\\" + saveFileName);
					// ����һ��������
					byte buffer[] = new byte[1024];
					// �ж��������е������Ƿ��Ѿ�����ı���
					int len = 0;
					while ((len = is.read(buffer)) > 0) {
					
						out.write(buffer, 0, len);
					}
					// �ر������
					out.close();
					// �ر�������
					is.close();
					// ɾ����ʱ�ļ�
					item.delete();

					message = message + "�ļ���" + fileName + "���ϴ��ɹ�<br/>";

					// �����ļ�������
					// File uploadedFile = new File(savePath, saveFileName);
					// item.write(uploadedFile);

				}

			}

		} catch (FileSizeLimitExceededException e) {
			message = message + "�ϴ��ļ���С��������<br/>";
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			FishDao fishdao = new FishDao();
			Fish fish = new Fish(fishName,localName,englishName,origin,introduction,saveFileName == ""?DEFAULTPATH:savePath+"\\"+saveFileName,list,family,category);
			fishdao.insertFish(fish);
			request.setAttribute("message", message);
			request.setAttribute("path","img\\"+saveFileName);
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private String makeFileName(String fileName) {
		         // Ϊ��ֹ�ļ����ǵ���������ҪΪ�ϴ��ļ�����һ��Ψһ���ļ���
		         return UUID.randomUUID().toString() + "_" + fileName.replace('%', '_');
		        //Random r = new Random(25);
		        //return  r.nextInt(1000)+fileName;
		     }


}
