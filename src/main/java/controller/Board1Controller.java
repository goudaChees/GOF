package controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.Board1DAO;
import dao.Board1_PicDAO;
import dto.Board1DTO;
import dto.Board1_PicDTO;


@WebServlet("*.brd1")
public class Board1Controller extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		request.setCharacterEncoding("utf8");
		Board1DAO dao = new Board1DAO();
		Board1_PicDAO pdao = new Board1_PicDAO();
		HttpSession session = request.getSession();


		try {
			if(uri.equals("/write.brd1")) {//게사판 글 쓰기
				
				int maxSize = 1024*1024*10;//파일 사이즈
				String savePath =request.getServletContext().getRealPath("files");//파일 경로 설정
				
				File filePath = new File(savePath);
				
				
				if(!filePath.exists()) {
					filePath.mkdir();//files 폴더 없으면 만들기
				}
				
				
				MultipartRequest multi = new MultipartRequest(request,savePath,maxSize,"UTF8",new DefaultFileRenamePolicy());
				//HttpServletRequest를 MultipartRequset로 바꾸기
				
				
				int parent_Seq = dao.getBoard1SeqNextval(); //게시판 seq 미리 만들기
				Enumeration e = multi.getFileNames(); //파일 이름 넣기
				
				while(e.hasMoreElements()) {//파일 insert
					String name = (String) e.nextElement();
					String ori_Name = multi.getOriginalFileName(name);
					String sys_Name = multi.getFilesystemName(name);
					
					pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,parent_Seq));
				}

				//글 업데이트
				String id = (String)session.getAttribute("loginID");
				
				if(id==null) {
					id = "test"; // 요 부분은 나중에 삭제~테스트용!
				}
				String writer = dao.selectNicknameById(id);
				String title = multi.getParameter("title");
				String item = multi.getParameter("item");
				int item_price = Integer.parseInt(multi.getParameter("item_price"));
								
				String contents = multi.getParameter("contents");
				
	
				dao.insert(new Board1DTO(parent_Seq,writer,title,contents,null,item,item_price,0,0,0));
	
				
				request.getRequestDispatcher("/list.board?cpage=1").forward(request, response);	
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
