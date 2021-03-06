<!-- ajax_proxy.html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <script type="text/javascript" src="../js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b"></script>
       <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    
    <title>AED</title>
    
     <script>
    
   
    $(function(){
       
            $.ajax({
                url : '../xml/aed.xml',
                type :'GET',
                dataType : 'xml',
                error : function(){
                    alert('error');
                },
                success : function(xml){
                   const addrArr = [];
                   const placeArr =[];
                   const latitudeArr=[];
                   const longitudeArr=[];
                   $(xml).find("item").each(function(){
                	let addr = $(this).find("buildAddress").text();
                   	let place = $(this).find("buildPlace").text();
                   	let lat = $(this).find("wgs84Lat").text();
                   	let lon = $(this).find("wgs84Lon").text();
                 
                  	addrArr.push(addr);
                  	placeArr.push(place);
                  	latitudeArr.push(lat);
                  	longitudeArr.push(lon);
                  
                   });
                    
                   //Show the map!!
                   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                  mapOption = {
                      center: new kakao.maps.LatLng(37.56682, 126.97864), // 지도의 중심좌표
                      level: 7, // 지도의 확대 레벨
                      mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
                  }; 

                 // 지도를 생성한다 
                 var map = new kakao.maps.Map(mapContainer, mapOption); 

                 // 지도 타입 변경 컨트롤을 생성한다
                 var mapTypeControl = new kakao.maps.MapTypeControl();
   
                 // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
                 map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);   
   
                 // 지도에 확대 축소 컨트롤을 생성한다
                 var zoomControl = new kakao.maps.ZoomControl();
   
                 // 지도의 우측에 확대 축소 컨트롤을 추가한다
                 map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); 
                 
                 
                 
                       
                 for (var i = 0; i < latitudeArr.length; i ++) {
                     // 마커를 생성합니다
                     var marker = new kakao.maps.Marker({
                         map: map, // 마커를 표시할 지도
                         position: new kakao.maps.LatLng(latitudeArr[i], longitudeArr[i]) // 마커의 위치
                     });

                     // 마커에 표시할 인포윈도우를 생성합니다 
                     var infowindow = new kakao.maps.InfoWindow({
                         content: '<div>'+placeArr[i]+'</div>' // 인포윈도우에 표시할 내용
                     });

                     // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                     // 이벤트 리스너로는 클로저를 만들어 등록합니다 
                     // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                     kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                     kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                 }

                 // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
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
                   
                }
            });

        });



       
                 
                     

    </script>
</head>

<body>
<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				    <li class="page-item disabled">
				    </li>
				      <button type="button" class="btn btn-outline-info" onclick="location='../main.jsp'">Home</button>
			<button type="button" class="btn btn-outline-danger" onclick="location='sampfire.jsp'">fire</button>
			<button type="button" class="btn btn-outline-warning" >AED</button>
			<button type="button" class="btn btn-outline-success" onclick="location='sampetc.jsp'">etc</button>
			<li class="page-item"></li>
				  </ul>
				</nav>
	<div id="map" style="width:100%;height:100vh;"></div>
    <div id="sel"></div>
    
</body>

</html>