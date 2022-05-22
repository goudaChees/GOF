package controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
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

				File file = new File(savePath);

				if(!file.exists()) {
					file.mkdir();
				}

				MultipartRequest multi = new MultipartRequest(request,savePath,maxSize,"UTF8",new DefaultFileRenamePolicy());
				//HttpServletRequest를 MultipartRequset로 바꾸기


				int parent_Seq = dao.getBoard1SeqNextval(); //게시판 seq 미리 만들기
				Enumeration e = multi.getFileNames(); 
				String sys_Name = null;//Board1DTO에 넣기 위해 빼둠


				while(e.hasMoreElements()) {//파일 insert
					String name = (String) e.nextElement();
					String ori_Name = multi.getOriginalFileName(name);
					sys_Name = multi.getFilesystemName(name);

					if(sys_Name != null){
						File oldFile = new File(savePath+"\\"+sys_Name);
						File newFile = new File(savePath+"\\"+(parent_Seq)+"사진.jpg");
						oldFile.renameTo(newFile);
						sys_Name =  (parent_Seq)+"사진.jpg";
					}

					if(ori_Name!=null) {//파일 첨부 했을 때만 테이블에 저장
						pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,parent_Seq));
					}
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
				String nickname = (String) session.getAttribute("loginNN");
				request.setAttribute("nickname", nickname);
				request.getRequestDispatcher("/board1/board1_DetailView.jsp").forward(request, response);
			}else if(uri.equals("/toModifyForm.brd1")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				Board1DTO dto = dao.selectBySeq(seq);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/board1/board1_Modify.jsp").forward(request, response);
			
			
			}else if(uri.equals("/modify.brd1")) {
				//----------------------------------파일 수정
				int maxSize = 1024*1024*10;//최대 사이즈
				String savePath = request.getServletContext().getRealPath("files");//해당 프로젝트 서버 안의 파일 저장소인 files 지정

				MultipartRequest multi = new MultipartRequest(request,savePath,maxSize,"UTF8",new DefaultFileRenamePolicy());
				//넘어온 파일 업로드, 넘어온 request값 분류

				Enumeration e = multi.getFileNames();
				String sys_Name = null;
				String ori_Name = null;
				while(e.hasMoreElements()) {//다음 요소가 존재하는가
					String name = (String) e.nextElement();//다음 요소의 종류
					sys_Name = multi.getFilesystemName(name);//다음 요소의 시스템 이름
					ori_Name = multi.getOriginalFileName(name);//다음 요소의 오리지널 이름
				}

				String isImgDeleted = multi.getParameter("isImgDeleted");//기존 파일을 삭제할 것인지 아닌지 유무
				int seq = Integer.parseInt(multi.getParameter("seq"));

				String filePath = null;//저장 파일의 위치
				String deleteFile_Name = null;//삭제하고자 하는 파일의 시스템 name				
				if(sys_Name==null && isImgDeleted.equals("Y")  ) {//삭제하고 새로 업로드 안하는 경우

					deleteFile_Name = pdao.selectImgBySeq(seq); 
					filePath = savePath + "/" + deleteFile_Name;
					File file = new File(filePath);//파일 객체 생성
					file.delete();//해당 파일 삭제
					if(pdao.selectImgBySeq(seq)!=null) {
						pdao.deleteByParentSeq(seq);						
					}


				}else if(sys_Name!=null) {
					deleteFile_Name = pdao.selectImgBySeq(seq); 
					filePath = savePath + "/" + deleteFile_Name;
					File file = new File(filePath);//파일 객체 생성
					file.delete();//해당 파일 삭제

					pdao.deleteByParentSeq(seq);

					File oldFile = new File(savePath+"\\"+sys_Name);//기존 파일 가리킴
					File newFile = new File(savePath+"\\"+(seq)+"사진.jpg");//파일 이름 변경
					oldFile.renameTo(newFile);
					sys_Name =  (seq)+"사진.jpg";//파일이름과 sys_Name 변수 일치 시키기
					
					if(pdao.selectImgBySeq(seq)!=null) {
						pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,seq));//새로운 파일 객체 테이블에 저장
					}
				}



				//-----------------------------------------글 수정

				String writer = multi.getParameter("writer");
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				String item = multi.getParameter("item");
				int item_price = Integer.parseInt(multi.getParameter("item_price"));
				
				dao.modify(new Board1DTO(seq,writer,title,contents,null,item,item_price,0,0,0,sys_Name));
				
				response.sendRedirect("/list.brd1?cpage=1");

			}else if(uri.equals("/delete.brd1")) {
				int seq = Integer.parseInt(request.getParameter("seq"));//seq 값 불러오기
				//파일 삭제
				String deleteFile = pdao.selectImgBySeq(seq);//seq에 따른 sys_Name 불러오기
				if(deleteFile!=null) {//삭제할 파일이 있는 경우
					String savePath = request.getServletContext().getRealPath("files");
					//서버에 파일이 저장되는 경호
					String fileName = savePath + "\\" + deleteFile;
					File file = new File(fileName); //삭제할 파일을 가리키는 파일 객체 생성
					file.delete();//파일 삭제
					pdao.deleteByParentSeq(seq);//테이블에서 파일 삭제
				}	
				
				dao.deleteBySeq(seq);
				response.sendRedirect("/list.brd1?cpage=1");
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
