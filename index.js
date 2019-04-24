<!DOCTYPE html>
<html>

<head>
	<title>Parcel Sandbox</title>
	<meta charset="UTF-8" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>

<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-1"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-2"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
<div style='height:200px; background-color:red;text-align: center;' class = "ben" id="divToLoad-3"><img style="background-color:blue;" src="AromaticVigorousCockatiel-small.gif"/> </div>
</body>



<script>


$(document).ready(function(){

  function toad(){
    const src= "http://apod.nasa.gov/apod/image/9712/orionfull_jcc_big.jpg";
    $(".ben").css("background-image", "url(" + src + ")");
    $(".ben > img").remove();
  };

setTimeout(toad,2000);

});



</script>

</html>
