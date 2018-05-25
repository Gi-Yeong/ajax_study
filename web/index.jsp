<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>AJAX_STUDY</title>
	<script type="text/javascript" src="/js/jquery.js"></script>
</head>
<body>

<div onclick="ajax('insert')">test</div>

</body>

<script>
	function ajax(param) {
		alert('실행 됨' + param);
		var url = "/ajax_json.jsp?type=" + param;
		$.ajax({
			url    : url,
			cache  : false,
			success: function (data) {
				var data = JSON.parse(data);
				if (data.resp == "ok") {
					alert(data.genkey);
				}
				else alert(data.desc);
			},
			error  : function () {
				alert("인터넷 연결에 실패하였습니다.");
			}
		});
	}
</script>

</html>