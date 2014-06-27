<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
 <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">

</head>
<body>
<div class="container">
<div class="row">
<div class="col-md-6 col-md-offset-3"> 


<form action="CrawlServlet" method="post" class="form-signin" role="form" >
 <h2 class="form-signin-heading">Please Enter Search Criteria</h2>
<input type="text" name="url" class="form-control" placeholder="Enter Wikipedia URL" required autofocus class="left" id="field">
<input type="text" name="keyword" class="form-control" placeholder="Keyword" required>
<button class="btn btn-lg btn-primary btn-block" type="submit" >Search</button>
</form>
</div>
</div>
</div>

</body>
</html>