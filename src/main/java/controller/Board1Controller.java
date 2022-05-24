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
import dao.Board1_ReplyDAO;
import dto.Board1DTO;
import dto.Board1_PicDTO;
import dto.Board1_ReplyDTO;


@WebServlet("*.brd1")
public class Board1Controller extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		Board1DAO dao = new Board1DAO();
		Board1_PicDAO pdao = new Board1_PicDAO();
		Board1_ReplyDAO rdao = new Board1_ReplyDAO();

		HttpSession session = request.getSession();

		try {
			if(uri.equals("/write.brd1")) {//게사판 글 쓰기
				//1. 파일 업데이트

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

				//2. 글 업데이트
				String writer = (String)session.getAttribute("loginNN");
				String title = multi.getParameter("title");
				String item = multi.getParameter("item");
				long item_price = Long.parseLong(multi.getParameter("item_price"));
				String contents = multi.getParameter("contents");
				dao.insert(new Board1DTO(parent_Seq,writer,title,contents,null,item,item_price,0,0,0,sys_Name,0));
				response.sendRedirect("list.brd1?cpage=1");

			}else if(uri.equals("/list.brd1")){

				int cpage = Integer.parseInt(request.getParameter("cpage"));
				session.setAttribute("cpage", cpage);
				
				List<Board1DTO> list = dao.selectByPage(cpage);//한 페이지당 리스트 출력
				request.setAttribute("list", list);//게시글 리스트 저장
				
				
				int searchCategory = 0;//검색 카테고리 기본(Board1DAO의 getNavi()에서 각 카테고리 별로 sql문이 다름)
				String searchTarget = null;//null이어야 처음부터 모든 항목이 검색된다.


				String navi = dao.getNavi(cpage,searchCategory,searchTarget);
				request.setAttribute("navi", navi);
				request.getRequestDispatcher("/board1/board1_List.jsp").forward(request, response);	
			}else if(uri.equals("/search.brd1")) {
				int cpage =1;//cpage는 1로 설정

				int searchCategory = Integer.parseInt(request.getParameter("searchCategory"));//검색 카테고리
				String searchTarget = request.getParameter("searchTarget");//검색어
				List<Board1DTO> list = dao.search(searchTarget, searchCategory, cpage);//리스트 출력

				request.setAttribute("list", list);//리스트 담기
				request.setAttribute("searchCategory", searchCategory);//카테고리 담기
				request.setAttribute("searchTarget", searchTarget);//리스트 request 넣기

				String navi = dao.getNavi(cpage,searchCategory,searchTarget);

				request.setAttribute("navi", navi);//네비 넣기

				request.getRequestDispatcher("/board1/board1_List.jsp?cpage=1").forward(request, response);

			}else if(uri.equals("/detail.brd1")) {//게시글 보기
				int seq =  Integer.parseInt(request.getParameter("seq"));//게시글 seq 가져오기
				String nickname = (String) session.getAttribute("loginNN");//닉네임 가져오기

				//1.전 페이지 참고해서 view_Count 올리기
				String referer = request.getHeader("referer");
				if(referer.contains("http://localhost/list.brd1")) {
					dao.addViewCount(seq);
				};

				//2. 게시글 정보 담기
				Board1DTO dto = dao.selectBySeq(seq);//seq에 따른 contents 출력
				request.setAttribute("dto", dto);//출력된 contents dto에 저장

				//3. 댓글 정보 담기
				List<Board1_ReplyDTO> list = rdao.selectReplyByParentSeq(seq);//부모 seq에 따른 댓글 목록 출력
				request.setAttribute("list", list);//댓글 목록 list에 담기

				//3. 차트를 위한 결과값 뽑기

				double agreeRatio=0;
				double disagreeRatio=0;


				if(list.size()>0) {
					agreeRatio = (dto.getAgree_count()/((dto.getAgree_count()+dto.getDisagree_count())*1.0))*100;//찬성 비율
					disagreeRatio = 100.0-agreeRatio;

					if(agreeRatio==0) {//div밀림을 방지하기 위해 둘 중 하나가 0일 경우 각각 1, 99 값을 줌
						agreeRatio=1;
						disagreeRatio=99;
					}else if(disagreeRatio==0) {
						agreeRatio=99;
						disagreeRatio=1;
					}

				}else {//둘 다 0일 경우 초기값 50:50으로 시작
					agreeRatio=50;
					disagreeRatio=50;
				}

				request.setAttribute("agreeRatio", agreeRatio);
				request.setAttribute("disagreeRatio", disagreeRatio);
				request.setAttribute("nickname", nickname);
				request.setAttribute("dto", dto);


				request.getRequestDispatcher("/board1/board1_DetailView.jsp").forward(request, response);

			}else if(uri.equals("/toModifyForm.brd1")) {
				//--------------------------------------수정 폼으로 가기
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

				if(sys_Name==null && isImgDeleted.equals("Y")  ) {//1. 삭제하고 새로 업로드 안하는 경우

					deleteFile_Name = pdao.selectImgBySeq(seq);//게시글 seq에 따른 파일 이름
					filePath = savePath + "/" + deleteFile_Name;
					File file = new File(filePath);//파일 객체 생성
					file.delete();//해당 파일 삭제
					if(pdao.selectImgBySeq(seq)!=null) {//데이터 테이블에서도 삭제
						pdao.deleteByParentSeq(seq);
						dao.updateFileNameBySeq(seq,sys_Name);//Board1 테이블의 파일 이름 변경
					}


				}else if(sys_Name!=null) {//2. 새로 업로드 하는 경우(sys_Name으로 넘어오는 값이 있다)(삭제할파일 있는 경우 없는 경우 나뉨)

					deleteFile_Name = pdao.selectImgBySeq(seq); 
					filePath = savePath + "/" + deleteFile_Name;
					File file = new File(filePath);//파일 객체 생성
					file.delete();//해당 파일 삭제

					pdao.deleteByParentSeq(seq);//데이터 테이블에서도 삭제
					File oldFile = new File(savePath+"\\"+sys_Name);//기존 파일 가리킴
					File newFile = new File(savePath+"\\"+(seq)+"사진.jpg");//파일 이름 변경
					oldFile.renameTo(newFile);
					sys_Name =  (seq)+"사진.jpg";//파일이름과 sys_Name 변수 일치 시키기
					pdao.insert(new Board1_PicDTO(0,ori_Name,sys_Name,seq));//새로운 파일 객체 테이블에 저장
					dao.updateFileNameBySeq(seq,sys_Name);//Board1 테이블의 파일 이름 변경
				}

				//-----------------------------------------글 수정

				String writer = multi.getParameter("writer");
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				String item = multi.getParameter("item");
				int item_price = Integer.parseInt(multi.getParameter("item_price"));

				dao.modify(new Board1DTO(seq,writer,title,contents,null,item,item_price,0,0,0,null,0));

				response.sendRedirect("/list.brd1?cpage=1");

			}else if(uri.equals("/delete.brd1")) {
				int seq = Integer.parseInt(request.getParameter("seq"));//seq 값 불러오기
				//1. 파일 삭제
				String deleteFile = pdao.selectImgBySeq(seq);//seq에 따른 sys_Name 불러오기
				if(deleteFile!=null) {//삭제할 파일이 있는 경우
					String savePath = request.getServletContext().getRealPath("files");
					//서버에 파일이 저장되는 경호
					String fileName = savePath + "\\" + deleteFile;
					File file = new File(fileName); //삭제할 파일을 가리키는 파일 객체 생성
					file.delete();//파일 삭제
					pdao.deleteByParentSeq(seq);//테이블에서 파일 삭제
				}	
				//2. 게시판 삭제
				dao.deleteBySeq(seq);
				//3. 댓글 삭제(댓글이 있는 경우에만 삭제
				if(rdao.selectReplyByParentSeq(seq).size()>0) {
					rdao.deleteReplyByParent_Seq(seq);
				}
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
