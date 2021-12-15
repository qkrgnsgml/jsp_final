<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body background="upload/background.jpg">
<%
	//지도를 나타내주는 페이지 지도떄문인지 이 페이지만 배경이 적용안돼서 body에 직접 넣어줌
	String loc = request.getParameter("location"); //블로그에서 직접 위치를 볼 수 있게 파라미터로 받아준다
	String userID=null;
	if(session.getAttribute("userID")!=null){ //세션이 없으면 가져와서 userID에 넣어줌
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){ //로그인이 되지 않았다면 로그인하라고 알려줌
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'loginForm.jsp'");
		script.println("</script>");
	}

	PostDAO postDAO = new PostDAO(); //PostDAO 객체 생성
	ArrayList<Post> list = postDAO.getList(userID); //arraylist에 userID로 쓴 글중에 Available이 1인(지우지않은) Post의 정보를 다 넣음
%>

<%@ include file="top2.jsp" %> <!--  로그인 한 후에 볼 수 있으므로 top2.jsp를 include -->
<div id="map" style="width:100%;height:1100px"></div>  <!-- 지도페이지를 눌렀을때 나오는 지도 div  -->
 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d6290489d227c328f7ab0b421d1ef7c2&libraries=services"></script>
 <!--  윗줄은 카카오지도api를 가져오는 스크립트인데 교수님은 가져와질지 모르겠습니다. https://apis.map.kakao.com/web/guide/ <ㅡ옆에 사이트에서 
 위에 src금방 만들어서 붙여넣으시면 보실 수 있을 것 같습니다 키 뒤에 &libraries=services  붙혀주셔야 지도 보입니다.-->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(35.17975118241483, 129.07505720361954), // 지도의 중심좌표 현재 중심은 부산으로 맞춰놓음
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색 위에 파라미터로 받은 loc로 바로 이동하게 해주는 함수 이동하면서 아래 content로 가게 위치 라고 찍어준다.
geocoder.addressSearch('<%=loc%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">위치</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동
        map.setCenter(coords);
    } 
});    

 
//마커 이미지의 이미지 주소
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

//위에서 가져온 list의 크기만큼 마커 생성
<%for (int i = 0; i < list.size(); i ++) {%>
	//가져온 리스트의 가게 위치마다 마커 찍어줌
	geocoder.addressSearch('<%=list.get(i).getLocation()%>', function(result, status){
	// 마커 이미지의 이미지 크기 입니다
	var imageSize = new kakao.maps.Size(24, 35); 
	// 마커 이미지를 생성합니다    
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  
	
	var coords = new kakao.maps.LatLng(result[0].y,result[0].x);
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: coords, // 마커를 표시할 위치
        //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
    var infowindow = new kakao.maps.InfoWindow({
        content: '가게이름 : <%=list.get(i).getStoreName()%><br> 평점 : <%=list.get(i).getStoreGrade()%>점' // 인포윈도우에 표시할 내용
    	});
    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	
	});
<%}%>

function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
</script>
</body>
</html>