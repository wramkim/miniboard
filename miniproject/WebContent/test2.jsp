<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="summernote">Hello Summernote</div>
	<script>
		$(document).ready(function() {
			$('#summernote').summernote();
		});
	</script>
</body>
</html>