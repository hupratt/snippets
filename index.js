<!DOCTYPE html>
<html>

<head>
	<title>Parcel Sandbox</title>
	<meta charset="UTF-8" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">

<script src="jquery.flagstrap.js"></script>
<link rel="stylesheet" type="text/css" href="flags.css">
</head>

<body>

<form class="form-horizontal">
	<div class="form-group">
        <label>Select Country</label><br>
        <div class="flagstrap" data-input-name="country"></div>
    </div>
</form>

<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-1"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-2"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-3"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
</body>



<script>


$(document).ready(function(){

  function toad(){
    const src= "http://apod.nasa.gov/apod/image/9712/orionfull_jcc_big.jpg";
    $("#divToLoad-1").css("background-image", "url(" + src + ")");
    $(".ben > img").remove();
  };
  
// $.getScript("jquery.flagstrap.js")
  setTimeout(toad,2000);

  $('.flagstrap').flagStrap();

});



</script>

</html>
