package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

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
				
				String fileName = null;
				
				while(e.hasMoreElements()) {//파일 insert
					String name = (String) e.nextElement();
					String ori_Name = multi.getOriginalFileName(name);
					String sys_Name = multi.getFilesystemName(name);
					
					pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,parent_Seq));
					
					if(fileName!=null) {
						
					}
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
	
				
				request.getRequestDispatcher("/list.brd1?cpage=1").forward(request, response);	
				
			}else if(uri.equals("/list.brd1")){
				
				int cpage = Integer.parseInt(request.getParameter("cpage"));
				
				
				session.setAttribute("cpage", cpage);
				
				
				List<Board1DTO> list = dao.selectByPage(cpage);//한 페이지당 리스트 출력
				request.setAttribute("list", list);
				
				int searchCategory = 0;
				String searchTarget = null;
				
				String navi = dao.getNavi(cpage,searchCategory,searchTarget);
				
				request.setAttribute("navi", navi);
				
				request.getRequestDispatcher("/board1/board1_List.jsp").forward(request, response);	
				
			}else if(uri.equals("/search.brd1")) {
				
				int searchCategory = Integer.parseInt(request.getParameter("searchCategory"));//검색 카테고리
				String searchTarget = request.getParameter("searchTarget");//검색어

				int cpage =1;//cpage는 1로 설정
				
				List<Board1DTO> list = new ArrayList<Board1DTO>();//리스트 출력
				list = dao.search(searchTarget, searchCategory, cpage);
	
					
				request.setAttribute("list", list);
				request.setAttribute("searchCategory", searchCategory);
				request.setAttribute("searchTarget", searchTarget);//리스트 request 넣기
				
				String navi = dao.getNavi(cpage,searchCategory,searchTarget);
				
				request.setAttribute("navi", navi);//네비 넣기
				
				request.getRequestDispatcher("/board1/board1_List.jsp?cpage=1").forward(request, response);
				
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
