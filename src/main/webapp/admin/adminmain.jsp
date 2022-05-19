<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminPage</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
p {
	margin: 20px 0px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
				<p>Admin Page</p>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#memberManagement">회원 정보 관리</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#postManagement">게시글 관리</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#replyManagement">댓글 관리</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade show active" id="memberManagement">
						
							<table align=center>
								<tr>
									<th colspan=5 style="text-align:center;">Members</th>
								</tr>
								<tr>
									<td>No.</td>
									<td>ID</td>
									<td>Nickname</td>
									<td>Name</td>
									<td>JoinDate</td>
								</tr>
								
								
							</table>
													
						
					</div>
					<div class="tab-pane fade" id="postManagement">
						<p>post list.</p>
					</div>
					<div class="tab-pane fade" id="replyManagement">
						<p>reply list.</p>
					</div>
				</div>
			</div>
		</div>
	</div>




</body>
</html>