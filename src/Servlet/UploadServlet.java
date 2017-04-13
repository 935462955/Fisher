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
			// 创建临时目录
			
			saveFileDir.mkdirs();
		}
		String tmpPath = this.getServletContext().getRealPath("WEB-INF/tem");
		File tmpFile = new File(tmpPath);

		if (!tmpFile.exists()) {
			// 创建临时目录
			
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
			// 使用Apache文件上传组件处理文件上传步骤：
			// 1.创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中
			factory.setSizeThreshold(1024 * 10);// 设置缓冲区的大小为100KB，如果不指定，那么默认缓冲区的大小是10KB
			// 设置上传时生成的临时文件的保存目录
			// 2.创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 监听文件上传进度
			upload.setProgressListener(new ProgressListener() {

				@Override
				public void update(long readedBytes, long totalBytes, int currentItem) {
					// TODO Auto-generated method stub
					System.out.println("当前已处理：" + readedBytes + "-----------文件大小为：" + totalBytes + "--" + currentItem);
				}
			});
			// 解决上传文件名的中文乱码问题
			upload.setHeaderEncoding("UTF-8");
			// 3.判断提交上来的数据是否是上传表单的数据
			if (!ServletFileUpload.isMultipartContent(request)) {
				// 按照传统方式获取数据
				return;
			}
			// 设置上传单个文件的最大值
			upload.setFileSizeMax(1024 * 1024 * 5);// 1M
			// 设置上传文件总量的最大值，就是本次上传的所有文件的总和的最大值
			upload.setSizeMax(1024 * 1024 * 10);// 10M

			List<FileItem> items = upload.parseRequest(request);
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				// 如果fileitem中封装的是普通的输入想数据
				if (item.isFormField()) {
					
					String name = item.getFieldName();
					// 解决普通输入项数据中文乱码问题
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
				} else// 如果fileitem中封装的是上传文件
				{
					// 得到上传文件的文件名
					 fileName = item.getName();
					System.out.println("文件名：" + fileName);
					if (fileName == null && fileName.trim().length() == 0) {
						continue;
					}
					// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的
					// 如: C:\Users\H__D\Desktop\1.txt 而有些则是 ： 1.txt
					// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

					// 得到上传文件的扩展名
					String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					// 检查扩展名
					// 如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
					System.out.println("上传的文件的扩展名是：" + fileExt);
					if (!Ext_Name.contains(fileExt)) {
						System.out.println("上传文件扩展名是不允许的扩展名：" + fileExt);
						message = message + "文件：" + fileName + "，上传文件扩展名是不允许的扩展名：" + fileExt + "<br/>";
						break;
					}

					// 检查文件大小
					if (item.getSize() == 0)
						continue;
					if (item.getSize() > 1024 * 1024 * 5) {
						System.out.println("上传文件大小：" + item.getSize());
						message = message + "文件：" + fileName + "，上传文件大小超过限制大小：" + upload.getFileSizeMax() + "<br/>";
						break;
					}

					// 得到存文件的文件名
					 saveFileName = makeFileName(fileName);
                    
					// 保存文件方法一// 获取item中的上传文件的输入流
					InputStream is = item.getInputStream();
					// 创建一个文件输出流
					FileOutputStream out = new FileOutputStream(savePath + "\\" + saveFileName);
					// 创建一个缓冲区
					byte buffer[] = new byte[1024];
					// 判断输入流中的数据是否已经读完的标致
					int len = 0;
					while ((len = is.read(buffer)) > 0) {
					
						out.write(buffer, 0, len);
					}
					// 关闭输出流
					out.close();
					// 关闭输入流
					is.close();
					// 删除临时文件
					item.delete();

					message = message + "文件：" + fileName + "，上传成功<br/>";

					// 保存文件方法二
					// File uploadedFile = new File(savePath, saveFileName);
					// item.write(uploadedFile);

				}

			}

		} catch (FileSizeLimitExceededException e) {
			message = message + "上传文件大小超过限制<br/>";
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
		         // 为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名
		         return UUID.randomUUID().toString() + "_" + fileName.replace('%', '_');
		        //Random r = new Random(25);
		        //return  r.nextInt(1000)+fileName;
		     }


}
