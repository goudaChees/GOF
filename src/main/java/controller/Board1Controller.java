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
				System.out.println(savePath);
				System.out.println(request.getContentType());

				MultipartRequest multi = new MultipartRequest(request,savePath,maxSize,"UTF8",new DefaultFileRenamePolicy());
				//HttpServletRequest를 MultipartRequset로 바꾸기


				int parent_Seq = dao.getBoard1SeqNextval(); //게시판 seq 미리 만들기
				Enumeration e = multi.getFileNames(); 

				File oldFile = null;

				String sys_Name = null;//Board1DTO에 넣기 위해 빼둠
				
				while(e.hasMoreElements()) {//파일 insert
					String name = (String) e.nextElement();
					String ori_Name = multi.getOriginalFileName(name);
					sys_Name = multi.getFilesystemName(name);

					oldFile = new File(savePath+"\\"+sys_Name);
					//					File newFile = new File(savePath+"\\"+(parent_Seq-1)+"사진.jpg");
					//					
					//					oldFile.renameTo(newFile);
					//					
					//					System.out.println(newFile);
					//					System.out.println(multi.getFilesystemName(name));
					pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,parent_Seq));

				}



				//글 업데이트
				String writer = (String)session.getAttribute("loginNN");
				String title = multi.getParameter("title");
				String item = multi.getParameter("item");
				int item_price = Integer.parseInt(multi.getParameter("item_price"));
				String contents = multi.getParameter("contents");


				dao.insert(new Board1DTO(parent_Seq,writer,title,contents,null,item,item_price,0,0,0,sys_Name));


				response.sendRedirect("list.brd1?cpage=1");

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

			}else if(uri.equals("/detail.brd1")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				
				Board1DTO dto = dao.selectBySeq(seq);//seq에 따른 contents 출력
				request.setAttribute("dto", dto);//출력된 contents dto에 저장
				
				String sys_Name = pdao.selectImgBySeq(seq);//seq에 따른 이미지 sys_Name 출력
				request.setAttribute("sys_Name", sys_Name);//sys_Name 저장
				
				String nickname = (String) session.getAttribute("loginNN");
				request.setAttribute("nickname", nickname);
				request.getRequestDispatcher("/board1/board1_DetailView.jsp").forward(request, response);
			}else if(uri.equals("/modify.brd1")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				Board1DTO dto = dao.selectBySeq(seq);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/board1/board1_Modify.jsp").forward(request, response);
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
