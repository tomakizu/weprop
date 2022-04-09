<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript" src="common/js/quill.js"></script>
    <script type="text/javascript" src="common/js/quill.min.js"></script>
    <link type="text/css" rel="stylesheet" href="common/css/quill.snow.css" />
</head>
<style media="screen">
.standalone-container {
  margin: 50px auto;
  max-width: 720px;
}
#snow-container {
  height: 350px;
}
</style>
<body>
    <div class="standalone-container">
      <div id="snow-container"></div>
    </div>
</body>
<script>
var quill = new Quill('#snow-container', {
    placeholder: '在此輸入內容...',
    theme: 'snow'
});
</script>
</html>
